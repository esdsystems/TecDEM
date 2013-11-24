function out = convert_grid(val,method)

ind =find(val~= -9999);
v=val(ind);
[r c] = ind2sub(size(val),ind);
d = size(val);
x = 1:1:d(2);
y = 1:1:d(1);
[x1 y1]=meshgrid(x,y);

out=griddata(c,r,v,x1,y1,method);