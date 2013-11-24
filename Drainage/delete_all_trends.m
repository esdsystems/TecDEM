function delete_all_trends(varargin)

stream  = evalin('base','stream');

curr_val  = evalin('base','curr_val');

% try
if length(unique(stream(curr_val).bit)) > 1
    stream(curr_val).bit = zeros(size(stream(curr_val).len))  ;
    
    add_histroy({strcat('All trends were deleted on stream no. ', num2str(curr_val))});
    
    msgbox('All trends deleted.','Info');
    assignin('base','stream',stream);
    info = evalin('base','info');
    
    savefile = strcat(info.path,'_stream.mat');
    save(savefile,'stream','stream')
else
    msgbox('No trend to delete.','Error');
end

% catch
%     msgbox('No trend to delete.','Error');
% end

end