function [alpha len]=ind2ang(r,from,to)

[yy, xx] = ind2sub(r,to);
[yyf, xxf] = ind2sub(r,from);
alpha=(atan(-1*(yy-yyf)./(xx-xxf))*180/pi);

alpha = alpha + 90*(1-sign(alpha))+90*(1+sign(yy-yyf))-(1+sign(xx-xxf)).*(1-abs(sign(yy-yyf)))*90;

len = sqrt(2)*abs((yy-yyf)./(xx-xxf));

len(isinf(len)) = 1;
len(len== 0) = 1;
clc