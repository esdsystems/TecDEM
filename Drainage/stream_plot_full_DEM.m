function stream_plot_full_DEM(varargin)
% 
% try
%     stream=evalin('base','stream');
% catch
%     stream = struct('lat',[],'lon',[],'x',[],'y',[],'len',[],'elevation',[],'area',[],'bit',[],'knickpoint',[],'hack_cont',[],...
%         'u',[],'v',[],'logarea',[],'logslope',[],'m1',[],'m2',[],'Ks',[]);
% end


try
    fig  = evalin('base','str_plt_hand');
    figure(fig)
    clf
    set(fig ,'Name','Extracted Drainage Network','NumberTitle','off','MenuBar','none');

catch
    fig = figure('Units','Pixels','Name','Extracted Drainage Network','NumberTitle','off','MenuBar','none');
    tecfig = evalin('base','tecfig');
    pos=get(tecfig,'Position');
    set(fig,'Position',[pos(1) pos(2) 550 400 ]);
end

set(gcf,'CloseRequestFcn',@close_plot);

% assignin('base','curr_val',curr_val);
file_manu = uimenu(fig,'Label','File');
% e_using =  uimenu(file_manu,'Label','Base Plot');
% uimenu(e_using,'Label','Digital Elevation Model','Callback',@plot_grid_extract,'Accelerator','G');
% uimenu(e_using,'Label','Drainage Network','Callback',@plot_drainage_extract,'Accelerator','N');
mnuopenproject =  uimenu(file_manu,'Label','Color Coding','Callback',@stream_coding,'Accelerator','w');

mnuopenproject =  uimenu(file_manu,'Label','Refresh Plot','Callback',@plot_grid_extract_referesh,'Accelerator','r');
mnuopenproject =  uimenu(file_manu,'Label','Exit','Callback',@close_plot,'Separator','on','Accelerator','X');

edt_manu = uimenu(fig,'Label','Edit');
mnuopenproject =  uimenu(edt_manu,'Label','Delete Stream','Callback',@delete_stream,'Accelerator','D');
mnuopenproject =  uimenu(edt_manu,'Label','Subtract Streams','Callback',@substract_stream,'Accelerator','T');

ext_manu = uimenu(fig,'Label','Extract');
ext = uimenu(ext_manu,'Label','Identify','Callback',@extract_specific_stream ,'Accelerator','a');
ext =    uimenu(ext_manu,'Label','Save','Callback',@save_specific_stream , 'Accelerator','s');
assignin('base','str_plt_hand',fig);

try
    plot_col  = evalin('base','plot_col')';
catch
    plot_col = ['k';'r'];
end

assignin('base','plot_col',plot_col);
assignin('base','disptyp','grid');
assignin('base','extfig',fig);

% assignin('base','stream',stream);
plot_grid_extract();


end
