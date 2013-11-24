function stream_profile_analysis(varargin)

try

    info  = evalin('base','info');
    stream  = evalin('base','stream');
    %     strax  = evalin('base','strax');
    curr_val = 1;
    assignin('base','curr_val',curr_val);
    assignin('base','no',20);
catch
    
    msgbox('No Data to Plot','Error')
    uiwait
    return
end

add_comments({'Stream profile analysis started.'});


try
    logfig = evalin('base','logfig');
    figure(logfig)
    set(logfig,'MenuBar','none','Name','Stream Profile Analysis','NumberTitle','off');
    set(logfig,'MenuBar','none','CloseRequestFcn',@close_profile);

catch

    logfig = figure('Units','Pixels','Name','Stream Profile Analysis','NumberTitle','off');
    set(logfig,'MenuBar','none','CloseRequestFcn',@close_profile);
    tecfig = evalin('base','tecfig');
    pos=get(tecfig,'Position');
    set(logfig,'Position',[pos(1) pos(2) 550 400 ]);


    mnuplot =  uimenu(logfig,'Label','Plot');
    mnuopenproject =  uimenu(mnuplot,'Label','Longitudinal Profile','Callback',@stream_slope_plots);
    mnuopenproject =  uimenu(mnuplot,'Label','Area vs. Slope ','Callback',@area_slope_plot);
    mnuopenproject =  uimenu(mnuplot,'Label','Map View ','Callback',@mapview_plot);
    mnuopenproject =  uimenu(mnuplot,'Label','Color Coding','Callback',@color_coding,'Separator','on');
    mnuopenproject =  uimenu(mnuplot,'Label','Exit','Callback',@close_loglog,'Separator','on');

    file_manu = uimenu(logfig,'Label','Trends');
    mnuopenproject =  uimenu(file_manu,'Label','Select Trend','Callback',@get_coords);
    mnuopenproject =  uimenu(file_manu,'Label','Delete Specific Trend','Callback',@delete_coords);
    mnuopenproject =  uimenu(file_manu,'Label','Delete All Trends','Callback',@delete_all_trends);

    mnuresults = uimenu(logfig,'Label','Results');
    mnuopenproject =  uimenu(mnuresults,'Label','Preview Results','Callback',@stream_plot_specific);

end


    function get_coords(h, eventdata)

        antyp = evalin('base','antyp');


        if strcmp(antyp,'prof')

            get_coords_prof();

        elseif strcmp(antyp,'loglog')

            get_coords_loglog();

        else
            get_coords_map();
        end
    end

    function get_coords_loglog(h, eventdata)

        no = evalin('base','no');
        [c,r] = ginput(2);
        assignin('base','c',c);
        extraction();
        %         stream_specific(no);
        regressing();
        uiwait
        area_slope_plot();
    end

    function get_coords_prof(h, eventdata)

        no = evalin('base','no');
        [c,r] = ginput(2);
        assignin('base','c',c);
        extraction_profile();
        stream_specific_profile(no);
        regressing();
    end

    function get_coords_map(h, eventdata)

        no = evalin('base','no');
        [c,r] = ginput(2);
        assignin('base','c',c);
        extraction_map();
        stream_specific_map(no);
        regressing();
    end

assignin('base','logfig',logfig);
% set(gcf,'CloseRequestFcn',@close_profile)
end