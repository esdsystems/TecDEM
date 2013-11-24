function output=extract_stream(start)

flowdir = evalin('base','flowdir');
bit = zeros(size(flowdir));

ind=flowdir(start);
output = start;
k = 1;
bit(start) = 1;

while k

    if ind ~= -1
        
        if bit(ind) == 0
        
            bit(ind) = 1;
            output = [output; ind];
            ind = flowdir(ind);
        else
            k = 0;
        end
        
    else
        k = 0;
    end

end

