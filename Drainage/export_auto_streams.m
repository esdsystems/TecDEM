function export_auto_streams(varargin)

curr_dir = pwd;


try

    info  = evalin('base','info');
    stream  = evalin('base','str_net');
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

stream(1) = [];
lstr = length(stream);
% R(3) = -R(3);
% R(4) = -R(4);
for i = 1:1:lstr

    [lo la]=pix2map(R,stream(i).rowid,stream(i).colid);
    
%     minlat =min(la);
%     maxlat =max(la);
%     minlon =min(lo);
%     maxlon =max(lo);
%     
%     rivers(i) = struct('Geometry','Line','BoundingBox',[minlon minlat maxlon maxlat],'Lon',lo,'Lat',la,'ID',i,'BOX1',minlon ,'BOX2',minlat ,'BOX3',maxlon ,'BOX4',maxlat);
       
    BBOX = [min(lo) max(la); max(lo) min(la)]';
    
    rivers(i) = struct('Geometry','Line','BoundingBox',BBOX,'Lon',lo,'Lat',la, 'ID',i,'order',stream(i).order);

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