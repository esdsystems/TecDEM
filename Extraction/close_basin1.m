function close_basin1(varargin)

closereq
evalin('base','clear hyp_basin');

add_histroy({'Basin Hypsometry is closed.'});
add_comm_line();

evalin('base','clear tindfig td hypfig dem boundary basinmatrix stream');