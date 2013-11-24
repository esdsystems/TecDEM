function drainage_density(varargin)

area_info = evalin('base','area_info');
load_grid_base('caller','ADN');
load_grid_base('caller','LEN');

% str_map = evalin('base','str_map');
% flowlen = evalin('base','flowlen');
[r c]=size(str_map);

dr_density = NaN * zeros(r,c);

pst = 1;
%
prompt={'Enter moving window size (pixels)'};
name='Drainage Density Map';
numlines=1;
defaultanswer={'10'};

typ=inputdlg(prompt,name,numlines,defaultanswer);

if isempty(typ)
    return
end

lt = typ{1};
lt = str2num(lt);


ord = typ{2};
ord = str2num(ord);

if isempty(lt)
    return
end

rr = lt;
cc = lt;
res = area_info.res;

add_histroy({'Start calculating drainage density.'});
add_histroy({strcat('Moving window size is set to ',num2str(lt),' Pixels')});


for i = rr:1:r-(rr-1)
    for j = cc:1:c-(cc-1)

        str = str_map(i-(rr - 1):1:i+(rr - 1),j-(rr - 1):1:j+(rr - 1));
        len = flowlen(i-(rr - 1):1:i+(rr - 1),j-(rr - 1):1:j+(rr - 1));
        tlen  = sum(len(str >=ord))*res /1000;
        tarea = (rr*cc*res*res)/(1000*1000);
        dr_density(i,j) = tlen./tarea;

    end
    percent = round(100*(i*j)/(r*c));


    if percent == pst*1
        pause(0.000001)
        pst = pst +1;
        add_comments({strcat(num2str(percent),' Percent of calculation done')});
    end

end
% assignin('base','dr_density',dr_density);

info = evalin('base','info');
savefile = strcat(info.path,'_DND.mat');
save(savefile,'dr_density','-v7.3');
%
add_histroy({'Finish calculating drainage density.'});
%
evalin('base', 'clear dr_density');
evalin('base','clear od');
plot_density_map();
end