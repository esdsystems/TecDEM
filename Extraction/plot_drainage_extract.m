function plot_drainage_extract(varargin)
% This function is used to plot grid values i.e. digital elevation model or
% area grid.
% example:
%
% plot_grid('dem')
%
% plot_grid('area')
%
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com

try
    plot_col  = evalin('base','plot_col');
catch
    plot_col = ['k';'r'];
end
try
    load_grid_base('base','stream');
    stream=evalin('base','stream');
catch
    stream = struct('lat',[],'lon',[],'x',[],'y',[],'len',[],'elevation',[],'rawelevation',[],'area',[],'bit',[],'knickpoint',[],'hack_cont',[],...
        'u',[],'v',[],'logarea',[],'logslope',[],'m1',[],'m2',[],'Ks',[]);
    stream(1) = [];
    
end

% try

prompt={'Thresh hold by','value'};
name='Options for drainage plot';
numlines=1;
defaultanswer={'Strahler Order','1'};

color_strahler();
uiwait
add_histroy({'Start plotting Drainage Network.'});

str_plt_hand = evalin('base','str_plt_hand');
cl = get(str_plt_hand,'Color');
hp = uipanel('BackgroundColor',cl,'Position',[.05 .03 .7 .95]);

strax = axes('Parent',str_plt_hand,'Position',[.05 .06 .7 .9]);
set(strax,'DataAspectRatioMode','Manual','PlotBoxAspectRatioMode','Manual','Visible','Off')

assignin('base','strax',strax)
hp = uipanel('BackgroundColor',cl,'Position',[.8 .03 .15 .95]);

pos = get(gcf,'Position');

tst = uicontrol('Style','text','String','Stream No.','Units','normalized', 'Position',[.81 .92 .13 .05],'BackgroundColor',cl);
ListBox = uicontrol('Style','ListBox','String','','Units','normalized', 'Position',[.81 .05 .13 .88],'CallBack', @ListBoxCallBack);
r = evalin('base','r');
test = ones(r);
test(1,1) = 0;
imagesc(test)

colormap gray

axis image
set(gca,'YTick',[],'XTick',[])
hold on
% assignin('base','od',lt)
plot_streams();

try
    for i = 1:1:length(stream)
        
        plot(stream(i).y,stream(i).x,strcat('-',plot_col(2)),'LineWidth',2);
        
        text(stream(i).y(1),stream(i).x(1),strcat('',num2str(i)),'FontSize',13,'Color','k');
        
    end
    i = get(ListBox, 'Value');
    
    plot(stream(i).y,stream(i).x,strcat('-',plot_col(1)),'LineWidth',2);
    
    
    set(ListBox,'String',num2str([1:1:length(stream)]'));

catch
end


assignin('base','disptyp','grid');
assignin('base','extractt',1);

assignin('base','ListBox',ListBox);
assignin('base','tp','drainage');

% assignin('base','parea',area);


    function ListBoxCallBack(varargin)
        
        try
            plot_col  = evalin('base','plot_col');
        catch
            plot_col = ['k';'r'];
        end
        stream  = evalin('base','stream');
        for i = 1:1:length(stream)
            plot(stream(i).y,stream(i).x,strcat('-',plot_col(2)),'LineWidth',2);
            text(stream(i).y(1),stream(i).x(1),strcat('',num2str(i)),'FontSize',13,'Color','k');
            
        end
        
        i = get(ListBox, 'Value');
        strhand=plot(stream(i).y,stream(i).x,strcat('-',plot_col(1)),'LineWidth',2);
        
        assignin('base','curr_val',i);
        
        assignin('base','strhand',strhand);
        
    end;
end