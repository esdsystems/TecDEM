function [xint yint midxx midyy T ang]=Tindex_intersections(x,y,ra,ca,ptx1,pty1,ptx2,pty2, midxx,midyy,nc)

m = -(ptx2 - ptx1)/(pty2 - pty1);
xa = [0:nc];
ya = m * (xa - midxx) + midyy;

[xint,yint] = intersections(xa,ya,x,y);
[xa1,ya1] = intersections(xa,ya,ra,ca);


if ~isempty(xint)
    xint = xint;
    yint = yint;
else
    xint = NaN;
    yint = NaN;
end

if ~isempty(xa1)
    xa1 = xa1(1);
    ya1 = ya1(1);
else
    xa1 = NaN;
    ya1 = NaN;
end


if and(~isempty(xint),~isempty(xa1))

    da = sqrt((midxx-xint).^2 + (midyy-yint).^2);
    dd = sqrt((midxx-xa1).^2 + (midyy-ya1).^2);
    T = da./dd;

    [T i]= min(T);
    xint = xint(i);
    yint = yint(i);
    
  
    ang = rad2deg(atan2((yint(1)-midyy),(xint(1)-midxx)))+90;

    if ang < 0
        ang = ang +360;
    end

end


% if and(~isempty(xint),~isempty(xa1))
%
%     ang = rad2deg(atan2((yint(1)-midyy),(xint(1)-midxx)))+90;
%
%     if ang < 0
%         ang = ang +360;
%     end
%     da = sqrt((midxx-xint(1))^2 + (midyy-yint(1))^2);
%     dd = sqrt((midxx-xa1(1))^2 + (midyy-ya1(1))^2);
%     T = da/dd;
% end

