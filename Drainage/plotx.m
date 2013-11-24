function plotx(x1,y1,x2,y2,xk,yk,locsmin,locsmax)


try
    col = evalin('base','col');
catch
    col = ['r';'c';'m'; 'y'; 'k';'w'];
end

plot(x1,y1,'-b','LineWidth',2);
xm1 = min(x1);
ym1 = min(y1);

xm2 = max(x1);
ym2 = max(y1);

xlim([xm1 xm2]);
ylim([ym1 ym2]);


ax(1)=gca;
set(ax(1),'XColor','k','YColor','k','box','off');
pos = get(ax(1),'Position');
ax(2)=axes('Position',pos,'XAxisLocation','top','YAxisLocation','right', 'Color','none','XColor','k','YColor','k','box','off');

line(x2,y2,'Color','g','LineStyle','-');
axis tight

set(get(ax(1),'xlabel'),'string','Distance(km)','FontSize',11)


set(get(ax(2),'ylabel'),'string','Area(km^2)','FontSize',11)
set(get(ax(1),'ylabel'),'string','Elevation (m)','FontSize',11)

axes('Position',pos,'Color','none','XColor','k','YColor','k');
hold on


for i = 1:1:length(locsmin)
    
      try
            cl = col(i);
        catch
            cl = 'k';
      end
        
      
    xk1=x1(locsmin(i):locsmax(i));
    yk1=y1(locsmin(i):locsmax(i));
    
    plot(xk1,yk1,strcat('-',cl),'LineWidth',2);
%     
end
plot(xk,yk,'r+',xk,yk,'kd');
xlim([xm1 xm2]);
ylim([ym1 ym2]);