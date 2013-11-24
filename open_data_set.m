function open_data_set(varargin)
% open_data_set.m 
% This function is used to open any existing project specified by '_INFO.mat'.
% 
% 
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com
% 
% 
dispout = evalin('base','dispout');
tecfig = evalin('base','tecfig');

[areaname,location]=uigetfile('*_INFO.mat');


if areaname ~= 0

    evalin('base','clear all')
    assignin('base','tecfig',tecfig);
    assignin('base','dispout',dispout);
    fls = strcat(location,areaname);
    rest = load(fls);

    rest.info.path = fls(1:end-9);
    r = [rest.area_info.Height rest.area_info.Width];
    
    assignin('base','area_info',rest.area_info);
    assignin('base','info',rest.info);
    assignin('base','dispout',dispout);
    assignin('base','r',r);

    try

        load_grid_base('base','stream');
       
    end
    textfile = strcat(fls(1:end-9),'_info.txt');

    fid=fopen(textfile,'r');

    while 1
        tline = fgetl(fid);

        if ~ischar(tline),

            break

        end

        add_histroy({tline});
    end

    s = {strcat('Project_***', rest.info.project_name(1:end-4) ,'***_Loaded successfully.')};

    add_histroy(s);
    add_comm_line();

end