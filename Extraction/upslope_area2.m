function upslope_area2(varargin)

add_histroy({'Area calculation started'});

load_grid_base('base','FLOW');
flowdir =evalin('base','flowdir');
siz =evalin('base','r');
numl = siz(1)*siz(2);

% To and from matrix of Flow direction

nfrom = find(flowdir ~= -1);
nto = flowdir(nfrom);

flowdir =sparse(nfrom,nto,1,numl,numl);
% Based on the method of Schwanghart 2010


add_histroy({'Area grid initiated.'});

area  = ones(numl,1);
I = speye(numl);

% solve flow accumulation equation
flowdir = flowdir';

flowdir = I - flowdir;
add_histroy({'Solving flow equations'});

area = flowdir\area;

% Final Calculated Area reshape array
area = reshape(area,siz);

info = evalin('base','info');
savefile = strcat(info.path,'_AREA.mat');
save(savefile,'area','-v7.3')

add_histroy({'Finished calculating area grid'});
add_comm_line();

evalin('base','clear flowdir');