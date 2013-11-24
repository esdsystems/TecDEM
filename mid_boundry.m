function [r c]= export_mid_boundry(boundary)

x = boundary.ibr;

y = boundary.ibc;

Ar = 0;

for i = 1:1:length(x)-1
    
    Ar = Ar + ((x(i)*y(i+1)) - (x(i+1)*y(i)));
    
end

Ar = Ar /2;

cx = 0;
cy = 0;

for i = 1:1:length(x)-1
    
    cx = cx + (x(i)+x(i+1)) * ((x(i)*y(i+1)) - (x(i+1)*y(i)));
    cy = cy + (y(i)+y(i+1)) * ((x(i)*y(i+1)) - (x(i+1)*y(i)));
    
end

r = round(cx /(6*Ar));
c = round(cy /(6*Ar));