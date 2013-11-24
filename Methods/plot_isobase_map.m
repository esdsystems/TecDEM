function plot_isobase_map(varargin)

try
    isobase =evalin('base','isobase');
catch
    load_grid_base('caller','ISO');
end

tecfig =evalin('base','tecfig');
pos = get(tecfig,'Position');

fig = figure('Units','Pixels','Name','Isobase map','NumberTitle','off');

% file_manu = uimenu(fig,'Label','Overlay');

% mnuopenproject =  uimenu(file_manu,'Label','Drainage Network','Callback',@overlay_drainage);
% mnuimportdem =  uimenu(file_manu,'Label','Sub Basins','Callback',@overlay_subbasin);

set(fig,'Position',[pos(1) pos(2) pos(3) 420]);

imagesc(isobase);
title('Isobase Map','FontSize',13)
xlabel('Longitude');
ylabel('Latitude');
axis image
add_histroy({'Isobase map plotted.'});
add_comm_line();

evalin('base','clear isobase str_map str_net strid netwk_order_ind');