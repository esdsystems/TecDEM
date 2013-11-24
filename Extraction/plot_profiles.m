function plot_profiles(strm)

try
    
    fig_profiles = evalin('base','fig_profiles');
    figure(fig_profiles);
    cla
catch
    
    fig_profiles = figure('Units','Pixels','Name','Extracted Profile','NumberTitle','off');
    tecfig = evalin('base','tecfig');
    pos=get(tecfig,'Position');
    set(fig_profiles,'Position',[pos(1) pos(2)+100 550 300 ]);
    
end
set(gcf,'CloseRequestFcn',@close_plot_profile);

try
plotyy(strm.len,strm.rawelevation,strm.len,strm.area)
end
hold on
plot(strm.len,strm.elevation)

xlabel('Length(Km)')
ylabel('Elevation(m)')
assignin('base','fig_profiles',fig_profiles)