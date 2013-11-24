function plot_grid_watershed(varargin)
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




prompt={'Thresh hold by Strahler order'};
name='Options for subbasin plot';
numlines=1;
defaultanswer={'3'};
typ=inputdlg(prompt,name,numlines,defaultanswer);

if isempty(typ)
    
    str_plt_hand = evalin('base','str_plt_hand');
    add_histroy({'Strahler order not specified to plot drainage basins.'});
    
    close(str_plt_hand)
    
    return
else
    lt = typ(1);
    lt = cell2mat(lt);
    
    td = str2num(lt);
end


load_grid_base('base',strcat(num2str(td),'BSN'))

% load_grid_base('base','BSN')
try
    plot_col  = evalin('base','plot_col')';
catch
    plot_col = ['k';'r'];
end



try
    grd = evalin('base','basinmatrix');
catch
    msgbox('No Grid for display','Error');
    return
end

try
    load_grid_base('base','stream');
    stream=evalin('base','stream');
catch
    stream = struct('lat',[],'lon',[],'x',[],'y',[],'len',[],'elevation',[],'rawelevation',[],'area',[],'bit',[],'knickpoint',[],'hack_cont',[],...
        'u',[],'v',[],'logarea',[],'logslope',[],'m1',[],'m2',[],'Ks',[]);
    stream(1) = [];
    
end



add_histroy({'Start plotting Drainage Basins.'});

str_plt_hand = evalin('base','str_plt_hand');
cl = get(str_plt_hand,'Color');
hp = uipanel('BackgroundColor',cl,'Position',[.05 .03 .7 .95]);

strax = axes('Parent',str_plt_hand,'Position',[.05 .06 .7 .9]);
set(strax,'DataAspectRatioMode','Manual','PlotBoxAspectRatioMode','Manual','Visible','Off')

hp = uipanel('BackgroundColor',cl,'Position',[.8 .03 .15 .95]);

pos = get(gcf,'Position');

tst = uicontrol('Style','text','String','Stream No.','Units','normalized', 'Position',[.81 .92 .13 .05],'BackgroundColor',cl);
ListBox = uicontrol('Style','ListBox','String','','Units','normalized', 'Position',[.81 .05 .13 .88],'CallBack', @ListBoxCallBack);

imagesc(grd)
colormap Jet
shading interp

axis image
set(gca,'YTick',[],'XTick',[])
hold on

boundary = evalin('base','boundary');

for i = 1:1:length(boundary)
    
    plot(boundary(i).ibc,boundary(i).ibr,'w');
    [ra ca]= mid_boundry(boundary(i));
    
    text(ca,ra,num2str(i))
    
end

try
    for i = 1:1:length(stream)
        
        plot(stream(i).y,stream(i).x,strcat('-',plot_col(2)),'LineWidth',2);
        text(stream(i).y(1),stream(i).x(1),strcat('',num2str(i)),'FontSize',13,'Color','k');
        
        
    end
    i = get(ListBox, 'Value');
    
    plot(stream(i).y,stream(i).x,strcat('-',plot_col(1)),'LineWidth',2);
    
    assignin('base','disptyp','grid');
    assignin('base','extractt',1);
    
    
    set(ListBox,'String',num2str([1:1:length(stream)]'));
    
    add_histroy({'Finished plotting Drainage Basins.'});
    
catch
end

assignin('base','ListBox',ListBox);
assignin('base','stream',stream);
assignin('base','strax',strax);
assignin('base','tp','basin');

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