function export_results(varargin)

try
    info = evalin('base','info');
catch
    msgbox('No data to export', 'Error')
    return
end

area_info = evalin('base','area_info');
assignin('base','curr_val',1);

res1 = area_info.PixelScale(1);
res2 = area_info.PixelScale(2);
y1 = area_info.TiePoints.WorldPoints.Y;
x1 = area_info.TiePoints.WorldPoints.X;

R = makerefmat(x1, y1,res1,-res2);

assignin('base','R',R);
dispout = evalin('base','dispout');
tecfig = evalin('base','tecfig');

pos = get(tecfig,'Position');
add_comments({'Export function called.'});

fg=figure('MenuBar','none','Name','Export Results','NumberTitle','off','Position',[pos(1)+50,pos(2)+300,300,150],'Resize','off','closeRequestFcn',@canc_but);
colr = get(gcf,'Color');
hp = uipanel('BackgroundColor',colr,'Position',[.05 .05 .9 .90]);

typ = {'SHP: GIS Format','Binary: ENVI Header'};

% typ = {'SHP: GIS Format'};

Edit = uicontrol('Style','Text','String','Export Format:','Position',[25,115,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
typedit = uicontrol('Style','PopupMenu','String',typ,'Position',[120,115,140,20], 'HorizontalAlignment','Left','BackgroundColor',colr,'CallBack',@br_but);

shp = {'Extracted Streams','Sub Basins','Selected Streams','Concavity','Steepness', 'Uplift Rates','Hack Index','Knickpoints','T Index'};
Edit = uicontrol('Style','Text','String','Grid Name:','Position',[25,85,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
grdedit = uicontrol('Style','PopupMenu','String',shp,'Position',[120,85,140,20], 'HorizontalAlignment','Left','BackgroundColor',colr);

% Edit = uicontrol('Style','Text','String','Location: ','Position',[25,55,100,15], 'HorizontalAlignment','left','BackgroundColor',colr);
% grdedit1 = uicontrol('Style','pushbutton','String','Browse for location','Position',[120,55,140,20], 'HorizontalAlignment','Left','BackgroundColor',colr, 'CallBack',@br_but);

Edit = uicontrol('Style','pushbutton','String','Export','Position',[75,15,50,25], 'HorizontalAlignment','left','BackgroundColor',colr, 'CallBack',@ok_but);
ncols = uicontrol('Style','pushbutton','String','Close','Position',[170,15,50,25], 'HorizontalAlignment','Left','BackgroundColor',colr, 'CallBack',@canc_but);

location = info.path;

    function br_but(varargin)

        shp = {'Extracted Streams','Sub Basins','Selected Streams','Concavity','Steepness', 'Uplift Rates','Hack Index','Knickpoints','T Index'};
        grd = {'Digital Elevation Model', 'Isobase Map', 'Incision Map','Drainage Density','Vertical Dissection'};
        tval = get(typedit,'Value');

        if tval == 1

            set(grdedit,'String',shp);

        else

            set(grdedit,'String',grd);

        end


    end

    function canc_but(varargin)
        add_histroy({'Export function closed.'});
        closereq
        add_comm_line();
    end

    function ok_but(varargin)

        tval = get(typedit,'Value');
        gval = get(grdedit,'Value');

        sval = 100*tval+gval;


        switch sval

            case 101

                load_grid_base('base','ADN');
                export_auto_streams();
                add_histroy({'Automatically extracted drainage network exported'});
                evalin('base','clear netwk_order_ind str_map str_net strid')

            case 102

                prompt={'Thresh hold by Strahler order'};
                name='Options for subbasin extraction';
                numlines=1;
                defaultanswer={'3'};
                typ=inputdlg(prompt,name,numlines,defaultanswer);

                if isempty(typ)
                    return
                else
                    lt = typ(1);
                    lt = cell2mat(lt);

                    td = str2num(lt);
                end

                load_grid_base('base',strcat(num2str(td),'BSN'))
                %                 load_grid_base('base','BSN');
                export_auto_basin();
                add_histroy({'Automatically extracted sub basins exported'});
                evalin('base','clear basinmatrix boundary rivers srid td')

            case 103
                load_grid_base('base','stream')
                export_streams();
                add_histroy({'Selected streams are exported'});

            case 104
                load_grid_base('base','stream')
                export_theta();
                add_histroy({'Concavity index exported'});

            case 105
                load_grid_base('base','stream')
                export_ks();
                add_histroy({'Steepness index exported'});

            case 106
                load_grid_base('base','stream')
                export_uplift();
                add_histroy({'Uplift rate map exported'});

            case 107
                load_grid_base('base','stream')
                export_hack_con();
                add_histroy({'Hack index exported'});

            case 108
                load_grid_base('base','stream')
                export_knickpoints();
                add_histroy({'Knickpoints exported'});

            case 109
                prompt={'Thresh hold by Strahler order'};
                name='Options for subbasin extraction';
                numlines=1;
                defaultanswer={'3'};
                typ=inputdlg(prompt,name,numlines,defaultanswer);

                if isempty(typ)
                    return
                else
                    lt = typ(1);
                    lt = cell2mat(lt);

                    td = str2num(lt);
                end

                load_grid_base('base',strcat(num2str(td),'CRT'))

                load_grid_base('base','CRT')
                export_tind();
                add_histroy({'Tindex exported'});
                evalin('base','clear curvature tind_basin')

            case 201
                load_grid_base('base','DEM')
                grd = evalin('base','dem');
                envi_write(grd',R);
                add_histroy({'Digital Elevation Model exported'});
                evalin('base','clear dem grd');

            case 202
                load_grid_base('base','ISO')
                grd = evalin('base','isobase');
                envi_write(grd',R);
                add_histroy({'Isobase map is exported'});
                evalin('base','clear isobase grd');

            case 203
                load_grid_base('base','INC')
                grd = evalin('base','incision');
                envi_write(grd',R);
                add_histroy({'Incision map is exported'});
                evalin('base','clear incision grd');

            case 204
                load_grid_base('base','DND')
                grd = evalin('base','dr_density');
                envi_write(grd',R);
                add_histroy({'Drainage density map is exported'});
                evalin('base','clear incision grd');
            case 205
                load_grid_base('base','VD')
                grd = evalin('base','vertical_diss');
                envi_write(grd',R);
                add_histroy({'Vertical Dissection map is exported'});
                evalin('base','clear vertical_diss grd');
            otherwise

                add_histroy({'No data available for export'});
        end


    end

end
