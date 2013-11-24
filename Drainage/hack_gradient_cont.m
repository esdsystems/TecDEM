function  res =hack_gradient_cont(stream,stepelevation)

elevation = stream.elevation;
len = stream.len;


n=floor((max(elevation) - min(elevation))/stepelevation);

newlen = len(1);
newelev = elevation(1);
newind = 1;

for i = 1:1:n
    val = elevation(1)-i*stepelevation;
    ind=min(find(elevation<=val));
    length = len(ind);
    newlen = [newlen  length];
    newelev = [newelev val];
    newind = [newind ind];
end

if newelev(end) ~= elevation(end)

    newlen = [newlen  len(end)];
    newelev = [newelev  elevation(end)];
    %     newind = [newind  length(elevation)];

end

%
%
% % % steplen = 1;
% % % totalstep = (max(len)-min(len))/steplen;
% % %
%
% % % newlen = min(len):(max(len)-min(len))/totalstep :max(len);
% % %
% % % newelev = interp1(len,elevation,newlen);
%
%

totals = max(size(newelev));

for i = 1:1:totals-1
    %     reach_center = (newlen(i+1) + newlen(i))/2;
    %     l = reach_center - newlen(1);
    dh = abs(newelev(i+1) - newelev(i));
    %     dl = abs(newlen((i+1)) - newlen(i));
    %     s(i) = (dh*l)/(dl)   ;
    try
        s(i) = (dh)/(log(newlen(i+1)) - log(newlen(i)));
    catch
        s(i) = 0;
    end
    
    if isinf(s(i))
        s(i) = 0;
    end

end

%
%
res = [newind ;s];