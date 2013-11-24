function extraction_profile()
stream  = evalin('base','stream');

curr_val = evalin('base','curr_val');

coor = evalin('base','c');

backupDATA2a = stream(curr_val).len;

bit = stream(curr_val).bit;

ind = find(backupDATA2a >= coor(1) & backupDATA2a <= coor(2));

dd = max(unique(stream(curr_val).bit));


prompt = {'Input:'};
dlg_title = 'Trend Number';
num_lines = 1;
def = {num2str(dd+1),'hsv'};
no = inputdlg(prompt,dlg_title,num_lines,def);

try
    no = cell2struct(no,'val',1);
    no = str2num(no.val);

    % bit(ind) = no;

    stream(curr_val).bit(ind) = no;

    evalin('base','clear c');

    assignin('base','tno',no);

    assignin('base','stream',stream);
catch
    return
end