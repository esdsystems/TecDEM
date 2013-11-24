function ret = basin_hack(varargin)

load_grid_base('base','DEM');

prompt={'Thresh hold by Strahler order'};
name='Options for subbasin extraction';
numlines=1;
defaultanswer={'3'};
typ=inputdlg(prompt,name,numlines,defaultanswer);

if isempty(typ)
    ret = 0;
    return
else
    add_histroy({'Start calculating Basin Hypsometry values'});
    lt = typ(1);
    lt = cell2mat(lt);

    td = str2num(lt);


    load_grid_base('base',strcat(num2str(td),'HYP'))
    load_grid_base('base',strcat(num2str(td),'BSN'))

    % td = evalin('base','td');
    %     try
    %
    %         hyp_basin = evalin('base','hyp_basin');
    %
    %
    %     catch

    try

        load_grid_base('base',strcat(num2str(td),'BSN'))
        dem = evalin('base','dem');
        basinmatrix = evalin('base','basinmatrix');
        boundary = evalin('base','boundary');

        try

            hyp_basin = evalin('base','hyp_basin');

        catch
            hyp_basin = struct('rel_A',[]);
        end

        h = waitbar(0,strcat(num2str(0),'% Done'), 'Name','calculating Basin Hypsometry values');

        for id = 1:1:length(boundary)
            waitbar((id)/(length(boundary)),h,strcat(num2str(round(100*(id)/(length(boundary)))),'% Done'));
            ind = basinmatrix == id;
            elev =dem(ind);
            elev = sort(elev,'descend');

            rel_H =(elev-min(elev))./(max(elev)-min(elev));
            rel_A = linspace(0,100,numel(elev));
            rel_A = rel_A';

            [mn st sk ku] = hyps_stat(rel_A,rel_H,3);


            hyp_basin(id).rel_A = rel_A/100;
            hyp_basin(id).rel_H = rel_H;
            hyp_basin(id).mn = mn;
            hyp_basin(id).st = st;
            hyp_basin(id).sk = sk;
            hyp_basin(id).ku = ku;
        end

        close(h)
        assignin('base','hyp_basin',hyp_basin)


        info = evalin('base','info');
        savefile = strcat(info.path,strcat('_',num2str(td),'HYP.mat'));
        save(savefile,'hyp_basin','-v7.3');
        ret = 1;
    catch
        ret = 1;

        return
    end

end