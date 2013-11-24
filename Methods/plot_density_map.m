function plot_density_map(varargin)


load_grid_base('caller','DND');
% dr_density =evalin('base','dr_density');
tecfig =evalin('base','tecfig');
pos = get(tecfig,'Position');

fig = figure('Units','Pixels','Name','Incision map','NumberTitle','off');
% file_manu = uimenu(fig,'Label','Overlay');
% 
% mnuopenproject =  uimenu(file_manu,'Label','Drainage Network','Callback',@overlay_drainage);
% mnuimportdem =  uimenu(file_manu,'Label','Sub Basins','Callback',@overlay_subbasin);
set(fig,'Position',[pos(1) pos(2) pos(3) 420]);
    
imagesc(dr_density);
title('Drainage density distribution','FontSize',13)
xlabel('Longitude');
ylabel('Latitude');
axis image
add_histroy({'Drainage density map plotted.'});
add_comm_line();