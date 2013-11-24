function gridding_full(varargin)
% gridding_full.m 
% This function is used to calculate the flow directions with gridding approach.
% The gridding dimenstions are automatically calcualted and the output
% consists of flow length and flow direction grids. These grids are stored 
% on the current directory specified by inf.path. 
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com
% 


load_grid_base('caller','DEM');

add_histroy( {'Calculating Flow directions using D8 algorithm.'});
% pause(0.000001)
% 
% 
% r = size(dem);
% if r(2)*r(1) <= 500*500
%     NVBs = 1;
%     NHBs = 1;
% else
%     NVBs = ceil(r(1)/500);
%     NHBs = ceil(r(2)/500);
% end
% 
% X=floor(r(2)/NHBs );
% Y=floor(r(1)/NVBs);
% 
% HiX=1;
% VjY=1;
% limitxs = [];
% limitys = [];
% limitxe = [];
% limitye = [];
% 
% for Hi=1:NHBs
%     for Vj=1:NVBs
%         xlimit=(HiX+X)-1;
%         ylimit=(VjY+Y)-1 ;
% 
%         limitxs = [limitxs HiX];
%         limitys = [limitys VjY];
% 
%         limitxe = [limitxe xlimit];
%         limitye = [limitye ylimit];
% 
% 
%         VjY=VjY+NVBs;
% 
%         if Hi == NHBs
%             limitxe(end) = r(2);
%         end
% 
%     end
%     if Vj == NVBs
%         limitye(end) = r(1);
%     end
% 
% 
%     HiX=HiX+X;
%     VjY=1;
% end
% buff = 100;
% outs=[limitxs-buff/2 ;limitys-buff/2; limitxe+buff/2 ; limitye+buff/2];
% ins=[limitxs ;limitys; limitxe ; limitye];
% 
% outs(3,outs(3,:) > r(2)) = r(2);
% outs(4,outs(4,:) > r(1)) = r(1);
% 
% outs(outs < 1) = 1;
% 
% ins(ins < 1) = 1;
% flowdir  = [];
% flowlen  = [];
% total = NVBs*NHBs;
% 
% add_histroy({strcat('Data is divided into a total of .',num2str(total),'. sub grid(s)')});
% 
% flowtest  = -1*ones(r);
% flowdem = -1*ones(r);
% 
% for i = 1:1:total
% 
%     pause(0.011)
% 
%     add_histroy({strcat('Processing Grid . ',num2str(i),strcat('_of_',num2str(total)))});
% %     flod= flowdirections_grid(dem(outs(2,i): outs(4,i),outs(1,i): outs(3,i)),'type','single');
%     flod = flowdir_lm(dem(outs(2,i): outs(4,i),outs(1,i): outs(3,i)), ones(size(dem(outs(2,i): outs(4,i),outs(1,i): outs(3,i)))),'type','single','fillsinks','no');
% 
%     from =find(flod ~= 0);
% 
%     to=flod(from);
%     r = size(flod);
%     [ang len] = ind2ang(r,from,to);
%     %
%     flod = -1*ones(r);
%     flod(from) = ang;
%     %
%     lns = zeros(r);
%     lns(from) = len;
% 
%     %
%     flowtest(outs(2,i): outs(4,i),outs(1,i): outs(3,i)) = flod;
%     flowdem(outs(2,i): outs(4,i),outs(1,i): outs(3,i)) = lns;
%     flowdir(ins(2,i): ins(4,i),ins(1,i): ins(3,i)) = flowtest(ins(2,i): ins(4,i),ins(1,i): ins(3,i));
%     flowlen(ins(2,i): ins(4,i),ins(1,i): ins(3,i)) = flowdem(ins(2,i): ins(4,i),ins(1,i): ins(3,i));
% 
% end
% 
% % assignin('base','flowang',flowdir);
% % assignin('base','flowlen',flowlen);

spflow= flowdir_single(dem); % In TecDEM version 2.0 it uses flowdir_single from topotoolbox

[nfrom nto] = find(spflow);

flowdir = -1*ones(size(dem));
flowdir(nfrom) = nto;

% 
info = evalin('base','info');
flowlen = ones(size(dem));
savefile = strcat(info.path,'_LEN.mat');
save(savefile,'flowlen','-v7.3')

add_histroy({'Flow lengths along possible flow directions are saved.'});

savefile = strcat(info.path,'_FLOW.mat');
save(savefile,'flowdir','-v7.3')
add_histroy({'Finished flow directions calculations'});
add_histroy({'Calculating Concave flow directions'})
count_inflow(flowdir);
add_comm_line();
