function curvature_final(varargin)

td = evalin('base','td');

load_grid_base('base',strcat(num2str(td),'BSN'))

% load_grid_base('base','BSN');

boundary = evalin('base','boundary');

basinmatrix = evalin('base','basinmatrix');

tind_basin = struct('ibr',[],'ibc',[],'xr',[],'yr',[],'Tind',[],'Tdir',[]);

try
    load_grid_base('base',strcat(num2str(td),'CRT'))
    
%     figure; imagesc(curvature)
    curvature = evalin('base','curvature');
    add_histroy({'Basin Asymmetry process is started.'});
    add_histroy({'Displaying already calculate curvature.'});

catch

    curvature = zeros(size(basinmatrix));
    add_histroy({'Start calculating curvature.'});

    for bval = 1:1:length(boundary)

        pause(0.00001)
        add_histroy({strcat(num2str(100*bval/length(boundary)),' of Curvature Calculated.')});

        [r1 r2 c1 c2 nxb nyb] = find_bbox(boundary(bval));
        tind_basin(bval).ibr = boundary(bval).ibr;
        tind_basin(bval).ibc = boundary(bval).ibc;

        cdata = ones(r2-r1+1,c2-c1+1);

        for i = 1:1:length(nxb)
            cdata(round(nyb(i)),round(nxb(i))) = 0;
        end

        output = eucl_distance(cdata,bval);
        cur=calc_curvature(output,bval);
        ma=max(cur(:));
        cur = cur./ma;
        curb = basinmatrix(r1:r2,c1:c2) == bval;
        cur(curb == 0) = 0;
        for i = 1:1:length(nxb)
            cur(round(nyb(i)),round(nxb(i))) = NaN;
        end
        curvature(r1:r2,c1:c2) = curvature(r1:r2,c1:c2)+cur;

    end

    assignin('base','curvature',curvature);
    assignin('base','tind_basin',tind_basin);
    add_histroy({'Finish calculating curvature.'});

    info = evalin('base','info');
%     savefile = strcat(info.path,'_CRT.mat');
    savefile = strcat(info.path,'_',num2str(td),'CRT.mat');
    save(savefile,'curvature','tind_basin','-v7.3');
end

% cla
% imagesc(curvature)
% for i = 1:1:length(boundary)
%
%     plot(boundary(i).ibc,boundary(i).ibr,'k');
%     hold on
% end
%
% set(gca,'ydir','reverse');
%
% xlabel('Longitude','FontSize',10);
% ylabel('Latitude', 'FontSize',10);
% ttl =  strcat('All basins are Plotted');
% title(ttl, 'FontSize',13);
% axis image