function export_streams(varargin)

curr_dir = pwd;


try

    info  = evalin('base','info');
    stream  = evalin('base','stream');
catch
    msgbox('No Data to Export','Error')
    uiwait
    return
end

lstr = length(stream);
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

for i = 1:1:lstr

    minlat =min(stream(i).lat);
    maxlat =max(stream(i).lat);
    minlon =min(stream(i).lon);
    maxlon =max(stream(i).lon);
    [lo la]=pix2map(R,stream(i).lon,stream(i).lat);
    
    rivers(i) = struct('Geometry','Line','BoundingBox',[minlon minlat maxlon maxlat],'Lon',lo,'Lat',la,'ID',i);
%     rivers(i) = struct('Geometry','Line','BoundingBox',[minlon minlat
%     maxlon maxlat],'Lon',stream(i).lon,'Lat',stream(i).lat,'ID',i);

    %     knickpoints(i) = struct('Geometry','Point','Lon',minlon,'Lat',minlat, 'Name', 'Knickpoint # 1');
end

% cd(info.location(1:end-5))

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