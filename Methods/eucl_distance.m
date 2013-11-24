function output = eucl_distance(data,bval)

% tind_basin = evalin('base','tind_basin');
% cur_base = evalin('base','cur_base');

% % data = tind_basin(cur_base).cdata;

ref=find(data == 0);
output = nan * ones(size(data));
total=length(ref);

h = waitbar(0,strcat(num2str(0),'% Done'), 'Name',strcat('Distance matrix for basin no. ', num2str(bval)));

for i = 1:length(ref)
%     100*i/total
    waitbar(i/total,h,strcat(num2str(round(100*i/total)),'% Done'));
    [r1 c1]=ind2sub(size(data),ref(i));
    [r2 c2]=ind2sub(size(data),[1:numel(data)]);
    res=sqrt(power((r1 - r2),2) + power((c1 - c2),2));
    output1 = reshape(res,size(data));
    res=output1-output;
    ind=find(res > 0);
    temp = output(ind);
    output = output1;
    output(ind) = temp ;
  
end

close(h)
% cla
% imagesc(output);
% axis image
% colormap(jet)
% axis on
% hold on
% 
% tind_basin(cur_base).dist_output = output;
% 
% ibr = tind_basin(cur_base).ymb;
% ibc = tind_basin(cur_base).xmb;
% plot(ibc,ibr,'-k');
% 
% ibr = tind_basin(cur_base).ymr;
% ibc = tind_basin(cur_base).xmr;
% 
% plot(ibc,ibr,'-r');
% 
% assignin('base','tind_basin',tind_basin);
