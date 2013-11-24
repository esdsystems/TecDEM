function plot_vd_map(varargin)

load_grid_base('base','VD');
vertical_diss =evalin('base','vertical_diss');
evalin('base','clear vertical_diss')
tecfig =evalin('base','tecfig');
pos = get(tecfig,'Position');

fig = figure('Units','Pixels','Name','Vertical Dissection map','NumberTitle','off');

% file_manu = uimenu(fig,'Label','Overlay');

% mnuopenproject =  uimenu(file_manu,'Label','Drainage Network','Callback',@overlay_drainage);
% mnuimportdem =  uimenu(file_manu,'Label','Sub Basins','Callback',@overlay_subbasin);
imagesc(vertical_diss);
set(fig,'Position',[pos(1) pos(2) pos(3) 420]);


title('Vertical Dissection Map','FontSize',13)
xlabel('Longitude');
ylabel('Latitude');
axis image
add_histroy({'Vertical Disection map plotted.'});
add_comm_line();

