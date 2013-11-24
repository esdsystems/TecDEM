function plot_streams()

% r = evalin('base','r');
try
    od = evalin('base','order');
catch
    
    str_plt_hand = evalin('base','str_plt_hand');
    
    close(str_plt_hand)
    
    return
end

try
    lin_width = evalin('base','lin_width');
catch
    lin_width = ones(12,1);
end
try
    orcol = evalin('base','lin_col');
catch
    orcol = [
        0.6  0.2    0;
        0    0.6    0;
        0.6   0     0.6;
        0     0     0;
        1     0     0;
        0     1     0;
        1     0     0
        0     0     1;
        1     1     0;
        1     0     1;
        0     1     1;
        1     1     1];
    
end

load_grid_base('caller','ADN');

hold on
% c = uisetcolor
for j = length(netwk_order_ind):-1:od
    
    for i = netwk_order_ind(j).ind
        
        plot(str_net(i).colid,str_net(i).rowid,'-','Color',orcol(j,:),'LineWidth',lin_width(j));
        %         plot(str_net(i).colid,str_net(i).rowid,strcat('-',orcol(str_net(i).order)),'Color',c)
        
    end
    pause(0.0001)
    
end

add_histroy({'Finished plotting Drainage Network.'});

