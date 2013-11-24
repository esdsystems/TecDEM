function output=extract_stream_tind(start)
load_grid_base('base','FLOW');
flowdir = evalin('base','flowdir');
curvature = evalin('base','curvature');
ind=flowdir(start);
output = start;
k = 1;

while k

    if ind ~= -1
        output = [output; ind];
        
        if isnan(curvature(ind))
            return
        else

            ind = flowdir(ind);
        end

        %         if ind == flowdir(flowdir(ind))
        %
        % %         if sum(output == ind) > 0
        %
        %             flowdir(ind) = -1;
        %             ind = -1;
        %             assignin('base','flowdir',flowdir);
        %         end
        %

    else
        k = 0;
    end

end

