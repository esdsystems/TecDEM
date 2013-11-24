function [str_net netid]= prepare_network(str_net,to1,in)

flowdir = evalin('base','flowdir');
pzero = evalin('base','pzero');
str_map = evalin('base','str_map');

[rt ct] = st_pt_stream(to1);

nid = sub2ind(size(flowdir),rt,ct);
outid = [];
netid = [];

for i = 1:1:length(nid)
    
    tid = nid(i);
    str_map(tid) = in;
    outid = [outid; tid];
    
    id = flowdir(tid);
    
    %     try
    if id ~= -1
        
        id2 = pzero(id);
        
    else
        id2 = pzero(tid);
        
    end
    
    while and(id2 == 1, id ~= -1)
        str_map(id) = in;
        outid = [outid; id];
        id = flowdir(id);
        
        if id ~= -1
            id2 = pzero(id);
            %             str_map(id) = in;
            tid = id;
        end
        
    end
    
    if and(length(outid)> 1, tid ~= -1)
        
        outid = [outid; tid];
        
    elseif flowdir(tid) ~= -1
        outid = [outid; flowdir(tid)];
    end
    
    
    %     catch
    %         continue
    %     end
    [r c] = ind2sub(size(flowdir),outid);
    srid = length(str_net)+1;
    str_net(srid).id= i;
    str_net(srid).rowid = r;
    str_net(srid).colid = c;
    str_net(srid).order = in;
    netid = [netid srid];
    outid = [];
    
end


assignin('base','str_map',str_map);



