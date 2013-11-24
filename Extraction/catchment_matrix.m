function catchment_matrix(td)
% assignin basin identification numbers.
% Faisal Shahzad
info  = evalin('base','info');
bsngrd  = evalin('base','bsngrd');
netwk_order_ind  = evalin('base','netwk_order_ind');
str_net  = evalin('base','str_net');

add_histroy({'Assigning Basin Identification Numbers.'});

pst = 1;



ttl = 0;

for ord = 1:1:td-1;
    
    ttl = ttl + length(netwk_order_ind(ord).ind);
    
end
prev = 0;
for ord = 1:1:td-1;
    
    strid=netwk_order_ind(ord).ind;
    for kk = 1:1:length(strid)
        prev = prev + 1;
        percent = round(100*prev/ttl);
        
        if percent == pst*1
            pause(0.001);
            pst = pst +1;
            add_comments({strcat(num2str(percent),' Percent of assignment done')});
        end
        
        
        if str_net(strid(kk)).order == ord
            r1 = str_net(strid(kk)).rowid(end);
            c1 = str_net(strid(kk)).colid(end);
            ind1 = sub2ind(size(bsngrd),r1,c1);
            bsngrd(imag(bsngrd) == strid(kk)) = bsngrd(ind1);
        end
    end
end

uids = unique(imag(bsngrd(real(bsngrd)==td)));

basinmatrix = zeros(size(bsngrd));

for ij = 1:1:length(uids)
    basinmatrix(imag(bsngrd) == uids(ij)) = ij;
end

basinmatrix(:,1) = 0;
basinmatrix(:,end) = 0;
basinmatrix(1,:) = 0;
basinmatrix(end,:) = 0;

assignin('base','basinmatrix',basinmatrix);
assignin('base','td',td);

boundary = boundary_trace8(td);
boundary = basin_parameters(boundary);    

assignin('base','boundary',boundary);

savefile = strcat(info.path,'_',num2str(td),'BSN.mat');
% savefile = strcat(info.path,'_BSN.mat');
save(savefile,'basinmatrix','td','boundary','-v7.3');

add_histroy({strcat('A total of .',num2str(length(netwk_order_ind(td).ind)),' basin(s) are extracted')});

