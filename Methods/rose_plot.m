function rose_plot(varargin)

tind_basin = evalin('base','tind_basin');
dir = [];

tecfig = evalin('base','tecfig');
pos=get(tecfig,'Position');

prompt={'Rose Plot for which basin no.'};
name='Enter Basin No.';
numlines=1;
defaultanswer={'0'};

answer=inputdlg(prompt,name,numlines,defaultanswer);
answer  = strcat('[',answer{:},']');
answer = eval(answer);

if answer == 0
    for i = 1:1:length(tind_basin)

        dir = [dir;tind_basin(i).Tdir];

    end
    add_histroy({'Rose diagram of orientation vector is plotted for all basins.'});
else

    for i = 1:1:length(answer)
    dir = [dir;tind_basin(answer(i)).Tdir];
    end
    
    add_histroy({strcat('Rose diagram of orientation vector is plotted for basin no. ', num2str(answer))});
end
% 
if ~isempty(dir)

    fig = figure('Units','Pixels','Name','Drainage Basin Asymmetry','NumberTitle','off');

    set(fig,'Position',[pos(1)+100 pos(2) 350 300]);

    rose(deg2rad(dir))
    view(90,-90)

    hline = findobj(gca,'Type','line');
    set(hline,'Color','b','LineWidth',1.5)
else
    msgbox('No data available','Data Error')
end
ttl =  'Drainage Basin Asymmetry';
title(ttl, 'FontSize',13);

