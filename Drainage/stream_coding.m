function stream_coding(varargin)

plot_fig = evalin('base','str_plt_hand');
pos=get(plot_fig,'Position');
c = get(gcf,'Color');
try
    colfig = evalin('base','colfig');
    figure(colfig);

catch
    colfig = figure('Units','Pixels','Resize','off');
end

assignin('base','colfig',colfig);

set(colfig,'Name','Color Coding','MenuBar','none','Resize','off','NumberTitle','off');
set(colfig,'Position',[pos(1)+150 pos(2)+200 200 100]);
y = -13;
okb= uicontrol('Style','pushbutton','String','OK','Position',[20,y+15,80,20], 'HorizontalAlignment','Left','Callback',@okbutton);
canb = uicontrol('Style','pushbutton','String','Cancel','Position',[100,y+15,80,20],'HorizontalAlignment','right','Callback',@canbutton);
y = y+35;
List = {'blue','green','red','white','cyan','magenta','yellow','black'};
text8 = uicontrol('Style','text','String','Other Streams','Position',[5,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
Edit3 = uicontrol('Style','PopupMenu','String',List,'Position',[120,y+15,80,20],'HorizontalAlignment','right');

y = y+35;
List = {'red','white','blue','green','cyan','magenta','yellow','black'};
text8 = uicontrol('Style','text','String','Selected Stream','Position',[5,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
Edit2 = uicontrol('Style','PopupMenu','String',List,'Position',[120,y+15,80,20],'HorizontalAlignment','right');

% y = y+25;
% List = {'red','white','blue','green','cyan','magenta','yellow','black'};
% text8 = uicontrol('Style','text','String','Current Stream','Position',[5,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
% Edit1 = uicontrol('Style','PopupMenu','String',List,'Position',[120,y+15,80,20],'HorizontalAlignment','right');

    function okbutton(h, eventdata)
        
        cl = ['b';'g';'r';'w'; 'c'; 'm';'y';'k'];
        col = cl;
        Val = get(Edit3,'Value');
        col(2) = cl(Val);


        Val = get(Edit2,'Value');
        cl = ['r'; 'w';'b';'g';'c'; 'm'; 'y';'k'];
        col(1) = cl(Val);
        
%         
%         Val = get(Edit1,'Value');
%         col(1) = cl(Val);
%         
        col = col(1:2);
        assignin('base','plot_col',col);
        
        closereq
        plot_grid_extract_referesh();
        
        
    end

    function canbutton(h, eventdata)

        assignin('base','plot_col',['k';'r';'g']);
        closereq
    end
end