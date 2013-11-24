function link_file(varargin)
% link_file.m
% This function is used to calculate the location of specific flow pixels.
% The value at the flow pixel specifies the inward flow pixel. This
% approach makes the processing faster.
%
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com
%
load_grid_base('base','ANG');
load_grid_base('caller','DEM');

info = evalin('base','area_info');
flowdir = evalin('base','flowdir');


res = info.res;

r = size(flowdir);

flowlen = zeros(r);

add_histroy({'Link file started'});

pause(0.00001)

nfrom = find(flowdir~= -1);
flows = -1*ones(r);

pst = 1;
ttl = numel(nfrom);
for i = 1:1:numel(nfrom)

    prc = i/ttl;

    from = nfrom(i);
    dr = [135 180 225 90 NaN 270 45 0 315];
    [r1 c1]=ind2sub(r,from);
    [r2 c2]=ind2sub([3 3],find(dr == flowdir(from)));

    flows(from)=sub2ind(r,r1+r2-2,c1+c2-2);
        
    [r2 c2]=ind2sub(r,flows(from));
        
    flowlen(from) = flw_length(r1,c1,dem(r1,c1),r2,c2,dem(r2,c2),res);
    percent = round(i*100/numel(nfrom));
    %
    if percent == pst*1
        pause(0.000001)
        pst = pst +1;
        add_comments({strcat(num2str(percent),' Percent of link file calculation done')});
    end
end



flowdir = flows;

clear flows

info = evalin('base','info');
savefile = strcat(info.path,'_FLOW.mat');
save(savefile,'flowdir','-v7.3');

savefile = strcat(info.path,'_LEN.mat');
save(savefile,'flowlen','-v7.3')

add_histroy({'Calculating Concave flow directions'})
count_inflow(flowdir);

add_histroy({'Flow Linking completed successfully.'});
add_comm_line();


