function boundary = basin_parameters(boundary)
add_histroy({'Extracting basin boundary parameters'});

load_grid_base('caller','DEM');
basinmatrix = evalin('base','basinmatrix');
area_info = evalin('base','area_info');
% area = evalin('base','area');
res = area_info.res;

for id = 1:1:length(boundary)
 try
    c1 = boundary(id).ibc;
    r1 = boundary(id).ibr;
    c2 = boundary(id).outlet_c;
    r2 = boundary(id).outlet_r;
%     [a b dist]=opposit_point(r1,c1,r2,c2);
%     ar = sqrt(area(r2,c2)*(res*res/1000000));
%     boundary(id).shp = ar/dist;

    ind = basinmatrix == id;
    elev =dem(ind);
    H = max(elev);
    Hint=(mean(elev) - min(elev))/H;
    boundary(id).Hi = Hint;
 catch
     id
 end
end