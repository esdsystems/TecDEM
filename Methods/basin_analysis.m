function basin_analysis(varargin)

try

    td = evalin('base','td');

    load_grid_base('base',strcat(num2str(td),'BSN'))

    grd = evalin('base','basinmatrix');
    boundary = evalin('base','boundary');

catch
    msgbox('No Grid for display','Error');
    return
end
load_grid_base('base','DEM');
tecfig = evalin('base','tecfig');
pos=get(tecfig,'Position');

try
    tindfig  = evalin('base','tindfig');
    figure(tindfig)

    set(tindfig ,'Name','Drainage Basin Asymmetry','NumberTitle','off','MenuBar','none','CloseRequestFcn',@close_basin);
    set(tindfig,'Position',[pos(1) pos(2) 550 400]);
catch

    tindfig = figure('Units','Pixels','Name','Drainage Basin Asymmetry','NumberTitle','off','MenuBar','none','CloseRequestFcn',@close_basin);


    set(tindfig,'Position',[pos(1) pos(2) 550 400]);

    assignin('base','tindfig',tindfig)


    identify_manu  = uimenu(tindfig,'Label','Identify');

    mnuriver =  uimenu(identify_manu ,'Label','Main Stream','Callback',@find_channel);
    mnumidline=  uimenu(identify_manu,'Label','Basin Midline','Callback',@extract_convert_vector);
    mnuriver =  uimenu(identify_manu ,'Label','Exit','Callback',@close_basin,'Separator','on');

    Tind_manu  = uimenu(tindfig,'Label','Caculate');
    mnutindex=  uimenu(Tind_manu,'Label',' T Index','Callback',@extract_tindex);
%     mnutindex=  uimenu(Tind_manu,'Label',' Curvature Matrix','Callback',@curvature_calc);


    plot_manu  = uimenu(tindfig,'Label','Plot');
    mnutindex=  uimenu(plot_manu,'Label','Asymmetry Map','Callback',@asymmetry_map);
    mnutindex=  uimenu(plot_manu,'Label','Rose Diagram','Callback',@rose_plot);
    mnutindex=  uimenu(plot_manu,'Label','Polar Diagram','Callback',@orient_plot);



    cl = get(gcf,'Color');

    hp = uipanel('BackgroundColor',cl,'Position',[.8 .03 .15 .95]);

    pos = get(gcf,'Position');

    tst = uicontrol('Style','text','String','Basin No.','Units','normalized', 'Position',[.81 .92 .13 .05],'BackgroundColor',cl);
    ListBox = uicontrol('Style','ListBox','String','','Units','normalized', 'Position',[.81 .05 .13 .88],'CallBack', @ListBoxCallBack);

    set(ListBox,'String',num2str([1:1:length(boundary)]'));

    strax = axes('Parent',gcf,'Position',[.1 .1 .6 .8]);
    set(strax,'DataAspectRatioMode','Manual','PlotBoxAspectRatioMode','Manual','Visible','Off')

    assignin('base','tindfig',tindfig);
end
ListBoxCallBack();

    function ListBoxCallBack(varargin)

        num = get(ListBox, 'Value');
        inside_tindex_call1(num);

    end

end
