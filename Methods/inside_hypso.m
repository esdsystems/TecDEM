function inside_hypso(num)

try
    hyp_basin = evalin('base','hyp_basin');
    boundary  = evalin('base','boundary');
end

cla;

for i = 1:length(hyp_basin)
plot(hyp_basin(i).rel_A,hyp_basin(i).rel_H,'k','LineWidth',2)

hold on
end
plot(hyp_basin(num).rel_A,hyp_basin(num).rel_H,'r','LineWidth',2)

text(0.05,0.20,strcat('Hi     : ', num2str(boundary(num).Hi)))
text(0.05,0.15,strcat('Skewness : ',num2str(hyp_basin(num).sk)))
text(0.05,0.1,strcat('Kurtosis  : ',num2str(hyp_basin(num).ku)))

axis square
xlabel('a/A','FontSize',10);
ylabel('h/H', 'FontSize',10);
ttl =  strcat('Hypsometry Plot for Basin No. ', num2str(num));
title(ttl, 'FontSize',13);


add_histroy({strcat('Basin No. ', num2str(num),' is currently activated.')});