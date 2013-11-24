function sp_plot(varargin)
try
    info = evalin('base','info');
catch
    msgbox('No data to export', 'Error')
    return
end

try

    dno =inputdlg('Enter Stream No.','Input',1,{'1'});
    if ~isempty(str2double(dno))
        assignin('base','curr_val',str2double(dno));
        stream_plot_specific();
    else
        return
    end
catch

    return

end

add_comm_line();

end