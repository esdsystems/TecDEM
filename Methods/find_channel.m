function find_channel(varargin)
try

    tind_basin = evalin('base','tind_basin');
    
catch
    
end
boundary = evalin('base','boundary');
bval = evalin('base','cur_base');
r = evalin('base','r');
% inside_tindex_call(bval);

[sc sr] = ginput(1);

sr = round(sr);
sc = round(sc);
hold on

to = sub2ind(r,sr,sc);
output = extract_stream_tind(to);
[ra ca]=ind2sub(r,output);
pthnd=plot(ca,ra,'r','LineWidth',2);

i = 1;

while i
    [sc sr bt] = ginput(1);

    if bt == 1

        set(pthnd,'visible','off');
        sr = round(sr);
        sc = round(sc);
        hold on
        to = sub2ind(r,sr,sc);
        output = extract_stream_tind(to);
        [ra ca]=ind2sub(r,output);
        pthnd=plot(ca,ra,'r','LineWidth',2);

    else

        i = 0;

    end
end

xr = ca;
yr = ra;
% x = boundary(bval).ibc;
% y = boundary(bval).ibr;

% [a b]=intersections(ca,ra,x,y);
% 
% pour_c = round(a(1));
% pour_r = round(b(1));
% 
% in = find(and(ca == pour_c,ra == pour_r));
% %
% xr = ca(1:in(1));
% yr= ra(1:in(1));
%
hold on

plot(xr,yr,'r-','LineWidth',2);

add_histroy({strcat('Main stream for basin no.',num2str(bval),' is identified')});
% bbox = tind_basin(bval).bbox;
% 
% r1 = bbox(1);
% c1 = bbox(2);
% r2 = bbox(3);
% c2 = bbox(4);
% 
% nxr = xr - c1+1;
% nyr = yr - r1+1;
% 
% 
% nxb = tind_basin(bval).ibc - c1+1;
% nyb = tind_basin(bval).ibr - r1+1;
% 
% cdata = ones(r2-r1+1,c2-c1+1);
% 
% for i = 1:1:length(nxb)
% 
%     cdata(round(nyb(i)),round(nxb(i))) = 0;
% end
% 
% % figure;
% cla
% imagesc(cdata)
% colormap gray
% hold on
% plot(nxr,nyr,'g')
% plot(nxb,nyb,'k')
% axis image
% box on
% 
tind_basin(bval).xr = xr';
tind_basin(bval).yr = yr';

% tind_basin(bval).xmr = nxr';
% tind_basin(bval).ymr = nyr';
% 
% tind_basin(bval).xmb = nxb;
% tind_basin(bval).ymb = nyb;
% 
% tind_basin(bval).cdata = cdata;
% 
assignin('base','tind_basin', tind_basin);
% 
% 
% 
% 
% 
% 
% 
% 
