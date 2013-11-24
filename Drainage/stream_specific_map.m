function stream_specific_map(no)

% info  = evalin('base','info');

stream  = evalin('base','stream');

curr_val = evalin('base','curr_val');

% no =inputdlg('Enter smoothing factor','Input',1,{'20'});
%
% no = str2double(no{1});

[u,v,logarea,logslope] = arrange_data(stream(curr_val),no);

stream(curr_val).lon= stream(curr_val).lon(2:end);
stream(curr_val).lat= stream(curr_val).lat(2:end);
stream(curr_val).x= stream(curr_val).x(2:end);
stream(curr_val).y= stream(curr_val).y(2:end);
stream(curr_val).len= stream(curr_val).len(2:end);
stream(curr_val).elevation= stream(curr_val).elevation(2:end);
stream(curr_val).area= stream(curr_val).area(2:end);
stream(curr_val).bit= stream(curr_val).bit(2:end);

stream(curr_val).u = u(2:end,:);
stream(curr_val).v = v(2:end);

stream(curr_val).logarea = logarea;
stream(curr_val).logslope = logslope;

assignin('base','stream',stream);


title(strcat('Map view of Stream No. ',num2str(curr_val)),'fontsize',12,'fontweight','b');


plot(stream(curr_val).y,stream(curr_val).x,'r');

xlabel('Log Area','FontSize',11);
ylabel('Log Slope','FontSize',11);
tt = strcat('Map view of Stream # ',num2str(curr_val));
title(tt,'FontSize',13);
end

