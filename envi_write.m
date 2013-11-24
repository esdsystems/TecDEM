function envi_write(data,R)
% envi_write(data,R,filename)
%
% Function to save the gridded data in ENVI format.
% data is the grided data which we want to write and R is the Refernce
% Matrix (see help makerefmat). filename is the string which is the name of output file .
%
%
% Written By
% Faisal Shahzad
% Remote Sensing Group
% TU Bergakademie Freiberg,
% Germany
% www.rsg.tu-freiberg.de

info = evalin('base','info');

[filename, pathname] = uiputfile(strcat(info.path,'*.hdr'),'Save as ENIV Header');

files = strcat(pathname,filename);
if isempty(files)
    return
end

[r c]=size(data);
data = single(data);
data(isnan(data)) = -9999;
fid = fopen(files(1:end-4),'w');
fwrite(fid,data,'single');
fclose(fid);

fid = fopen(strcat(files),'w');
fprintf(fid,'%s \n','ENVI');
fprintf(fid,'%s \n','description = {');
fprintf(fid,'%s \n','TecDEM: 1.0}');
fprintf(fid,'%s %i \n','samples =',r);
fprintf(fid,'%s %i \n','lines   =',c);
fprintf(fid,'%s %i \n', 'bands   =',1);
fprintf(fid,'%s %i \n', 'data type =',4);
fprintf(fid,'%s \n','interleave = bsq');
fprintf(fid,'%s \n','map info = {Geographic Lat/Lon, 1.0000, 1.0000,',num2str(R(3,1)),','...
    ,num2str(R(3,2)),',',num2str(R(2,1)),',' ,num2str(-R(1,2)),' WGS-84,units=Degrees}');
fclose(fid);

end