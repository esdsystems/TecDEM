function hyp_comparison(varargin)
try
    tind_basin = evalin('base','hyp_basin');
    boundary  = evalin('base','boundary');
end

prompt={'Hypsometric moments for which basin no.'};
name='Enter Basin No.';
numlines=1;
defaultanswer={'0'};

answer=inputdlg(prompt,name,numlines,defaultanswer);
answer  = strcat('[',answer{:},']');
answer = eval(answer);

if answer == 0

    answer = [1:1:length(tind_basin)];

end


H = [];
S = [];
K = [];

for i = 1:1:length(answer)
    num=answer(i);
    H = [H boundary(num).Hi];
    S = [S tind_basin(num).sk];
    K = [K tind_basin(num).ku];

end


figure('Name','Statistical Moments of Hypsometic Curve','NumberTitle','off')

hold on

plot(H,'r-d')
plot(S,'g-s')
plot(K,'k-^')
box on
xlabel('Basin Numbers','FontSize',10);
ylabel('Values', 'FontSize',10);
title('Statistical Moments of Hypsometric Curves', 'FontSize',13);
legend('Hypsometric Integral','Hypsometric Skewness','Hypsometric Kurtosis')

set(gca,'xTick',[1:1:length(answer)],'XTickLabel',answer)

add_histroy({'Statistical Moments of Hypsometric Curve for all basins is plotted.'});