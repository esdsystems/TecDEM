function filedisp(textfile,titlename)

try
    fig =evalin('base','reportfig');
    figure(fig)
    set(fig,'MenuBar','none','Resize','off','Name',titlename,'NumberTitle','off');
catch

    fig = figure('Units','Pixels','Name',titlename,'NumberTitle','off','Resize','off');
    set(fig,'MenuBar','none');

end
tecfig = evalin('base','tecfig');
pos=get(tecfig,'Position');
set(fig,'Position',[pos(1)+30  pos(2)+30 400 400 ]);
fid=fopen(textfile,'r');

id=1;
while 1
    
    theline = fgetl(fid);

    if ~ischar(theline), 
        break 
    end
    
    s{id}=theline; 
    id=id+1;
end

dispout=uicontrol(fig,'Units','normalized','Position',[0,0,1,1],'Style','edit','Max',100,'String',s, 'HorizontalAlignment','left','BackgroundColor','w');

assignin('base','reportfig',fig)