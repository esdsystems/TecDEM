function plot_grid_extract_referesh(varargin)
% This function is used to plot grid values i.e. digital elevation model or
% area grid.
% example:
%
% plot_grid('dem')
%
% plot_grid('area')
%
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com

try
    plot_col  = evalin('base','plot_col');
catch
    plot_col = ['k';'r'];
end

tp  = evalin('base','tp');

% grd = evalin('base','dem');
stream=evalin('base','stream');

% grd = evalin('base','dem');
% grd(grd == -9999) = NaN;

hold on

try
    for i = 1:1:length(stream)

        plot(stream(i).y,stream(i).x,strcat('-',plot_col(2)),'LineWidth',2);

    end
    try
        i = evalin('base','curr_val');
    catch
        curr_val = 1;
    end
    plot(stream(i).y,stream(i).x,strcat('-',plot_col(1)),'LineWidth',2);
catch
end

end