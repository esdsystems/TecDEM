function inside_tindex_call1(num)
try
tind_basin = evalin('base','tind_basin');
catch
end

netwk_order_ind = evalin('base','netwk_order_ind');
str_net = evalin('base','str_net');

boundary = evalin('base','boundary');
curvature = evalin('base','curvature');

td = evalin('base','td');


bsnd = netwk_order_ind(td);
plt = str_net(bsnd.ind(num));

bval = round(num);
[r1 r2 c1 c2 nxb nyb] = find_bbox(boundary(bval));

cla;

plot(boundary(bval).ibc,boundary(bval).ibr,'w','LineWidth',2);
set(gca,'xlim',[c1 c2],'ylim',[r1 r2]);
ax_ratio=get(gca,'DataAspectRatio');

imagesc(curvature);
hold on
plot(boundary(bval).ibc,boundary(bval).ibr,'w','LineWidth',2);
set(gca,'xlim',[c1 c2],'ylim',[r1 r2])
set(gca,'DataAspectRatio',ax_ratio);
assignin('base','cur_base',bval);

xlabel('Longitude','FontSize',10);
ylabel('Latitude', 'FontSize',10);
ttl =  strcat('Basin No. ', num2str(num));
title(ttl, 'FontSize',13);

try
    plot(tind_basin(bval).xr,tind_basin(bval).yr,'r','LineWidth',2);
catch
end

try
    plot(tind_basin(bval).xm,tind_basin(bval).ym,'k','LineWidth',2);
catch
end

try
    [r c] = size(tind_basin(bval).Tvec);
    for i = 1:1:r
        
    arrow([tind_basin(bval).Tvec(i,3) tind_basin(bval).Tvec(i,4)],[tind_basin(bval).Tvec(i,1) tind_basin(bval).Tvec(i,2)],'Length',6);
    
    end
catch
end

plot(plt.colid,plt.rowid,'w','lineWidth',2);

add_histroy({strcat('Basin No. ', num2str(num),' is currently activated.')});