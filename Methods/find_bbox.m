function [r1 r2 c1 c2 nxb nyb] = find_bbox(boundary)

r1 = min(boundary.ibr);
r2 = max(boundary.ibr);

c1 = min(boundary.ibc);
c2 = max(boundary.ibc);

nxb = boundary.ibc - c1+1;
nyb = boundary.ibr - r1+1;
