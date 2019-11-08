function [x_re,y_re] = Resemblance(x_base,y_base,x_mod,y_mod)
x_re = x_base;
m = length(x_base);
y_re = zeros([1,m]);
for p = 1:(m-1)
    if x_mod(p)<x_base(end)
        for q = 1:m
            if x_re(q)>x_mod(p) & x_re(q)<x_mod(p+1)
                slope = (y_mod(p+1)-y_mod(p))/(x_mod(p+1)-x_mod(p));
                y_re(q) = slope*(x_re(q)-x_mod(p))+y_mod(p);
            end
        end
    end
end
end
