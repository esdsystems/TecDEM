function export_tind(varargin)

tind_basin = evalin('base','tind_basin');
outmartix = [];

for i=1:1:length(tind_basin)
    out = [tind_basin(i).Tvec tind_basin(i).Tind tind_basin(i).Tdir];
    outmartix = [outmartix; out];

end

%  outmartix
% lstr = length(outmartix)
[lstr c] = size(outmartix)

% 
stream = struct('lat',[],'lon',[],'Tind',[],'Tang',[]);

for i = 1:1:lstr

    stream(i).lon = [outmartix(i,1); outmartix(i,3)];
    stream(i).lat = [outmartix(i,2); outmartix(i,4)];
    stream(i).Tind = outmartix(i,5);
    stream(i).Tang = outmartix(i,6);

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

for i = 1:1:lstr
    try
        minlat =min(stream(i).lat);
        maxlat =max(stream(i).lat);
        minlon =min(stream(i).lon);
        maxlon =max(stream(i).lon);
        [lo la]=pix2map(R,stream(i).lat,stream(i).lon);

        rivers(i) = struct('Geometry','Line','BoundingBox',[minlon minlat maxlon maxlat],'Lon',lo,'Lat',la,'ID',i,'Tind',stream(i).Tind,'Tang',stream(i).Tang);
    catch
    end
end

[filename, pathname] = uiputfile(strcat(info.path,'*.shp'),'Save as Shape File');

files = strcat(pathname,filename);

if isempty(files)
    return
end

shapewrite(rivers,files)
export_prj(strcat(files(1:end-3),'prj'))

end