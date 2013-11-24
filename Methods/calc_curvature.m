function cur=calc_curvature(output,bval)

% tind_basin= evalin('base','tind_basin');
% cur_base = evalin('base','cur_base');
% 
% output = tind_basin(cur_base).dist_output;
area_info = evalin('base','area_info');
[r c]=size(output);
L = area_info.res;
cur = nan*ones(size(output));

h = waitbar(0,strcat(num2str(0),'% Done'), 'Name',strcat('Curvature martix for basin no. ', num2str(bval)));

for i = 2:1:r-1
    waitbar((i)/(r),h,strcat(num2str(round(100*(i)/(r))),'% Done'));
    for j = 2:1:c-1

        z = output(i-1:1:i+1, j-1:1:j+1);

        D = ((z(4) + z(6))/2 -z(5))/(power(L,2));

        E = ((z(2) + z(8))/2 -z(5))/(power(L,2));

        cur(i,j) = -2 * (D +E) * 100;

    end
end

close(h)

cur = (cur.*output.^2);

% tind_basin(cur_base).cur = cur;
% 
% cla
% 
% imagesc(cur);
% 
% axis image
% colormap(jet)
% 
% ibr = tind_basin(cur_base).ymb;
% ibc = tind_basin(cur_base).xmb;
% 
% plot(ibc,ibr,'-k');
% 
% ibr = tind_basin(cur_base).ymr;
% ibc = tind_basin(cur_base).xmr;
% 
% plot(ibc,ibr,'-r');
% assignin('base','tind_basin',tind_basin);





