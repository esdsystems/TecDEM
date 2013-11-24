function full_report(varargin)

try
    stream  = evalin('base','stream');

    info  = evalin('base','info');


fr = [];

ind  =1;
for i = 1:1:length(stream)

    for j = 1:1:length(stream(i).m2)
        fr(ind,1:5) = [i; j; -stream(i).m1(j); -stream(i).m2(j); stream(i).Ks(j)];
        ind = ind + 1;
    end

end

total = unique(fr(:,2));
ltab = [];
mtab = [];
csteep = [];
sdtab1 = [];
sdtab2 = [];

for i = 1:1:total(end)

    ltab = [ltab length(fr(fr(:,2)==total(i),4))];
    mtab = [mtab mean(fr(fr(:,2)==total(i),4))];
    csteep = [csteep mean(fr(fr(:,2)==total(i),5))];
    sdtab1 = [sdtab1 std(fr(fr(:,2)==total(i),4))];
    sdtab2 = [sdtab2 std(fr(fr(:,2)==total(i),5))];
  
end

% cd(info.location(1:end-5))

fid = fopen(strcat(info.path,'_fullreport.txt'), 'wt');

fprintf(fid, ['Detailed Report for ' info.project_name(1:end-4)...
    '\n\nTotal Streams Studied:\t\t' num2str(length(stream)) ...
    '\nTotal Segment Studied:\t\t' num2str(sum(ltab)) ...
    '\nMaximum Segment in a Stream:\t' num2str(total(end)) ...
    '\nLowest Concavity in the Area:\t' num2str(min(fr(:,4))) ...
    '\nHighest Concavity in the Area:\t' num2str(max(fr(:,4))) ...
    '\nLowest Steepness in the Area:\t' num2str(min(fr(:,5))) ...
    '\nHighest Steepness in the Area:\t' num2str(max(fr(:,5))) ...
    '\nMean Concavity Value for Ksn:\t' num2str(-info.dtheta)]);

for i = 1:1:total(end)
    fprintf(fid, ['\n\nStreams Detail with Segment:\t\t' num2str(i)...
        '\nTotal Streams:\t\t\t' num2str(ltab(i)) ...
        '\nMean Concavity:\t\t' num2str(mtab(i)) ' ± ' num2str(sdtab1(i)) ...
        '\nMean Steepness:\t\t' num2str(csteep(i)) ' ± '  num2str(sdtab2(i)) ...
        '\n']);
end

fprintf(fid, '\n---\n\nEnd of Report');

fclose(fid);
% open('fullreport.txt');
catch
    msgbox('Not enough data to be ploted...!.....', 'Error');
    uiwait
    return
end

try
    info = evalin('base','info');
    filedisp(strcat(info.path,'_fullreport.txt'),'Detailed Analysis Report...')
catch
    msgbox('First Load DEM...!','Error');
end
% cd(curr_dir)
