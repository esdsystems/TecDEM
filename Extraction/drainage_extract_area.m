function drainage_extract_area(varargin)

r = evalin('base','r');
area_info = evalin('base','area_info');
res = area_info.res;

prompt={'Thresh hold by (sq. km)','value'};
name='Options for drainage plot';
numlines=1;
defaultanswer={'area','1'};

try
    typ=inputdlg(prompt,name,numlines,defaultanswer);
    type = typ(1);
    lt = typ(2);
    lt = cell2mat(lt);
    lt = str2num(lt);
catch
    return
end

if strcmp(type,'area')
    lt = lt*(1000/res)*(1000/res);
    
    load_grid_base('caller','AREA');
    
    if lt > 0
        area(area < lt) = 0;
        parea = area;
        area(area >= lt) = 1;
    else
        area(area <= -lt) = 0;
        parea = area;
        area(area > -lt) = 1;
    end
    assignin('base','lt',lt);
    assignin('base','parea',area);
else
    load_grid_base('caller','CON');
    assignin('base','lt',lt);
    assignin('base','parea',tzero1);
end

add_histroy({'Area threshold completed.'});

end