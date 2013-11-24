function work_log_save(varargin)

dispout = evalin('base','dispout');

s = get(dispout,'String');

s = flipud(s);

info = evalin('base','info');

[filename, pathname] = uiputfile(strcat(info.path,'*.txt'),'Save as Text File');

if filename == 0
    return
end

files = strcat(pathname,filename);



fid = fopen(files, 'wt');

for i = 1:1:length(s)

    news = s{i};
    ind = strfind(news,'\');
    news(ind) = '/'; 
    fprintf(fid,strcat(news,'\n'));

end

fclose(fid);