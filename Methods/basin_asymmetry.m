function basin_asymmetry(varargin)

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
load_grid_base('base','ADN')
load_grid_base('base',strcat(num2str(td),'CRT'))
% load_grid_base('base','CRT');
try
curvature_final();
basin_analysis();
catch
    evalin('base','clear td');
    msgbox('Something went wrong with entered parameters','Error')
end