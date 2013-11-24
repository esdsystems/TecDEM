function hyp_comp(varargin)

hyp_basin = evalin('base','hyp_basin');
dir = [];

prompt={'Hypsometric Plot for which basin no.'};
name='Enter Basin No.';
numlines=1;
defaultanswer={'0'};

answer=inputdlg(prompt,name,numlines,defaultanswer);
answer  = strcat('[',answer{:},']');
answer = eval(answer);

if answer == 0

    answer = [1:1:length(hyp_basin)];

end

figure;
if ~isempty(answer)

    for i = 1:1:length(answer)
    
        num = answer(i);
        hold on
        plot(hyp_basin(num).rel_A,hyp_basin(num).rel_H,'k','LineWidth',2)
        
    end
    
    axis square
    xlabel('a/A','FontSize',10);
    ylabel('h/H', 'FontSize',10);
    title('Hypsometry Plot', 'FontSize',13);

    box on
    add_histroy({strcat('Basin No. ', num2str(num),' is currently activated.')});

end