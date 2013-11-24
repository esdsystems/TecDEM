function extract_tindex(varargin)

tind_basin = evalin('base','tind_basin');
cur_base = evalin('base','cur_base');
curvature = evalin('base','curvature');

xm = tind_basin(cur_base).xm;
ym = tind_basin(cur_base).ym;

x = tind_basin(cur_base).ibc;
y = tind_basin(cur_base).ibr;


xx = tind_basin(cur_base).xr;
yy = tind_basin(cur_base).yr;

area_info = evalin('base','area_info');
res = area_info.res;
nc = max(x);

% cdata = tind_basin(cur_base).cdata;

prompt={'Enter segment length (kms)'};
name='Segment Length';
numlines=1;
defaultanswer={'2'};

answer=inputdlg(prompt,name,numlines,defaultanswer);

options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';


answer  = str2double(answer{1});

res = 1000 /res;

answer = ceil(answer * res);


[xmid ymid xbod ybod Tind orient]=Tindex(xm,ym,x,y,xx,yy,answer,nc);

% % cla
% % imagesc(cdata)
% % colormap(gray)
%
hold on
%
% plot(xx,yy,'-')
% plot(x,y,'-k')
% plot(xm,ym,'k-','LineWidth',2)
% hold on
add_histroy({strcat('T Indes calculated for basin no.',num2str(cur_base))});

for i = 1:1:length(xbod)

    if and(~isnan(xmid(i)), ~isnan(xbod(i)))
        %         arrow([xmid(i) ymid(i)],[midxx(i) midyy(i)],'Length',6)
        arrow([xbod(i) ybod(i)],[xmid(i) ymid(i)],'Length',6)

    end
end
%


tind_basin(cur_base).Tind = Tind;
tind_basin(cur_base).Tvec = [xmid ymid xbod ybod];
tind_basin(cur_base).Tdir = orient;

assignin('base','tind_basin',tind_basin);

info = evalin('base','info');
td = evalin('base','td');

savefile = strcat(info.path,'_',num2str(td),'CRT.mat');

% savefile = strcat(info.path,'_CRT.mat');
save(savefile,'curvature','tind_basin');
