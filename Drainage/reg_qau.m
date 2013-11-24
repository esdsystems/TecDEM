function [Ks]=reg_qau(x,y,bnew)


sumy = sum(y);
n = length(y);

sumx = sum(x);
sumxy = sum(x.*y);
sumx2 = sum(x.*x);
% 
% B = [sumy; sumxy]';
% A = [n sumx ; sumx sumx2];
% % 
% xa= B/A


% 
% a = xa(1);
%  bnew = xa(2);
% 
% yc = a + bnew * x;

a = (sumy - bnew*sumx)/n;

Ks = 10^a;
