function export_knickpoints(varargin)


% curr_dir = pwd;

try

    info  = evalin('base','info');
    stream  = evalin('base','stream');
catch
    msgbox('No Data to Export','Error')
    uiwait
    return
end

curr_val  = evalin('base','curr_val');

% stream.knickpoint = stream.hack_cont(1,:)

lstr = length(stream);
lats = [];
lons = [];
klats = [];
klons = [];

knickpoints = [];
index = [];
subindex = [];

for i = 1:1:lstr

    for j = 1:1:length(stream(i).knickpoint)
        knickpoints = [knickpoints, stream(i).knickpoint(j)];
        index = [index, i];
        subindex = [subindex, j];

    end

end

composit = [index; subindex; knickpoints]';
index = unique(index);
k = 0;
klats = [];
klons = [];
for i = index

    lons = [stream(i).lon];
    lats = [stream(i).lat];

    sid =composit(find(composit(:,1) == i),2);
    kps =composit(find(composit(:,1) == i),3);
   
    klats = [klats; stream(i).lat(kps)];
    klons = [klons; stream(i).lon(kps)];

end


composit = [composit(:,1), composit(:,2), composit(:,3), klons, klats];

assignin('base','composit',composit)
%     knickpoints(1) = struct('Geometry','Point','Lon',[stream(20).lon(1)],'Lat',[stream(20).lat(1)], 'Name', 1)

[ row, col]=size(composit);
% R  = evalin('base','R');

area_info = evalin('base','area_info');

res1 = area_info.PixelScale(1);
res2 = area_info.PixelScale(2);
y1 = area_info.TiePoints.WorldPoints.Y;
x1 = area_info.TiePoints.WorldPoints.X;

R = makerefmat(x1, y1,res1,-res2);

for i = 1:1:row

    [lo la]=pix2map(R,composit(i,4),composit(i,5));

    kpts(i) = struct('Geometry','Point','Lon',lo,'Lat',la, 'stream_no', i, 'subid', composit(i,2), 'index_in_str', composit(i,3) );

end
%
% cd(info.location(1:end-5))
% % knickpoints = updategeostruct(knickpoints);
[filename, pathname] = uiputfile('*.shp','Save as Shape File');

files = strcat(pathname,filename);

if isempty(files)
    return
end

shapewrite(kpts,files)
export_prj(strcat(files(1:end-3),'prj'))

% cd(curr_dir)

% knickpoint_kml(files)
end