function output=flow_stream_basin(start)

flowdir = evalin('base','flowdir');
bsngrd = evalin('base','bsngrd');

ind=flowdir(start);
output = start;
k = 1;

while k

    if ind ~= -1

        if bsngrd(ind) == 0
            output = [output; ind];
            try
            if ind == flowdir(flowdir(ind))
                k = 0;
            else
                
            ind = flowdir(ind);
            end
            catch
                ind = flowdir(ind);
            end
        else
            k = 0;
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

