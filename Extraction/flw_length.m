function val = flw_length(r1,c1,ele1,r2,c2,ele2,res)


lent = res .* sqrt(power((r2-r1),2)+ power((c2-c1),2));

dele = ele1 - ele2;

val = sqrt(power(lent,2) + power(dele,2));
val = val/res;
