function [logarea, logslope] = smooth_cluster(data,u,v)

f=diff(v);
g=diff(u(:,2));
h=-f./g;
h = round_2p(h);
logslope=log10(h);
A = data*1000000;
A(1)=[];
logarea=log10(A);
% 
% logslope(logslope <= -4) = max(logslope);
