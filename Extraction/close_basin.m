function close_basin(varargin)

closereq
add_histroy({'Basin Asymmetry is closed.'});
add_comm_line();



tind_basin = evalin('base','tind_basin');

curvature = evalin('base','curvature');

info = evalin('base','info');
try
td = evalin('base','td');
savefile = strcat(info.path,'_',num2str(td),'CRT.mat');
% savefile = strcat(info.path,'_CRT.mat');
save(savefile,'curvature','tind_basin');
catch

end


evalin('base','clear tindfig boundary cur_base curvature dem');

evalin('base','clear basinmatrix flowdir flows midxx midyy nxx nyy od td tind_basin');