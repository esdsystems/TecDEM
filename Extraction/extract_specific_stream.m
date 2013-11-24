function extract_specific_stream(varargin)

extractt = evalin('base','str_plt_hand');

strax = evalin('base','strax');

if extractt == 0
    msgbox('First Plot Gird or Drainage Network', 'Error');
    return
end


r = evalin('base','r');

load_grid_base('base','FLOW');

res = evalin('base','area_info.res');


try
    plot_col  = evalin('base','plot_col')';
catch
    plot_col = ['k';'r'];
end


% % try
%     strcut= evalin('base','strcut');
%     gcf
%     set(strcut,'Visible','off')
%
%  %end

try
    strhand = evalin('base','strhand');
    set(strhand,'Visible','off')
end

extfig = evalin('base','extfig');

figure(extfig);

axes(strax);

[x y]=ginput(1);
x = round(x);
y = round(y);

to =sub2ind(r,y,x);

% if to ~= 0

output = extract_stream(to);
strm = extract_param(output);

% end

hold on
disptyp = evalin('base','tp');
if strcmp(disptyp,'dem')
    strhand=plot(strm.y,strm.x,strcat('-',plot_col(1)),'LineWidth',2);
else
    strhand=plot(strm.y,strm.x,strcat('-',plot_col(1)),'LineWidth',2);
end

plot_profiles(strm)

assignin('base','strm',strm)
assignin('base','strhand',strhand)
