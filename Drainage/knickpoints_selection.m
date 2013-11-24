function knickpoints_selection(varargin)

try

    info  = evalin('base','info');
    stream  = evalin('base','stream');

catch
    msgbox('No Data to Plot','Error')
    uiwait
    return
end

try
    curr_val  = evalin('base','curr_val');
catch
    curr_val = 1;
end
tecfig    = evalin('base','tecfig');

lstr = length(stream);

if lstr <= 1
    msgbox('Please select at least two streams.', 'Error')
    uiwait
    return
end

try
    knickfig= evalin('base','knickfig');
    figure(knickfig);
    clf
    set(knickfig,'Name','Knickpoints selection','NumberTitle','off')
catch
    knickfig = figure('Units','Pixels','Name','Knickpoints selection','NumberTitle','off');
    tecfig = evalin('base','tecfig');
    pos=get(tecfig,'Position');
    set(knickfig,'Position',[pos(1) pos(2) 550 400 ]);
end
set(knickfig,'MenuBar','none','CloseRequestFcn',@close_kps);
assignin('base','knickfig',knickfig);


add_comments({'Knickpoints selection process started.'});


% Draw a maximized figure -----------------------------------------------

% screenxy=get(0,'MonitorPositions');

% x1 = screenxy(1);
% y1 = screenxy(2);
% x2 = screenxy(3);
% y2 = screenxy(4);
%
% screenxy = [x1 y1 x2 y2];


% try
%     knickfig  = evalin('base','knickfig');
%     close(knickfig)
%     knickfig = figure('Units','Pixels','Name','Knickpoints selection','NumberTitle','off');
% %     knickfig = figure('Units','Pixels','Name','Knickpoints
% %     selection','NumberTitle','off', 'OuterPosition',screenxy);
%     set(knickfig,'MenuBar','none');
%     assignin('base','knickfig',knickfig);
%
% catch
%
%     knickfig = figure('Units','Pixels','Name','Knickpoints selection','NumberTitle','off');
%     set(knickfig,'MenuBar','none');
%     assignin('base','knickfig',knickfig);
% end
%Menu Bar ---------------------------------------------------------------

curr_ind = [];

curr_knick = [];

axes('position',[0.1 0.2 .8 .7 ], 'Box','on');

Edit = uicontrol('Style','Edit','String',num2str(curr_val),'Position',[20,15,50,20], 'CallBack', @EditCallBack, 'HorizontalAlignment','left');


sstep = (100/(lstr -1))/100;

Slider = uicontrol('Style','Slider','Position',[90,15,80,20],'CallBack', @SliderCallBack, 'Value',curr_val, 'Min',1,'Max',lstr, 'SliderStep', [sstep sstep]);

Getknickpoint = uicontrol('Style','pushbutton','String','Get Knickpoint','Position',[190,15,100,20],'CallBack', @Getknickpt, 'HorizontalAlignment','left');

Saveknickpoint = uicontrol('Style','pushbutton','String','Save Knickpoint','Position',[310,15,100,20], 'CallBack', @saveknickpt, 'HorizontalAlignment','left');

deleteknickpoint= uicontrol('Style','pushbutton','String','Delete Knickpoint','Position',[430,15,100,20],'CallBack', @deleteknickpt, 'HorizontalAlignment','left');


plotstream();


    function EditCallBack(varargin)

        num = str2num(get(Edit,'String'));
        if length(num) == 1 & num <=lstr & num >=0
            set(Slider,'Value',num);
        else
            message=strcat('The value should be a number in the range [1-',num2str(lstr));
            message=strcat(message, ']');
            msgbox(message,'Invalid Stream Number','error','modal');
            uiwait
            num = get(Slider, 'Value');
            set(Edit, 'String', num2str(round(num)));
            return
        end
        assignin('base','curr_val',num);
        plotstream();
    end

    function SliderCallBack(varargin)

        num = get(Slider, 'Value');

        set(Edit, 'String', num2str(round(num)));
        assignin('base','curr_val',num);
        plotstream();

    end

    function Getknickpt(varargin)

        dd = length(stream(curr_val).knickpoint);
        prompt = {'Enter Knickpoint Number:'};
        dlg_title = 'Knicpoints Selection';
        num_lines = 1;
        def = {num2str(dd+1),'hsv'};
        answer = inputdlg(prompt,dlg_title,num_lines,def);

        if isempty(answer)
            return
        end
        answer = cell2struct(answer,'val',1);
        answer = str2num(answer.val);
        [distance elevation] = ginput(1);

        index1= find(stream(curr_val).elevation <= elevation);
        index2= find(stream(curr_val).len <= distance);

        curr_knick = answer;
        index1 = max(index1);
        index2 = max(index2);
        curr_ind  = min(index1,index2);
        plot(distance,elevation,'ob');

        add_histroy({strcat('Knickpoint No. ', num2str(curr_knick),' was identified.')});

    end

    function saveknickpt(varargin)
        if ~isempty(curr_knick)
            stream(curr_val).knickpoint(curr_knick) = curr_ind;
            assignin('base','stream',stream);

            info = evalin('base','info');

            savefile = strcat(info.path,'_stream.mat');
            strid = curr_val ;
            save(savefile,'stream','strid');
            %         save(savefile,'strid',num2str(curr_val));
            add_histroy({strcat('Knickpoint No. ', num2str(curr_knick),' was saved.')});
            plotstream();
        end
    end

    function deleteknickpt(varargin)

        knickpoints = [1:1: length(stream(curr_val).knickpoint)];


        try

            delknick  = evalin('base','delknick')
        catch
            delknick = 0;
        end

        if length(knickpoints) >= 1 & delknick == 0

            delknick=figure('MenuBar','none','Name','Delete Knickpoint','NumberTitle','off','Position',[500,400,140,100]);
            assignin('base','delknick',delknick);
            ListBox = uicontrol('Style','ListBox','String',knickpoints,'Position',[10,40,100,50]);
            del = uicontrol('Style','pushbutton','String','Delete','Position',[20,10,100,20],'CallBack', @ListBoxCallBack,'DeleteFcn', @deleteknickfig );

        else
            if delknick ~= 0

                figure(delknick);
            else
                message=strcat('No Knickpoint to Delete...');
                msgbox(message,'Delete Knickpoint','error','modal');
                uiwait
            end
            return
        end


        function deleteknickfig(varargin)

            evalin('base','clear delknick');

        end


        function ListBoxCallBack(varargin)

            List = get(ListBox, 'Value');
            stream(curr_val).knickpoint(List) = [];

            info = evalin('base','info');
            savefile = strcat(info.path,'_stream.mat');
            strid = curr_val ;
            save(savefile,'stream','strid');

            add_histroy({strcat('Knickpoint No. ', num2str(List),' was deleted.')});

            assignin('base','stream',stream);
            evalin('base','clear delknick');
            closereq
            plotstream();
        end

    end



    function plotstream(varargin)

        num = get(Slider, 'Value');
        num = round(num);
        curr_val = round(num);
        cla
        
        plot(stream(num).len, stream(num).rawelevation(1:end),'r');
%         plot(stream(num).u(:,2), stream(num).v,'b');
        plot(stream(num).len, stream(num).elevation,'b');
        

        xlabel('Distance (km)','FontSize',10);
        ylabel('Elevation (m)', 'FontSize',10);
        ttl =  strcat('Longitudinal Profile for Stream No. ', num2str(num));
        title(ttl, 'FontSize',13);

        hold on

        knickpoints = [];
        try
            knickpoints = [knickpoints; (stream(curr_val).knickpoint)];
        catch
            stream(curr_val).knickpoint= [];
            knickpoints = [knickpoints; (stream(curr_val).knickpoint)];
        end

        for i = 1:1:length(knickpoints)
            plot(stream(num).len(knickpoints(i)), stream(num).elevation(knickpoints(i)),'ob');
            text(stream(num).len(knickpoints(i)), stream(num).elevation(knickpoints(i)),strcat('KP', num2str(i)));
        end

        add_histroy({strcat('Stream No. ', num2str(num),' is currently activated.')});

    end
end