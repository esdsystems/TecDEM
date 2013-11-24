function [xmid ymid xbod ybod Tind orient]=Tindex(x,y,xa,ya,xx,yy,cint,nc)

nxx = x(1:cint:end);
nyy = y(1:cint:end);
midxx = x(round(cint/2):cint:end);
midyy = y(round(cint/2):cint:end);

xmid = [];
ymid = [];
xbod = [];
ybod = [];
Tind = [];
orient = [];
%
total = length(nxx)-1;
h = waitbar(0,strcat(num2str(0),'% Done'), 'Name','Calculating T Index ..');

for i = 1:1:length(nxx)-1

        waitbar(i/total,h,strcat(num2str(round(100*i/total)),'% Done'));
    
    [xint yint xa1 ya1 T ang]=Tindex_intersections(xx,yy,xa,ya,nxx(i),nyy(i),nxx(i+1),nyy(i+1), midxx(i),midyy(i),nc);
    if ~or(isnan(xint),isnan(yint))
        xmid = [xmid; xint];
        ymid = [ymid; yint];
        xbod = [xbod; xa1];
        ybod = [ybod; ya1];
        Tind = [Tind; T];
        orient = [orient; ang];
    end

end

close(h);

assignin('base','nxx',nxx)
assignin('base','nyy',nyy)

assignin('base','midxx',midxx)
assignin('base','midyy',midyy)