function load_grid_base(from,grd)
% load_grid_base.m
% This function is used to load any grid file specified by grd and the
% results are stroed in as specified by from. The from consists of 'caller'
% or 'base'.
% The info file contains basic information about the DEM.
%
% Example
% load_grid_base('caller','DEM')
% This command will load the DEM from the current working directory and
% store it in the calling functio's memory.
%
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com
%
info = evalin('base','info');
fls = strcat(info.path,'_',grd,'.mat');
try
    evalin(from,strcat('load(''',fls,''')'))   
end