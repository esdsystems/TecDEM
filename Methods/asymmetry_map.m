function asymmetry_map(varargin)

tecfig = evalin('base','tecfig');
pos=get(tecfig,'Position');

try
td = evalin('base','td');

catch
    
    
     prompt={'Thresh hold by Strahler order'};
    name='Options for basin asymmetry';
    numlines=1;
    defaultanswer={'3'};
    typ=inputdlg(prompt,name,numlines,defaultanswer);

    if isempty(typ)
        return
    else
        lt = typ(1);
        lt = cell2mat(lt);

        td = str2num(lt);
    end

    assignin('base','td',td);
    
end

load_grid_base('base',strcat(num2str(td),'CRT'))

% load_grid_base('base','CRT');
load_grid_base('base','DEM');

tind_basin = evalin('base','tind_basin');
r = evalin('base','r');
dem = evalin('base','dem');

fig=figure('Units','Pixels','Name','Drainage Basin Asymmetry','NumberTitle','off');
% cla
imagesc(dem)
% set(fig,'Position',[pos(1) pos(2) 550 350]);

% td = evalin('base','td');
% assignin('base','od',td);

for bval = 1:1:length(tind_basin)

    hold on
    plot(tind_basin(bval).ibc,tind_basin(bval).ibr,'k','LineWidth',1);

    try
        plot(tind_basin(bval).xr,tind_basin(bval).yr,'r','LineWidth',2);
    catch
    end

    %     try
    %         plot(tind_basin(bval).xm,tind_basin(bval).ym,'k','LineWidth',2);
    %     catch
    %     end

%     try
        [r c] = size(tind_basin(bval).Tvec);
        x = [];
        y = [];
        for i = 1:1:r
            %
            arrow([tind_basin(bval).Tvec(i,3) tind_basin(bval).Tvec(i,4)],[tind_basin(bval).Tvec(i,1) tind_basin(bval).Tvec(i,2)],'Length',4);
% figure

%         x = [x; tind_basin(bval).Tvec(i,1)];
%         y = [y; tind_basin(bval).Tvec(i,2)];

        end

%         x = [tind_basin(bval).xr];
%         y = [tind_basin(bval).yr];
        
%         [x y] = poly2cw(x,y);
        
%         fill(x,y,'r')
        
%     catch
% 
%     end

end

set(gca,'YDir','reverse');

% plot_streams();
ttl =  'Drainage Basin Asymmetry';
title(ttl, 'FontSize',13);

% set(gca,'xlim',[1 r(2)],'ylim',[1 r(1)])
box on
axis image
xlabel('Longitude','FontSize',10);
ylabel('Latitude', 'FontSize',10);

add_histroy({'Asymmetry map is plotted for all basins.'});
