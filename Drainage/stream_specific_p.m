function stream_specific_p(curr_val)

% info  = evalin('base','info');

stream  = evalin('base','stream');


title('LOG AREA SLOP GRAPH','fontsize',12,'fontweight','b');


plot(stream(curr_val).logarea,stream(curr_val).logslope,'g+');

xlabel('Log Area','FontSize',11);
ylabel('Log Slope','FontSize',11);
tt = strcat('Log Area/Slope Plot of Stream # ',num2str(curr_val));
title(tt,'FontSize',13);
end

