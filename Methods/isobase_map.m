function isobase_map(varargin)

% str_map = evalin('base','str_map');
% dem = evalin('base','dem');
load_grid_base('caller','ADN');
load_grid_base('caller','DEM');

add_histroy({'Caclculating Isobase Grid.'});

dind=isobasetest(str_map,dem);

add_histroy({'Interpolating Isobase Grid.'});

isobase = convert_grid(dind,'cubic');

assignin('base','isobase',isobase);

info = evalin('base','info','-v7.3');
savefile = strcat(info.path,'_ISO.mat');
save(savefile,'isobase');

add_histroy({'Isobase Grid computed successfully.'});
plot_isobase_map();

