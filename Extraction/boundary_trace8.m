function bout = boundary_trace8(td)
%Function to trace the basin boundary.
% Faisal Shahzad
basinmatrix = evalin('base','basinmatrix');
netwk_order_ind  = evalin('base','netwk_order_ind');
str_net  = evalin('base','str_net');
bout = struct('ibr',[],'ibc',[],'obr',[],'obc',[],'dir',[]);

[ra ca] = size(basinmatrix);
basinmatrix(1:2,1:end) = nan;
basinmatrix(end-1:end,1:end) = nan;
basinmatrix(1:end,1:2) = nan;
basinmatrix(1:end,end-1:end) = nan;

for id = 1:1:length(netwk_order_ind(td).ind)

    str = find(basinmatrix == id);

    [r c] = ind2sub([ra ca],str(1));
    %

    rr = [-1 -1 -1; 0 0 0; 1 1 1];
    cc = rr';

    dir = 3;
    ndir = dir;
    ibr = r;
    ibc = c;

    i = 1;

    while i

        sub = basinmatrix(r-1:r+1,c-1:c+1)==id ;
        order = [9 8 7 4 1 2 3 6];
        dirmat  = [3 4 5; 2 nan 6; 1 0 7]';
        stind = find(order == find(dirmat == dir));

        nord = [order(stind:end), order(1:stind-1)];

        out = nord(sub(nord));

        r = r + rr(out(1));
        c = c + cc(out(1));

        if and(r == ibr(1), c == ibc(1))
            i = 0;
        end

        dir = dirmat(out(1)) ;
        ibr = [ibr r];
        ibc = [ibc c];
        ndir = [ndir dir];

        bout(id).dir = dir;

        if mod(dir,2) == 1
            dir = mod(dir+6,8);
        else
            dir = mod(dir+7,8);
        end
        
        
    end

    if length(str_net(netwk_order_ind(td).ind(id)).rowid) == 1
        
        ar = str_net(netwk_order_ind(td).ind(id)).rowid(1);
        ac = str_net(netwk_order_ind(td).ind(id)).colid(1);

    else
        
        ar = str_net(netwk_order_ind(td).ind(id)).rowid(end-1);
        ac = str_net(netwk_order_ind(td).ind(id)).colid(end-1);
        
    end


    bout(id).ibr = ibr(1:end);
    bout(id).ibc = ibc(1:end);
    bout(id).dir = ndir(1:end);
    bout(id).outlet_r = ar;
    bout(id).outlet_c = ac;

end