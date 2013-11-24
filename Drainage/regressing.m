function regressing(varargin)

stream  = evalin('base','stream');

curr_val = evalin('base','curr_val');

no = evalin('base','tno');

add_histroy({strcat('Trend No .',num2str(no), ' selected on stream no. ', num2str(curr_val))});

[m, Ks]= regress_plot(stream(curr_val),no);

stream(curr_val).m1(no) = m(1);
stream(curr_val).m2(no) = m(2);
stream(curr_val).Ks(no) = Ks;

a =strcat('Slope = ', num2str(m(1)));
b =strcat('Theta = ',num2str( -m(2)));
c =strcat('Ks = ', num2str(Ks));
pt = strcat('Regression Analysis results for Trend No.', num2str(no));

prompt = {pt,a,b,c};

msgbox(prompt,'Regression Analysis');
assignin('base','stream',stream);

info = evalin('base','info');

savefile = strcat(info.path,'_stream.mat');

        strid = curr_val ;
        save(savefile,'stream','strid');

end