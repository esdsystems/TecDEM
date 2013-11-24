function upslope_area(varargin)
% This function is used to calculate upslope area
% No input orgument is required. It will automatically use the loaded dem
% in the moemory and calcualte upslope area.
%
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com

load_grid_base('caller','CON');
load_grid_base('base','FLOW');
r = size(tzero1);

area = ones(r);
add_histroy({'Area calculation started'});
pause(0.00001)
ind = find(tzero1 == 0);

pst = 1;

for i = 1:1:length(ind)
    percent = round((100*i)/length(ind));
    output=extract_stream(ind(i));

    if percent == pst*1
        pause(0.00001)
        pst = pst +1;
        add_comments({strcat(num2str(percent),' Percent of area calculated')});
    end

    area(output) = area(output)+1;
end

info = evalin('base','info');
savefile = strcat(info.path,'_AREA.mat');
save(savefile,'area','-v7.3')

add_histroy({'Finished calculating area grid'});
add_comm_line();

evalin('base','clear flowdir');
