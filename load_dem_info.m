function load_dem_info(varargin)

dispout = evalin('base','dispout');
tecfig = evalin('base','tecfig');


pos = get(tecfig,'Position');
[areaname,location]=uigetfile('*.tif');

if areaname ~= 0
%     add_histroy({'Start loading Digital Elevation Model.'});
    fls = strcat(location,areaname);
    area_info = geotiffinfo(fls);

    fg=figure('MenuBar','none','Name','DEM Properties','NumberTitle','off','Position',[pos(1)+100,pos(2)+100,210,320],'Resize','off');
    colr = get(gcf,'Color');
    hp = uipanel('BackgroundColor',colr,'Position',[.05 .74 .9 .19]);

    ny = area_info.Height;
    nx = area_info.Width;
    Edit = uicontrol('Style','Text','String','No. of Cols/Samps: ','Position',[20,270,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
    ncols = uicontrol('Style','Edit','String',ny,'Position',[140,270,50,20], 'HorizontalAlignment','Right');

    Edit = uicontrol('Style','Text','String','No. of Rows/Lines: ','Position',[20,245,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
    nrows = uicontrol('Style','Edit','String',nx,'Position',[140,245,50,20], 'HorizontalAlignment','Right');

    hp = uipanel('BackgroundColor',colr,'Position',[.05 .4 .9 .33]);

    res1 = area_info.PixelScale(1);
    res2 = area_info.PixelScale(2);

    y1 = area_info.TiePoints.WorldPoints.Y;
    x1 = area_info.TiePoints.WorldPoints.X;

    y2 = y1-ny*res2;
    x2 = x1+nx*res1;

    Edit = uicontrol('Style','Text','String','North Edge Value: ','Position',[20,210,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
    northedge = uicontrol('Style','Edit','String',y1,'Position',[140,210,50,20], 'HorizontalAlignment','Right');

    Edit = uicontrol('Style','Text','String','South Edge Value: ','Position',[20,185,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
    southedge = uicontrol('Style','Edit','String',y2,'Position',[140,185,50,20], 'HorizontalAlignment','Right');

    Edit = uicontrol('Style','Text','String','West Edge Value: ','Position',[20,160,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
    westedge = uicontrol('Style','Edit','String',x1,'Position',[140,160,50,20], 'HorizontalAlignment','Right');

    Edit = uicontrol('Style','Text','String','East Edge Value: ','Position',[20,135,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
    eastedge = uicontrol('Style','Edit','String',x2,'Position',[140,135,50,20], 'HorizontalAlignment','Right');


    hp = uipanel('BackgroundColor',colr,'Position',[.05 .13 .9 .26]);

    Edit = uicontrol('Style','Text','String','Min Value: ','Position',[20,100,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
    nrows = uicontrol('Style','Edit','String','','Position',[140,100,50,20], 'HorizontalAlignment','Right');

    Edit = uicontrol('Style','Text','String','Max Value: ','Position',[20,75,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
    nrows = uicontrol('Style','Edit','String','','Position',[140,75,50,20], 'HorizontalAlignment','Right');

    ee = uicontrol('Style','Text','String','Resolution: ','Position',[20,50,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
    ress = uicontrol('Style','Edit','String',res1,'Position',[140,50,50,20], 'HorizontalAlignment','Right');


    uicontrol('Style','PushButton','String','Import','Position',[10,10,50,20],'CallBack',@ImportPressed);
    uicontrol('Style','PushButton','String','Save','Position',[70,10,60,20],'CallBack',@SavePressed);
    uicontrol('Style','PushButton','String','Close','Position',[140,10,60,20],'CallBack',@closePressed);



end



    function ImportPressed(h, eventdata)

        evalin('base','clear all')

        assignin('base','dispout',dispout);
        assignin('base','tecfig',tecfig);

        dem = geotiffread(fls);
        %dem = dem(2:end-1,2:end-1);
        rawdem = double(dem);

        %         disp('Removing the pits');
        %
        %         inde=find(dem == -9999);
        %         [ic, id] = ixneighbors(dem,inde);
        %         holes = [ic, id];
        %
        %         for i = 1:1:length(inde)
        %             %
        %             indexs=find(holes(:,1) == inde(i));
        %             dem(inde(i))= max(dem(indexs));
        %         end
        %         disp('Pits removed.. Now saving your data.');

        assignin('base','rawdem',rawdem);

        savefile = strcat(fls(1:end-4),'_rawDEM.mat');
        save(savefile,'rawdem','-v7.3')

        SavePressed();


    end

    function SavePressed(h, eventdata)

        res = str2num(get(ress,'String'));
        info.dtheta = -0.45;
        info.path = fls(1:end-4);
        info.project_name = areaname;
        res = 110000*res1;
        area_info.res = res;

        assignin('base','info',info);
        assignin('base','area_info',area_info);
        assignin('base','r',[ny nx]);
        assignin('base','res',res);

        savefile = strcat(fls(1:end-4),'_INFO.mat');
        save(savefile,'area_info','info')
        dem_info_write()


        textfile = strcat(info.path,'_info.txt');

        fid=fopen(textfile,'r');

        while 1
            tline = fgetl(fid);

            if ~ischar(tline),

                break

            end

            add_histroy({tline});
        end


        add_histroy({'Digital Elevation Model loaded successfully.'});
        add_comm_line();
        assignin('base','tecfig',tecfig);
        close(fg)
    end

    function closePressed(h, eventdata)

        add_histroy({'Digital Elevation Model can not be loaded successfully.'});
        add_comm_line();
        close(fg)
    end

end