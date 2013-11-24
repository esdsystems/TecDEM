function create_pzero(noval)

parea = evalin('base','str_map');
flowdir= evalin('base','flowdir');
r= size(flowdir);

to = flowdir(parea == noval);
tzero = zeros(r);

for i = 1:1:length(to)

    if to(i) ~= -1
        tzero(to(i)) = tzero(to(i))+1;
    end

end

assignin('base','pzero',tzero);