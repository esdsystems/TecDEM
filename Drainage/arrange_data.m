function [u,v, logarea, logslope] = arrange_data(s,no)

u (:,1) = s.elevation;
u (:,2) = s.len*1000;

u1=u(:,1);

n=no;
u1=[u1(1)*ones(n,1); u1];
v=filter(ones(1,n)/n,1,u1);
v(1:n)=[];
u1(1:n)=[];
[logarea, logslope] = smooth_cluster(s.area,u,v);
u = u./1000;

