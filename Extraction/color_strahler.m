function color_strahler()

tecfig = evalin('base','tecfig');

pos = get(tecfig,'Position');

fg=figure('MenuBar','none','Name','Export Results','NumberTitle','off','Position',[pos(1)+50,pos(2)+40,270,450],'Resize','off','closeRequestFcn',@exit_but);
colr = get(gcf,'Color');
hp = uipanel('BackgroundColor',colr,'Position',[.05 .89 .9 .10]);

Edit = uicontrol('Style','Text','String','Minimum Strahler Order: ','Position',[45,415,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
stord = uicontrol('Style','Edit','String','3','Position',[200,415,40,20], 'HorizontalAlignment','Left','BackgroundColor',colr);

hp = uipanel('BackgroundColor',colr,'Position',[.05 .08 .9 .78]);


edt = uicontrol('Style','Text','String','Strahler order No.: ','Position',[25,360,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
typedit = uicontrol('Style','Text','String','Width','Position',[125,360,40,15], 'HorizontalAlignment','Left','BackgroundColor',colr);
by1 = uicontrol('Style','Text','String','Color','Position',[200,360,40,15], 'HorizontalAlignment','Left','BackgroundColor',colr);

orcol = [
    0.6  0.2    0;
    0    0.6    0;
    0.6   0     0.6;
    0     0     0;
    1     0     1;
    0     1     0;
    1     0     0
    0     0     1;
    1     1     0;
    1     0     1;
    0     1     1;
    1     1     1];

k = 1;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid1 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls1 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(1,:),'CallBack',@str_col);


k = 2;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid2 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls2 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(2,:),'CallBack',@str_col);


k = 3;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid3 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls3 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(3,:),'CallBack',@str_col);

k = 4;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid4 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls4 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(4,:),'CallBack',@str_col);

k = 5;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid5 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls5 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(5,:),'CallBack',@str_col);


k = 6;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid6 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls6 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(6,:),'CallBack',@str_col);


k = 7;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid7 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls7 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(7,:),'CallBack',@str_col);


k = 8;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid8 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls8 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(8,:),'CallBack',@str_col);


k = 9;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid9 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls9 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(9,:),'CallBack',@str_col);


k = 10;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid10 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls10 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(10,:),'CallBack',@str_col);


k = 11;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid11 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls11 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(11,:),'CallBack',@str_col);

k = 12;
edt = uicontrol('Style','Text','String',strcat('Strahler order',num2str(k)),'Position',[25,355-k*25,170,15], 'HorizontalAlignment','left','BackgroundColor',colr);
wid12 = uicontrol('Style','Edit','String','1','Position',[125,355-k*25,40,20], 'HorizontalAlignment','right','BackgroundColor','w');
cls12 = uicontrol('Style','pushbutton','String','','Position',[200,355-k*25,40,20], 'HorizontalAlignment','Left','BackgroundColor',orcol(12,:),'CallBack',@str_col);


oks = uicontrol('Style','pushbutton','String','Plot','Position',[55,7,50,25], 'HorizontalAlignment','left','BackgroundColor',colr, 'CallBack',@ok_but);
ext = uicontrol('Style','pushbutton','String','Cancel','Position',[150,7,50,25], 'HorizontalAlignment','Left','BackgroundColor',colr, 'CallBack',@exit_but);

lin_width = [];
lin_col = [];
    function exit_but(varargin)

        closereq

    end

    function str_col(varargin)
        
        cl =        uisetcolor;
        set(gco,'BackgroundColor',cl)

    end

    function ok_but(varargin)

        for i = 1:1:12

            lin_width= [lin_width; str2num(eval(strcat('get(wid',num2str(i),',''String'')')))];

        end

        for i = 1:1:12

            lin_col= [lin_col; eval(strcat('get(cls',num2str(i),',''BackgroundColor'')'))];

        end

        ord=str2num(get(stord,'String'));

        assignin('base','order',ord);
        assignin('base','lin_col',lin_col);
        assignin('base','lin_width',lin_width);

        
        close
    end


end



