% Here is the Matlab live script that can be run to see the chi square 
%statistics when testing with the (60:50) data set

data = table2array(DoPhungHWPart2);
data = data(~isnan(data));
data_sorted_des = sort(data, 'descend');
target_abs = sort(data((1:60),:),'descend');
target_pre = sort(data((61:110),:),'descend');


[parG_pre] = fitdist(target_pre, 'gamma');
[h,  p, stats] = chi2gof(target_pre, 'CDF', parG_pre)

[parW_pre] = fitdist(target_pre, 'Weibull');
[h,  p, stats] = chi2gof(target_pre, 'CDF', parW_pre)

[parN_pre] = fitdist(target_pre, 'Nakagami');
[h,  p, stats] = chi2gof(target_pre, 'CDF', parN_pre)