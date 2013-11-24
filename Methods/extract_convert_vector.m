function extract_convert_vector(varargin)

tind_basin = evalin('base','tind_basin');
cur_base = evalin('base','cur_base');

k = 1;
x = [];
y = [];

while k

    [a b c] = ginput(1);


    if c == 3
        k = 0;
    else

        x = [x round(a)];
        y = [y round(b)];
        
    end
end

nnx = [];
nny = [];

for i = 1:1:length(x)-1
    pt1 = [x(i) y(i)];
    pt2 = [x(i+1) y(i+1)];
    [nx ny] = interp2pt(pt1,pt2);
    nnx = [nnx nx];
    nny = [nny ny];

end

tind_basin(cur_base).xm = nnx;
tind_basin(cur_base).ym = nny;

hold on

plot(nnx,nny,'k-','LineWidth',2)

add_histroy({strcat('Basin mid line is identified for basin no.',num2str(cur_base))});

assignin('base','tind_basin',tind_basin);

