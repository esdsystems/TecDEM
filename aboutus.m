function aboutus(varargin)

dispout = evalin('base','dispout');
tecfig = evalin('base','tecfig');

pos = get(tecfig,'Position');

fg=figure('MenuBar','none','Name','About TecDEM ver. 2.0','NumberTitle','off','Position',[pos(1)+50,pos(2)+180,350,250],'Resize','off');
colr = get(gcf,'Color');
% colr = 'r'
hp = uipanel('BackgroundColor',colr,'Position',[.05 .05 .9 .90]);

Edit = uicontrol('Style','Text','String','TecDEM ver. 2.0','Position',[130,215,150,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','Build Date: 28/10/2010 under R2008b','Position',[85,195,210,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','TecDEM is distributed under GNU liscence. It has ','Position',[30,170,295,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','been financed by Saxony Ministry and IAMG.','Position',[40,150,275,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','For more details contact:','Position',[110,130,205,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','Faisal Shahzad','Position',[123,105,205,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','Remote Sensing Group','Position',[103,90,205,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','Institute of Geology','Position',[113,75,205,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','Freiberg Unviersity of Mining and Technology','Position',[50,60,265,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','Bernhard von cotta strasse-2, D-09599, Freiberg, Germany.','Position',[30,45,295,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','www.rsg.tu-freiberg.de','Position',[102,30,205,15], 'HorizontalAlignment','left','BackgroundColor',colr);
Edit = uicontrol('Style','Text','String','geoquaidian@gmail.com','Position',[102,15,205,15], 'HorizontalAlignment','left','BackgroundColor',colr);
end
