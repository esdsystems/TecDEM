function side_stream=dstream(main_stream,side_stream)



b = [side_stream.lon, side_stream.lat, side_stream.elevation, side_stream.x, side_stream.y,side_stream.len, side_stream.area ];
c = [main_stream.lon, main_stream.lat, main_stream.elevation, main_stream.x, main_stream.y,main_stream.len, main_stream.area ];

cc = c(:,4:5);
bb = b(:,4:5);

d = 0;
i = 1;

while d == 0

    d = [d find(cc(i,1) == bb(:,1) & cc(i,2) == bb(:,2))];
    if sum(d) == 0
        i = i+1;
    end
end

g = sum(d);

g = g -1;
% plot(b(:,1),b(:,2),'k')
% hold on
% plot(c(:,1),c(:,2),'r-')
% 
% hold on

% side_stream = b(1:g,:);
side_stream.lon = b(1:g,1);
side_stream.lat = b(1:g,2);
side_stream.elevation = b(1:g,3);
side_stream.x = b(1:g,4);
side_stream.y = b(1:g,5);
side_stream.len = b(1:g,6);
side_stream.area = b(1:g,7);
side_stream.rawelevation = side_stream.rawelevation(1:g,:);

side_stream.u = side_stream.u(1:g,:);
side_stream.v =side_stream.v(1:g,:);
side_stream.logarea =side_stream.logarea(1:g,:);
side_stream.logslope=side_stream.logslope(1:g,:);
side_stream.bit=zeros(size(b(1:g,1)));

% 
% plot(nb(:,1),nb(:,2),'g-')