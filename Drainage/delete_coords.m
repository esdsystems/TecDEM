function delete_coords(varargin)

stream  = evalin('base','stream');

curr_val  = evalin('base','curr_val');


dd = max(unique(stream(curr_val).bit));

if dd ~= 0

    prompt = {'Input:'};
    dlg_title = 'Trend Number';
    num_lines = 1;
    def = {num2str(dd),'hsv'};
    no = inputdlg(prompt,dlg_title,num_lines,def);

    if isempty(str2double(no))
        return
    end


    no = cell2struct(no,'val',1);
    dno = str2num(no.val);



    ind = find(stream(curr_val).bit == dno);

    stream(curr_val).bit(ind) = 0 ;

    try
        stream(curr_val).m1(dno) = [] ;
        stream(curr_val).m2(dno) = [] ;
        stream(curr_val).Ks(dno) = [] ;
        add_histroy({strcat('Trend No .',num2str(dno), ' was deleted on stream no. ', num2str(curr_val))});
    end

    assignin('base','stream',stream);
    info = evalin('base','info');

    savefile = strcat(info.path,'_stream.mat');
    save(savefile,'stream','stream')

else
    msgbox('No trend to delete.','Error')
end
end