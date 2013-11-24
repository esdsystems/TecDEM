function export_auto_basin(varargin)

try
    
    info  = evalin('base','info');
    boundary  = evalin('base','boundary');
catch
    msgbox('No Data to Export','Error')
    uiwait
    return
end


minlat = [];
maxlat = [];
minlon = [];
maxlon = [];

% R = evalin('base','R');
area_info = evalin('base','area_info');

res1 = area_info.PixelScale(1);
res2 = area_info.PixelScale(2);
y1 = area_info.TiePoints.WorldPoints.Y;
x1 = area_info.TiePoints.WorldPoints.X;

R = makerefmat(x1, y1,res1,-res2);

stream = boundary;
lstr = length(stream);

for i = 1:1:lstr
    
    
    stream(i).ibr = [stream(i).ibr stream(i).ibr(1)];
    stream(i).ibc = [stream(i).ibc stream(i).ibc(1)];
    
    [lo la]=pix2map(R,stream(i).ibr,stream(i).ibc);
    
    %     minlat =min(la);
    %     maxlat =max(la);
    %     minlon =min(lo);
    %     maxlon =max(lo);
    %
    %     rivers(i) = struct('Geometry','Line','BoundingBox',[minlon minlat maxlon maxlat],'Lon',lo,'Lat',la,'ID',i,'BOX1',minlon ,'BOX2',minlat ,'BOX3',maxlon ,'BOX4',maxlat);
    
    BBOX = [min(lo) max(la); max(lo) min(la)]';
    
    rivers(i) = struct('Geometry','Polygon','BoundingBox',BBOX,'Lon',lo,'Lat',la, 'ID',i,'BasinNo',i);
    %         rivers(i) =
    %         struct('Geometry','Polygon','BoundingBox',BBOX,'Lon',lo,'Lat',la, 'ID',i,'bsn_shp',stream(i).shp,'Hi',stream(i).Hi);
    
end

assignin('base','rivers',rivers)

[filename, pathname] = uiputfile(strcat(info.path,'*.shp'),'Save as Shape File');

files = strcat(pathname,filename);

if isempty(files)
    return
end

shapewrite(rivers,files)
export_prj(strcat(files(1:end-3),'prj'))

% cd(curr_dir)

% google_earth(files);


end