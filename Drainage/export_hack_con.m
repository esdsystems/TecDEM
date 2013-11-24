function export_hack_con(varargin)

curr_dir = pwd;

try
    
info  = evalin('base','info');
stream  = evalin('base','stream');
catch
    msgbox('No Data to Export','Error')
    uiwait
    return
end

curr_val  = evalin('base','curr_val');


lstr = length(stream);
minlat = [];
maxlat = [];
minlon = [];
maxlon = [];

k = 1;
% R  = evalin('base','R');
area_info = evalin('base','area_info');

res1 = area_info.PixelScale(1);
res2 = area_info.PixelScale(2);
y1 = area_info.TiePoints.WorldPoints.Y;
x1 = area_info.TiePoints.WorldPoints.X;

R = makerefmat(x1, y1,res1,-res2);

clc
for i = 1:1:lstr


    hcont = stream(i).hack_cont(2,:);
    kpts = [stream(i).hack_cont(1,:),length(stream(i).lat)];

     for j= 1:1:length(kpts)-1
        hack = hcont(j);
        ind = [kpts(j):kpts(j+1)];
        minlat =min(stream(i).lat(ind));
        maxlat =max(stream(i).lat(ind));
        minlon =min(stream(i).lon(ind));
        maxlon =max(stream(i).lon(ind));
        
        [lo la]=pix2map(R,stream(i).lon,stream(i).lat);
                
        rivers(k) = struct('Geometry','Line','BoundingBox',[minlon minlat maxlon maxlat],'Lon',lo(ind),'Lat',la(ind),'sid',i,'mid',k,'value', hack);
        k = k+1;
        
    end
end

% cd(info.location(1:end-5))

[filename, pathname] = uiputfile(strcat(info.path,'*.shp'),'Save as Shape File');

files = strcat(pathname,filename);
if isempty(files)
    return
end
shapewrite(rivers,files)
export_prj(strcat(files(1:end-3),'prj'))

% %

% cd(curr_dir)
% concavity_kml(files)
end