function delete_stream(varargin)

try
    curr_val = evalin('base','curr_val');
catch
    curr_val = 1;
end

r = evalin('base','r');
prompt={'Enter Stream number to be delete..'};
name='Delete Stream';
numlines=1;
defaultanswer={num2str(curr_val)};

typ=inputdlg(prompt,name,numlines,defaultanswer);

lt = typ;
lt = cell2mat(lt);


if isempty(lt)
    return
else
    lt = str2num(lt);
end

stream = evalin('base','stream');
try
    
strid =  evalin('base','strid');
catch
    strid = 1;
end
strid = strid -1;

stream(lt) = [];

add_histroy({strcat('Stream No. ',num2str(lt),' was deleted.')});

assignin('base','stream',stream);
assignin('base','strid',strid);
assignin('base','curr_val',1);

info = evalin('base','info');

savefile = strcat(info.path,'_stream.mat');
save(savefile,'stream','strid')

tp = evalin('base','tp');

ListBox=evalin('base','ListBox');

set(ListBox,'String',num2str([1:1:length(stream)]'),'Value',1)

if strcmp(tp,'dem')
    grd = evalin('base','dem');
    grd(grd == -9999) = NaN;
    imagesc(grd)
    colormap Jet
    shading interp
    axis image

elseif strcmp(tp,'basin')

    grd = evalin('base','basinmatrix');
    imagesc(grd)
    %     colormap Jet
    %     shading interp
    axis image

else
    cla
    test = ones(r);
    test(1,1) = 0;
    imagesc(test);
    axis image
    plot_streams();
end
%      plot_streams();
plot_grid_extract_referesh();
% catch
%msgbox('Select a valid stream to be delete', 'Error...')
% end
