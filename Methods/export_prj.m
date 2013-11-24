function export_prj(files)


fid=fopen('wgs84.prj','r');

id=1;
while 1
    
    theline = fgetl(fid);
    
    if ~ischar(theline),
        break
    end
    
    s{id}=theline;
    id=id+1;
    theline;
end

try
    
    fid = fopen(files, 'wt');
    
    for i = 1:1:length(s)
        
        news = s{i};
        ind = strfind(news,'\');
        news(ind) = '/';
        fprintf(fid,strcat(news,'\n'));
        
    end
    
    fclose(fid);
catch
end