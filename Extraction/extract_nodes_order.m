function extract_nodes_order(netwk_order_ind,str_net)

s = struct('nodeid',[],'order',[],'col',[],'row',[]);
s(1).nodeid = [];

ind = 2;
for ord = 1:1:length(netwk_order_ind)
    
    strms = netwk_order_ind(ord).ind;
    
    for i = 1:1:length(strms)
        
        s(ind).nodeid = i;
        s(ind).order = ord;
        s(ind).row = str_net(strms(i)).rowid(1);
        s(ind).col = str_net(strms(i)).colid(1);
       
        ind = ind + 1;
    end
end

assignin('base','str_nodes',s)