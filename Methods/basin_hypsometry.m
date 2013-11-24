function basin_hypsometry(varargin)

ret = basin_hack();

if ret == 0
    return
else

    tecfig = evalin('base','tecfig');
    pos=get(tecfig,'Position');

    try

        hypfig = evalin('base','hypfig');
        figure(hypfig)
        set(hypfig ,'Name','Hypsometric Integral Plot','NumberTitle','off');
        set(hypfig,'Position',[pos(1) pos(2) 550 400]);

    catch

        hypfig = figure('Units','Pixels','Name','Hypsometric Integral Plot','NumberTitle','off');
        set(hypfig,'Position',[pos(1) pos(2) 550 400]);
        assignin('base','hypfig',hypfig)

    end

    set(gcf,'MenuBar','figure','CloseRequestFcn',@close_basin1)
    set(gcf,'ToolBar','figure')

    file_manu = uimenu(hypfig,'Label','Plot');

    mnuopenproject =  uimenu(file_manu,'Label','Composite','Callback',@hyp_comp);
    mnuopenproject =  uimenu(file_manu,'Label','Moments','Callback',@hyp_comparison);

    cl = get(gcf,'Color');

    hp = uipanel('BackgroundColor',cl,'Position',[.8 .03 .15 .95]);

    pos = get(gcf,'Position');

    tst = uicontrol('Style','text','String','Basin No.','Units','normalized', 'Position',[.81 .92 .13 .05],'BackgroundColor',cl);
    ListBox = uicontrol('Style','ListBox','String','','Units','normalized', 'Position',[.81 .05 .13 .88],'CallBack', @ListBoxCallBack);

    try

        hyp_basin = evalin('base','hyp_basin');
        set(ListBox,'String',num2str([1:1:length(hyp_basin)]'));

        strax = axes('Parent',gcf,'Position',[.1 .1 .6 .8]);
        set(strax,'DataAspectRatioMode','Manual','PlotBoxAspectRatioMode','Manual','Visible','Off')

        assignin('base','hypfig',hypfig);

        ListBoxCallBack();
    catch
        
        close(gcf);
        msgbox('No basins exists for analysis','Error')
        return
    end
end
    function ListBoxCallBack(varargin)

        num = get(ListBox, 'Value');
        inside_hypso(num);

    end

end