function isobase=isobasetest(strahler, elevation)

[r c]=size(strahler);

isobase = -9999*ones(r,c);
pst = 1;
for i = 1:1:r
    for j = 1:1:c

        if strahler(i,j) == 2 || strahler(i,j) == 3
            isobase(i,j) = elevation(i,j);
        end

    end
    percent = round(100*(i*j)/(r*c));

    %
    if percent == pst*1
        pause(0.000001)
        pst = pst +1;
        add_comments({strcat(num2str(percent),' Percent of calculation done')});
    end

end

end