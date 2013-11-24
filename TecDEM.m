function TecDEM(varargin)

try
    tecfig = evalin('base','tecfig');
    figure(tecfig)
catch
    try
        
        %         splash(3);
        
    catch
    end
    evalin ('base', 'clear all');
    
    % Draw a figure -----------------------------------------------
    
    screenxy=get(0,'MonitorPositions');
    
    x1 = screenxy(1);
    y1 = screenxy(2);
    x2 = screenxy(3);
    y2 = screenxy(4);
    
    fig = figure('Units','Pixels','Name','TecDEM 2.0: Tectonics from Digital Elevation Model','NumberTitle','off',...
        'Resize','off','closeRequestFcn',@close_window);
    pos = get(fig,'Position');
    
    set(fig,'Position',[pos(1) pos(2)-100 pos(3)-50 500]);
    
    
    %Menu Bar ---------------------------------------------------------------
    
    set(fig,'MenuBar','none');
    
    %   File Menu and Sub Items
    
    file_manu = uimenu(fig,'Label','File');
    
    mnuopenproject =  uimenu(file_manu,'Label','Open Project','Callback',@open_data_set,'Accelerator','o');
    mnuimportdem =  uimenu(file_manu,'Label','Import DEM','Callback',@load_dem_info, 'Accelerator','I');
    %     prsetting =  uimenu(file_manu,'Label','Settings','Callback',@project_setting,'Separator','on','Accelerator','S');
    
    prexport =  uimenu(file_manu,'Label','Export','Callback',@export_results, 'Accelerator','E');
    
    alog  = uimenu(file_manu,'Label','Save Activity log','Callback',@work_log_save);
    
    exit = uimenu(file_manu,'Label','Exit','Separator','on','Callback',@close_window , 'Accelerator','X');
    
    
    %   Drainage Extraction Menu and Sub Items
    
    process_manu = uimenu(fig,'Label','Process');
    demfill =  uimenu(process_manu,'Label','1. Depression Fill','Callback',@fill_dem, 'Accelerator','1');
    d8algo =  uimenu(process_manu,'Label','2. Flow Grid (D8)','Callback',@gridding_full, 'Accelerator','2');
%     strahler_algo =  uimenu(process_manu,'Label','3. Link File','Callback',@link_file, 'Accelerator','3');
    flowarea =  uimenu(process_manu,'Label','3. Contributing Area','Callback',@upslope_area2, 'Accelerator','3');

    strapath =  uimenu(process_manu,'Label','Drainage Network Extraction','Callback',@strahlere_segments, 'Accelerator','R','Separator','on');
    flowpath =  uimenu(process_manu,'Label','Watershed Extraction','Callback',@catchment_boundary,'Accelerator','Y');
    
    
    %   Display Menu and Sub Items
    
    display_manu = uimenu(fig,'Label','Display');
    demplot = uimenu(display_manu,'Label','Digital Elevation Model','Callback',@stream_plot_full_DEM, 'Accelerator','D');
    streamplot = uimenu(display_manu,'Label','Drainage Network','Callback',@stream_plot_full_DN, 'Accelerator','N');
    subbainsplot = uimenu(display_manu,'Label','Watershed Boundaries','Callback',@stream_plot_full, 'Accelerator','B');
    %     mulplot = uimenu(display_manu,'Label','Multi Layer Plot','Callback',@multi_plot,'Separator','on', 'Accelerator','M');
    
    %   Analysis Menu and Sub Items
    
    a_manu = uimenu(fig,'Label','Analyze');
    
    str_manu = uimenu(a_manu,'Label','Stream Profiles');
    knickpoint = uimenu(str_manu,'Label','Knickpoints Selection','Callback',@knickpoints_selection);
    spanalysis = uimenu(str_manu,'Label','Concavity & Steepness Index','Callback',@stream_profile_analysis);
    hack_smooth = uimenu(str_manu,'Label','Hack Gradient Index','Callback',@stream_gradient);
    
    
    %     cs_manu = uimenu(a_manu,'Label','Cross Sections',@cross_section_full);
    
    
    spst_manu = uimenu(a_manu,'Label','Spatial Statistics');
    isobasesmooth = uimenu(spst_manu,'Label','Isobase Map','Callback',@isobase_map);
    incisionmap= uimenu(spst_manu,'Label','Incision Map','Callback',@incision_map);
    ddmap= uimenu(spst_manu,'Label','Drainage Density Map','Callback',@drainage_density);
    verdissmnu = uimenu(spst_manu,'Label','Vertical Dissection','Callback',@vertical_dissection);
    
    bsn_manu = uimenu(a_manu,'Label','Basins');
    basinassmmnu = uimenu(bsn_manu,'Label','Basin Asymmetry','Callback',@basin_asymmetry);
    %     basinshpmnu= uimenu(bsn_manu,'Label','Valley Shape','Callback',@vertical_diss);
    basin_hypmnu = uimenu(bsn_manu,'Label','Hypsometric Integral','Callback',@basin_hypsometry);
    
    
    results_manu = uimenu(fig,'Label','Results');
    reports_manu = uimenu(results_manu,'Label','Reports');
    profiles_manu = uimenu(results_manu,'Label','Profiles');
    grids_manu = uimenu(results_manu,'Label','Maps');
    
    rpdetailed = uimenu(reports_manu,'Label','Detailed Statistics','Callback',@full_report);
    rpdetailed = uimenu(reports_manu,'Label','Complete Tabulated','Callback',@table_report);
    rpspecific =  uimenu(profiles_manu,'Label','Stream Profile Analysis','Callback',@sp_plot);
    rphack =  uimenu(profiles_manu,'Label','Hack Index Analysis','Callback',@hack_plot_cont_profile);
    
    grdisobase =  uimenu(grids_manu,'Label','Isobase Map','Callback',@plot_isobase_map);
    grdincision =  uimenu(grids_manu,'Label','Incision Map','Callback',@plot_incision_map);
    ddmap =  uimenu(grids_manu,'Label','Drainage Density  Map','Callback',@plot_density_map);
    vdmap =  uimenu(grids_manu,'Label','Vertical Dissection Map','Callback',@plot_vd_map);
    basmap =  uimenu(grids_manu,'Label','Basin Asymmetry  Map','Callback',@asymmetry_map);
    
    
    helpp = uimenu(fig,'Label','Help');
    
    uimenu(helpp,'Label','Contents','Callback',@Contents);
    uimenu(helpp,'Label','About TecDEM','Separator','on','Callback',@aboutus);
    
    
    s(1) = {('============================================')};
    dispout=uicontrol(fig,'Units','normalized','Position',[0,0,1,1],'Style','edit','Max',100,'String',s, 'HorizontalAlignment','left','BackgroundColor','w');
    assignin('base','dispout',dispout)
    assignin('base','tecfig',fig)
    
    addpathlist();
end
end
