function fill_dem(varargin)

add_histroy({'DEM Filling is started'});

load_grid_base('caller','rawDEM');

dem = rawdem;

dem(dem == -9999) = nan;

dem(isnan(dem)) = -inf;

dem      = imfill(dem,8,'holes');

info = evalin('base','info');
savefile = strcat(info.path,'_DEM.mat');
save(savefile,'dem','-v7.3')

add_histroy({'DEM filling is finished'});
add_comm_line();

end