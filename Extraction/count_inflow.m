function count_inflow(flowdir)
% count_inflow.m 
% This function is used to calculate the number of inflow pixels for each
% pixel. This is used to identify the leaf and pour locations for streams.
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com
% 
% 

to = flowdir(:);

tzero1 = zeros(size(flowdir));

for i = 1:1:length(to)

    if to(i) ~= -1
        tzero1(to(i)) = tzero1(to(i))+1;
    end

end

% assignin('base','tzero',tzero);

info = evalin('base','info');    
savefile = strcat(info.path,'_CON.mat');
save(savefile,'tzero1','-v7.3')