function table_report(varargin)

curr_dir = pwd;

try
    stream  = evalin('base','stream');

    info  = evalin('base','info');


    fr = [];

    ind  =1;
    for i = 1:1:length(stream)

        for j = 1:1:length(stream(i).m2)
            fr(ind,1:5) = [i; j; stream(i).m1(j); -stream(i).m2(j); stream(i).Ks(j)];
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

    fid = fopen(strcat(info.path,'_tablereport.txt'), 'wt');

    fprintf(fid, ['Tabulated Report for '  info.project_name(1:end-4) '\n\nStream No.\t Segment No.\tIntercept\tConcavity\tSteepness'...
        '\n==============================================================\n']);
    fprintf(fid, '%6.0f\t %6.0f\t %6.4f\t %6.2f\t %6.2f \n', fr(:,1:5)');
    fprintf(fid, '==============================================================');
    fprintf(fid, '\n---\n\nEnd of Report');
    fclose(fid);
catch
    msgbox('No enough data to plot...!.....', 'Error');
    uiwait
    return
end
try
    info = evalin('base','info');
    filedisp(strcat(info.path,'_tablereport.txt'),'Tabulated Report...');

catch
    msgbox('First Load DEM...!','Error');
end








