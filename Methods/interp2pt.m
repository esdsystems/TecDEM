function [nx ny] = interp2pt(pt1,pt2)

x = [pt1(1) pt2(1)];
y = [pt1(2) pt2(2)];

dx = x(2)-x(1);
dy = y(2)-y(1);

m = dy/dx;

if y(2) > y(1)
    ys = 1;
else
    ys = -1;
end

if x(2) > x(1)
    xs = 1;
else
    xs = -1;
end

if abs(dx) > abs(dy)
    nx = x(1):xs:x(2);
    ny = y(1) + m.*(nx-x(1));
else
    ny = y(1):ys:y(2);
    nx = x(1) + ((ny - y(1))./m);
end
nx = round(nx);
ny = round(ny);