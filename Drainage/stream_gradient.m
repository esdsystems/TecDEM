function stream_gradient(varargin)

try

    info  = evalin('base','info');
    stream  = evalin('base','stream');

catch

    msgbox('Load Data Set first','Error')
    uiwait
    return
end

prompt = {'Enter Contour Interval:'};
dlg_title = 'Contour Interval';
num_lines = 1;
def = {num2str(150),'hsv'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

stepelevation = str2double(answer);

add_comments({'Hack Index calculation started.'});

add_histroy({strcat('Specified Contour Interval: ', num2str(stepelevation),' m')});
set(gca,'Visible','off');

for i = 1:1:length(stream)

    if i == 1
        dd  = 2;
    else
        dd = i;
    end

    try
        stream(i).hack_cont = hack_gradient_cont(stream(i),stepelevation);
    catch
        return
    end
    add_histroy({strcat('Hack Index calculated for Stream No.', num2str(i))});
end


assignin('base','stream',stream);

info = evalin('base','info');

savefile = strcat(info.path,'_stream.mat');
strid = length(stream) ;
save(savefile,'stream','strid');

add_histroy({'Hack Index calculation finished.'});

add_comm_line();


