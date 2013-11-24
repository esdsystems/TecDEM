function add_comments(str)

dispout = evalin('base','dispout');

s = get(dispout,'String');

lin = length(s);
s(2:lin+1) = s(1:end);
s(1)= str;
set(dispout,'String',s);