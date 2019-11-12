Assignment 4:
Using the same old data set, obtaining the following
Receiver Operating Characteristic (ROC) curve
Optimal operating point (OOP) (where P_false_alarm is least and P_detection (when target is present) is most)
Positive predictive value (PPV) at OOP
Probability of False alarm (Pf) and probability of Detection (Pd) at OOP 
Performance index
OOP then became the best point to set the threshold at for the dataset, as seen in the last graph, the area under the curve which represent P_false_alarm and P_miss is the least (less than when using the intersection as threshold in assignment 3)
[status, sheets] = xlsfinfo("Do PhungHWPart2.xls");
[data, names, raw] = xlsread("Do PhungHWPart2.xls", 1);
data = data(~isnan(data));
data_sorted_des = sort(data, 'descend');
target_abs = sort(data((1:60),:),'descend');
target_pre = sort(data((61:110),:),'descend');

mean_abs = mean(target_abs);
mean_pre = mean(target_pre);
var_abs = var(target_abs);
var_pre = var(target_pre);
perf_ind = abs(mean_abs - mean_pre)/sqrt(var_abs+var_pre)

N0 = length(target_abs);
N1 = length(target_pre);
resp = [zeros(N0, 1); ones(N1, 1)];
[pf, pd, T, AUC, OPTOCPT]=perfcurve(resp, data, 1);
AUC

figure(1), plot(pf, pd, 'lineWidth', 1.5, 'Color',[1, 0, 0])
xlabel('Prob. False Alarm (Pf)')
ylabel('Prob. Detection (PD)')
title(['AUC = ', num2str(AUC)])
hold on
plot(OPTOCPT(1), OPTOCPT(2), 'or')
diff = 1000000 %2.103 is the intersection threshold 
for i = 1:length(data_sorted_des)
    if abs(data_sorted_des(i) - 2.103) < diff
        diff = data_sorted_des(i) - 2.103;
        x_int = data_sorted_des(i);
        int_index = i;
    end
end
thres_opt_pfplot = sqrt(OPTOCPT(1)^2 + (1-OPTOCPT(2))^2)
int_onAUC = [pf(int_index), pd(int_index)] ;
thres_int_pfplot = sqrt(int_onAUC(1)^2 + (1-int_onAUC(2))^2)
plot(int_onAUC(1), int_onAUC(2), 'xk')
plot(pf, pf, 'Color', [0 0 1])

legend('ROC','threshold (optimum): dist to top left corner = 0.3386',...
    'threshold (intersection): dist to top left corner = 0.3720', ...
    'Location', 'southeast')
text(0.5, 0.4, 'AUC = 0.8098, std. dev = 0.021581')
text(0.5, 0.35, 'Perform. Index = 0.8638')
hold off

figure(2)
xx_abs=0:0.25:1.2*max(target_abs);
xx_pre=0:0.25:1.2*max(target_pre);
pdf_abs=ksdensity(target_abs, xx_abs);
pdf_pre= ksdensity(target_pre, xx_pre);
plot(xx_abs, pdf_abs, '-r', 'LineWidth',1.5)
ylim([0 0.7])
xlim([0 8])

for i = 1:length(pf)
    if pf(i) == OPTOCPT(1) && pd(i) == OPTOCPT(2)
        opt_index_indatasorted = i
    end
end

thres_opt = data_sorted_des(opt_index_indatasorted)
hold on
plot(xx_pre, pdf_pre, '-k', 'LineWidth',1.5, 'LineStyle',"--")
hold on
diff2 = 1000;

for i = 1:length(xx_abs)
    if abs(xx_abs(i) - thres_opt) < diff2
        diff2 = abs(xx_abs(i) - thres_opt);
        opt_index_inpdfplot = i;
    end
end


area(xx_abs([1:opt_index_inpdfplot]), pdf_pre([1:opt_index_inpdfplot]), ...
    'FaceColor',"m", "FaceAlpha",0.7)
area(xx_pre(opt_index_inpdfplot:end-10), pdf_abs(opt_index_inpdfplot:end),...
    "FaceColor","c", "FaceAlpha", 0.6)
xlabel('input data'), ylabel('estmimated pdf') 

%opt_index_inpdfplot = find((pf==OPTOCPT(1)) and it is 64
legend('target absent', 'target present')
title(['threshold (optimum) = ', num2str(thres_opt)])

