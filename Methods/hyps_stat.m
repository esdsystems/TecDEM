function [m s sk ku] = hyps_stat(x,y,n)
% Functions to calculate hypsometric statistics.
% Faisal Shahzad
% Freiberg, Germany, 12-11-2009

p = polyfit(x,y,n);

p = fliplr(p);

A = 0;

for k = 0:1:n
    
    A = A+ (p(k+1)/(k+1));
    
end


m =mean(y);
s = std(y);
sk = skewness(y);
ku = kurtosis(y);