function vertical_dissection(varargin)

% dem = evalin('base','dem');
load_grid_base('caller','DEM');
area_info= evalin('base','area_info');
slp = nan*ones(size(dem));
[r c] = size(dem);
res = area_info.res;
add_histroy({'Caclculating Vertical Dissection Map'});

pst = 1;

prompt={'Enter moving window size (pixels)'};
name='Vertical Dissection Map';
numlines=1;
defaultanswer={'10'};

typ=inputdlg(prompt,name,numlines,defaultanswer);

if isempty(typ)
    return
end

lt = typ;
lt = cell2mat(lt);
lt = str2num(lt);

if isempty(lt)
    return
end


for i = 2:1:r-1
    for j = 2:1:c-1

        slp(i,j)= calc_slope(dem(i-1:i+1,j-1:j+1),res,res);
    end
    percent = round(100*(i*j)/(r*c));
    if percent == pst*1
        pause(0.000001)
        pst = pst +1;
        add_comments({strcat(num2str(percent),' Percent of slope calculation done')});
    end
end
% add_histroy({' '});
cd = res*sqrt(res*res + power(tan(slp./57.29578)*res,2));
flata = (res*res).*ones(size(dem));

add_histroy({strcat('Moving window size is set to ',num2str(lt),' Pixels')});

rr = lt;
cc = lt;
rel = nan*ones(size(dem));
[r c] = size(dem);

pst = 1;
for i = rr:1:r-(rr - 1)
    for j = cc:1:c-(cc - 1)

        a = cd(i-(rr - 1):1:i+(rr - 1),j-(rr - 1):1:j+(rr - 1));
        b = flata(i-(rr - 1):1:i+(rr - 1),j-(rr - 1):1:j+(rr - 1));
        rel(i,j) = sum(a(:))./sum(b(:));

    end
    percent = round(100*(i*j)/(r*c));
    %

    if percent == pst*1
        pause(0.000001)
        pst = pst +1;
        add_comments({strcat(num2str(percent),' Percent of vertical dissection calculated.')});
    end

end
vertical_diss = rel;
% assignin('base','vertical_diss',vertical_diss);
info = evalin('base','info');
savefile = strcat(info.path,'_VD.mat');
save(savefile,'vertical_diss','-v7.3');

add_histroy({'Vertical dissection grid computed successfully.'});

plot_vd_map();