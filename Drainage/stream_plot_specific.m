function stream_plot_specific(varargin)

info  = evalin('base','info');
stream  = evalin('base','stream');

% curr_val  = evalin('base','curr_val');

try
    curr_val  = evalin('base','curr_val');
catch
    curr_val = 1;
end

try
    col = evalin('base','col');
catch
    col = ['r';'c';'m'; 'y'; 'k';'w'];
end

% Draw a maximized figure -----------------------------------------------

% screenxy=get(0,'MonitorPositions');
%
% x1 = screenxy(1);
% y1 = screenxy(2);
% x2 = screenxy(3);
% y2 = screenxy(4);
%
% screenxy = [x1 y1 x2 y2];
screenxy = [323    70   560   680];

log_fig = figure('Units','Pixels','Name','Final Results of Stream Profile Analysis','NumberTitle','off', 'OuterPosition',screenxy);
pos=get(log_fig,'Position');
pos(1) = 6;
pos(2) = pos(2)-50;
set(log_fig,'Position',pos);

title('LOG AREA SLOP GRAPH','fontsize',12,'fontweight','b');
assignin('base','log_fig',log_fig);

%------------------------------------------------------------------------


try
    x1 = stream(curr_val).u(:,2);
    y1 = stream(curr_val).v;
    x2 = stream(curr_val).u(:,2);
    y2 = stream(curr_val).area;

       
    figure(log_fig);

    add_histroy({'Result window for stream profile analysis displayed.'});
    
    subplot(2,1,1);

    in = [stream(curr_val).knickpoint];

    ot = unique(stream(curr_val).bit);
    ot(1) = [];

    locsmin = [];
    locsmax = [];

    for i = 1:1:length(ot)
        res=find(stream(curr_val).bit == ot(i));
        locsmin = [locsmin, min(res)];
        locsmax = [locsmax, max(res)];
    end

    plotx(x1,y1,x2,y2,x1(in),y1(in),locsmin,locsmax);
    title(strcat('Longitudinal and Area Profile for Stream No. ',num2str(curr_val)),'FontSize',13);

    d = unique(stream(curr_val).bit);

    d(1) = [];

    subplot(2,1,2);
    %

    slopeareapt=plot(stream(curr_val).logarea,stream(curr_val).logslope,'g+');
    title(strcat('Slope-Area Data for Stream No. ',num2str(curr_val)),'FontSize',13);
    xlabel('Log Area','FontSize',11);
    ylabel('Log Slope','FontSize',11);
    xx = get(gca,'xlim');
    yy = get(gca,'ylim');


    ys1 = (yy(2)-yy(1))/3;
    ys2 = (yy(2)-yy(1))/4;
    ys3 = (yy(2)-yy(1))/6;


    for j = 1:1:length(d)
        i = d(j);
        xs = i*2*abs((xx(2)-xx(1)))/(15);

        ind = find(stream(curr_val).bit == i);

        x2 = stream(curr_val).logarea(ind);

        y2 = stream(curr_val).m1(i)+stream(curr_val).m2(i)*x2;
        hold on

        try
            cl = col(i);
        catch
            cl = 'k';
        end

        bestfit=plot(x2,y2,strcat('-',cl),'LineWidth',2);

        theta = strcat('\theta = ', num2str(round((-stream(curr_val).m2(i))*100)/100));

        %     pow = round(log10(stream(curr_val).Ks(i)));

        %     Ks = strcat('Ks = ', num2str(round((stream(curr_val).Ks(i)) / 10^(pow-2))/100));

        Ks = strcat('Ksn = ', num2str(round((stream(curr_val).Ks(i))*100)/100));

        %     if pow < 10
        %
        %         Ks = strcat(Ks,'10^');
        %         Ks = strcat(Ks,num2str(pow));
        %     else
        %         Ks = strcat(Ks,'*10^');
        %         Ks = strcat(Ks,num2str(floor(pow/10)));
        %         Ks = strcat(Ks,'^');
        %         Ks = strcat(Ks,num2str(pow-(floor(pow/10) * 10)));
        %     end

        Y = strcat('y = ', num2str(round((stream(curr_val).m1(i))*100)/100));

        Y = strcat(Y , num2str(round((stream(curr_val).m2(i))*100)/100));

        Y = strcat(Y , 'x');

        Y = strcat('Trend No. ', num2str(j));

        text(xx(1)+xs(1),yy(1)+ys1,Y,'FontSize',10);
        text(xx(1)+xs(1),yy(1)+ys2,theta,'FontSize',12);
        text(xx(1)+xs(1),yy(1)+ys3,Ks,'FontSize',12);

    end

    %     try
    %         legend([slopeareapt bestfit],'Slope Area Data', 'Linear Regression')
    %     catch
    %         msgbox('Not enough data to plot')
    %     end

catch
    msgbox('Please firt apply stream profile analysis','Error')
    uiwait
    return
end

end