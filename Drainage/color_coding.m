function color_coding(varargin)

try
col = ['b'; 'g';'r';'c';'m'; 'y'; 'k';'w'];

logfig = evalin('base','logfig');

pos=get(logfig,'Position');
 
c = get(gcf,'Color');
List = {'blue','green','red','cyan','magenta','yellow','black','white'};
colfig = figure('Units','Pixels','Name','Coding','NumberTitle','off','Resize','off');
set(colfig,'MenuBar','none');
set(colfig,'Position',[pos(1)+100 pos(2)+100 200 250]);

y = 0;
okb= uicontrol('Style','pushbutton','String','OK','Position',[10,y+15,80,20], 'HorizontalAlignment','Left','Callback',@okbutton);
canb = uicontrol('Style','pushbutton','String','Cancel','Position',[100,y+15,80,20],'HorizontalAlignment','right','Callback',@canbutton);
y = y+25;
List = {'white','blue','green','red','cyan','magenta','yellow','black'};
text8 = uicontrol('Style','text','String','Trend No. 8','Position',[10,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
Edit8 = uicontrol('Style','PopupMenu','String',List,'Position',[100,y+15,80,20],'HorizontalAlignment','right');

y = y+25;
List = {'black','white','blue','green','red','cyan','magenta','yellow'};
text7 = uicontrol('Style','text','String','Trend No. 7','Position',[10,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
Edit7 = uicontrol('Style','PopupMenu','String',List,'Position',[100,y+15,80,20],'HorizontalAlignment','right');
y = y+25;
List = {'yellow','black','white','blue','green','red','cyan','magenta'};
text6 = uicontrol('Style','text','String','Trend No. 6','Position',[10,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
Edit6 = uicontrol('Style','PopupMenu','String',List,'Position',[100,y+15,80,20],'HorizontalAlignment','right');
y = y+25;
List = {'magenta','yellow','black','white','blue','green','red','cyan'};
text5 = uicontrol('Style','text','String','Trend No. 5','Position',[10,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
Edit5 = uicontrol('Style','PopupMenu','String',List,'Position',[100,y+15,80,20],'HorizontalAlignment','right');
y = y+25;
List = {'cyan','magenta','yellow','black','white','blue','green','red'};
text4 = uicontrol('Style','text','String','Trend No. 4','Position',[10,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
Edit4 = uicontrol('Style','PopupMenu','String',List,'Position',[100,y+15,80,20],'HorizontalAlignment','right');
y = y+25;
List = {'red','cyan','magenta','yellow','black','white','blue','green'};
text3 = uicontrol('Style','text','String','Trend No. 3','Position',[10,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
Edit3 = uicontrol('Style','PopupMenu','String',List,'Position',[100,y+15,80,20],'HorizontalAlignment','right');
y = y+25;
List = {'green','red','cyan','magenta','yellow','black','white','blue'};
text2 = uicontrol('Style','text','String','Trend No. 2','Position',[10,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
Edit2 = uicontrol('Style','PopupMenu','String',List,'Position',[100,y+15,80,20],'HorizontalAlignment','right');
y = y+25;
List = {'blue','green','red','cyan','magenta','yellow','black','white'};
text1 = uicontrol('Style','text','String','Trend No. 1','Position',[10,y+12,130,20], 'HorizontalAlignment','Left', 'BackgroundColor',c);
Edit1 = uicontrol('Style','PopupMenu','String',List,'Position',[100,y+15,80,20],'HorizontalAlignment','right');
location = '';

catch
    msgbox('Problem with your data set','Error')
end

    function okbutton(h, eventdata)

        cl = ['b'; 'g';'r';'c';'m'; 'y'; 'k';'w'];
        col = cl;
        Val = get(Edit1,'Value');
        col(1) = cl(Val);

        Val = get(Edit2,'Value');
        cl = ['g';'r';'c';'m'; 'y'; 'k';'w';'b'];
        col(2) = cl(Val);

        Val = get(Edit3,'Value');
        cl = ['r';'c';'m'; 'y'; 'k';'w';'b';'g'];
        col(3) = cl(Val);

        Val = get(Edit4,'Value');
        cl = ['c';'m'; 'y'; 'k';'w';'b';'g';'r'];
        col(4) = cl(Val);

        Val = get(Edit5,'Value');
        cl = ['m'; 'y'; 'k';'w';'b';'g';'r';'c'];
        col(5) = cl(Val);

        Val = get(Edit6,'Value');
        cl = ['y'; 'k';'w';'b';'g';'r';'c';'m'];
        col(6) = cl(Val);

        Val = get(Edit7,'Value');
        cl = ['k';'w';'b';'g';'r';'c';'m';'y'];
        col(7) = cl(Val);

        Val = get(Edit8,'Value');
        cl = ['w';'b';'g';'r';'c';'m';'y';'k'];
        col(8) = cl(Val);

        assignin('base','col',col)
        closereq

    end

    function canbutton(h, eventdata)

        cl = ['b'; 'g';'r';'c';'m'; 'y'; 'k';'w'];
        assignin('base','col',cl)
        closereq
    end
end