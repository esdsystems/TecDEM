function strm = extract_param(output)

load_grid_base('caller','rawDEM');
load_grid_base('base','AREA');
load_grid_base('base','LEN');
load_grid_base('base','DEM');
area = evalin('base','area');
flowlen = evalin('base','flowlen');
dem = evalin('base','dem');
res = evalin('base','area_info.res');


strm = struct('lat',[],'lon',[],'x',[],'y',[],'len',[],'elevation',[],'rawelevation',[],'area',[],'bit',[],'knickpoint',[],'hack_cont',[],...
    'u',[],'v',[],'logarea',[],'logslope',[],'m1',[],'m2',[],'Ks',[]);

[c r]=ind2sub(size(dem),output);

strm.lat =r ;
strm.lon =c ;
strm.x = c;
strm.y = r;
rfac = res/1000;
strm.len = cumsum(rfac*flowlen(output));
strm.area= area(output).*(rfac*rfac);
strm.elevation= dem(output);
strm.rawelevation= rawdem(output);
strm.bit= zeros(size((output)));