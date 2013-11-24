function save_specific_stream(varargin)

try
    strm = evalin('base','strm');
    curr_val = evalin('base','strid');
    curr_val = curr_val +1;

catch
    curr_val = 1;
end
try
    plot_col  = evalin('base','plot_col')';
catch
    plot_col = ['k';'r'];
end

% try

if isempty(strm)
    msgbox('No stream to save..','Error....');
    return
else

    stream=evalin('base','stream');
    curr_val = length(stream)+1;
    stream(curr_val) = strm;
    strid = curr_val ;

    %         assignin('base','strhand',-1);
    assignin('base','stream',stream);
    %         list = num2str([1:1:length(stream)]');
    assignin('base','strid',curr_val);
    assignin('base','strm',[]);

    disptyp = evalin('base','disptyp');

    for i = 1:1:length(stream)
        plot(stream(i).y,stream(i).x,strcat('-',plot_col(2)),'LineWidth',2);
    end

    if strcmp(disptyp,'grid')

        strcut=plot(strm.y,strm.x,strcat('-',plot_col(1)),'LineWidth',2);
    else
        strcut=plot(strm.y,strm.x,strcat('-',plot_col(1)),'LineWidth',2);
    end


    %         plot_list = evalin('base','plot_list');
    %         set(plot_list,'String',list)



    assignin('base','curr_val',strid)
    assignin('base','strcut',strcut)

    %     plot_grid_extract_referesh();
    stream_filter(20);


    info = evalin('base','info');
    stream = evalin('base','stream');
    savefile = strcat(info.path,'_stream.mat');
    save(savefile,'stream','strid')



    ListBox = evalin('base','ListBox');
    set(ListBox,'Val',length(stream),'String',num2str([1:1:length(stream)]'));
    add_histroy({strcat('Stream No. ',num2str(strid),' was saved successfully.')});

end
% catch
%     msgbox('First select a stream','Error.');
% end

