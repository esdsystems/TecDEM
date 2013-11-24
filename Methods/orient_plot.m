function orient_plot(varargin)

tind_basin = evalin('base','tind_basin');
dir = [];
len = [];
x = [];
y = [];

tecfig = evalin('base','tecfig');
pos=get(tecfig,'Position');

prompt={'Rose Plot for which basin no.'};
name='Enter Basin No.';
numlines=1;
defaultanswer={'0'};

answer=inputdlg(prompt,name,numlines,defaultanswer);
answer  = strcat('[',answer{:},']');
answer = eval(answer);

if answer == 0
    for i = 1:1:length(tind_basin)

        [x1 y1] = pol2cart(deg2rad(tind_basin(i).Tdir),tind_basin(i).Tind);

        x = [x;x1];
        y = [y;y1];

    end
    add_histroy({'Polar diagram of orientation and T Index vectors are plotted for all basins.'});
else

    for i = 1:1:length(answer)
        
    [x1 y1] = pol2cart(deg2rad(tind_basin(answer(i)).Tdir),tind_basin(answer(i)).Tind);
    x = [x;x1];
    y = [y;y1];
    end
    add_histroy({strcat('Polar diagram of orientation and T Index vectors are plotted for basin no. ',num2str(answer))});
end

if ~isempty(x)
    fig = figure('Units','Pixels','Name','Drainage Basin Asymmetry','NumberTitle','off');
    hold on
    theta = 0:pi/50:2*pi;

    plot(sin(theta),cos(theta),'-k','LineWidth',2)
    fill(sin(theta),cos(theta),'w')
    plot([-1 1],[0 0],'--k')
    plot([0 0],[-1 1],'--k')

    text(-0.01,1.1,'0')
    text(1.05,0,'90')
    text(-1.2,0,'270')
    text(-0.08,-1.1,'180')
    xlim([-1 1])
    ylim([-1 1])
    axis square off


    plot(x,y,'o')

    plot(0,0,'+r')
    box on
    set(fig,'Position',[pos(1)+100 pos(2) 350 300]);
    view(90,-90)
else
    msgbox('No data available','Data Error')
end
