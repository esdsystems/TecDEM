function substract_stream(varargin)

prompt={'Main Stream number', 'Sub Stream number'};
name='Subtract Streams';
numlines=1;
defaultanswer={'1','2'};

typ=inputdlg(prompt,name,numlines,defaultanswer);

% lt = typ;

if isempty(typ)
    return
end

lt(1) = str2double(cell2mat(typ(1)));
lt(2) = str2double(cell2mat(typ(2)));

stream = evalin('base','stream');
r = evalin('base','r');
%     strid  = evalin('base','strid');

stream(lt(2))=dstream(stream(lt(1)),stream(lt(2)));

% stream_filter(20);
% 
% assignin('base','curr_val',lt(2));

assignin('base','stream',stream);

info = evalin('base','info');

savefile = strcat(info.path,'_stream.mat');
% save(savefile,'stream','strid')
save(savefile,'stream')

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
    boundary = evalin('base','boundary');
    imagesc(grd)
    %     colormap Jet
    %     shading interp
    axis image

    for z = 1:1:length(boundary)
        plot(boundary(z).ibc,boundary(z).ibr,'w-')
    end
    
else
    cla
    test = ones(r);
    test(1,1) = 0;
    imagesc(test);
    axis image
    plot_streams();
end

plot_grid_extract_referesh();