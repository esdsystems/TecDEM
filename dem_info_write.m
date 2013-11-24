function dem_info_write()
% dem_info_write.m 
% This function is used to write the dem info file.
% The info file contains basic information about the DEM.
% 
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com
% 
% 
area_info = evalin('base','area_info');
info = evalin('base','info');

fid = fopen(strcat(info.path,'_info.txt'), 'wt');

fprintf(fid, ['Information for\t'  info.project_name(1:end-4) '\tDigital Elevation Model\n']);
% ...
%     '\n============================================\n'
fprintf(fid, strcat('Name of Location\t:', info.project_name(1:end-4)));
fprintf(fid, strcat('\nDEM Format\t\t:', area_info.Format));
fprintf(fid, strcat('\nNo. of Cols\t\t:', num2str(area_info.Width), '\t Pixels'));
fprintf(fid, strcat('\nNo. of Rows\t\t:', num2str(area_info.Height), '\t Pixels'));
fprintf(fid, strcat('\nResolution\t\t:',num2str(area_info.res), '\t meters'));

fprintf(fid, strcat('\nNorth Edge Value\t:',num2str(area_info.TiePoints.WorldPoints.X), '\t '));
fprintf(fid, strcat('\nSouth Edge Value\t:',num2str(area_info.TiePoints.WorldPoints.Y), '\t '));

% fprintf(fid, '\n===========================================================================\n');

fclose(fid);

% 
% % add_histroy({strcat('Name of Location:                  ', info.path,area_info.Format)});
% add_histroy({strcat('No. of Cols:                   .', num2str(area_info.Width), 'Pixels')})
% add_histroy({strcat('No. of Rows:                   .', num2str(area_info.Height),' Pixels')})
% add_histroy({strcat('North Edge Value:                          .',num2str(area_info.TiePoints.WorldPoints.X))});
% add_histroy({strcat('South Edge Value:                          .',num2str(area_info.TiePoints.WorldPoints.Y))});