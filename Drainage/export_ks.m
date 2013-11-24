function export_ks(varargin)

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


    bits = unique(stream(i).bit);

        for j = 1:1:bits(end)
        
            [lo la]=pix2map(R,stream(i).lon,stream(i).lat);
            ind = find(stream(i).bit == j);
            minlat =min(stream(i).lat(ind));
            maxlat =max(stream(i).lat(ind));
            minlon =min(stream(i).lon(ind));
            maxlon =max(stream(i).lon(ind));
    
            rivers(k) = struct('Geometry','Line','BoundingBox',[minlon minlat maxlon maxlat],'Lon',lo(ind),'Lat',la(ind),'sid',i,'mid',j,'value',stream(i).Ks(j));
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

%
% cd(curr_dir)

% concavity_kml(files)
end