function hack_plot_cont_profile(varargin)

try
    info = evalin('base','info');
catch
    msgbox('No data to export', 'Error')
    return
end

stream  = evalin('base','stream');
dno =inputdlg('Enter Stream No.','Input',1,{'1'});

if isempty(str2double(dno))
    return
end

screenxy=get(0,'MonitorPositions');
% x1 = screenxy(1);
% y1 = screenxy(2);
% x2 = screenxy(3);
% y2 = screenxy(4);
% screenxy = [x1 y1 x2 y2];

fig = figure('Units','Pixels','Name','Hack Stream Gradient','NumberTitle','off');
dno = str2double(dno);


%     x1 = stream(dno).u(:,2);
%     y1 = stream(dno).v;

x1 = stream(dno).len;
y1 = stream(dno).elevation;

ind = [stream(dno).hack_cont(1,:) length(stream(dno).lat)];

plot(x1,y1,'k-');
title(strcat('Hack Stream Gradient Index for Stream No. ',num2str(dno)),'FontSize',13);
xlabel('Stream Length(km)','FontSize',11);
ylabel('Stream Elevation(m)','FontSize',11);

hold on
for j = 1:1:length(ind)-1
    in = ind(j):1:ind(j+1);
    xn = x1(in);
    yn = y1(in);
    area(xn, yn);

    text(xn(1),min(y1),strcat('Avg SL=', num2str(round(stream(dno).hack_cont(2,j)))));
    %                         text(xn(1),min(y1),strcat('Avg SL=', num2str(stream(dno).i(j))))
    %
end
% catch
%
%     msgbox('Some Poblem with your Data Set','Error')
%     uiwait
%     return
% end
add_comments({'Result window for Hack index analysis displayed.'});
add_comm_line();



% ind = [stream(dno).hack_cont(1,:)]
% 
% plotyy(x1,y1,x1(ind),stream(dno).hack_cont(2,:));

end
