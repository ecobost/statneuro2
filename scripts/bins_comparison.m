clear all;
close all;

load rates_all.mat;

NumBins = 100;
Number_of_neurons = 184;

binRange = 1:1:NumBins;
LbinRange = length(binRange);
entropies = zeros(LbinRange,Number_of_neurons);

for i=1:LbinRange
    
    % calculate all the entropies for different bin size
    entropies(i,:) = calculate_entropies(rates_all,binRange(i));
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2D plot of the entropies of all the neurons for different N
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure()
hold on;
plot(1:184,entropies(10,:),'r');
plot(1:184,entropies(50,:),'b');
plot(1:184,entropies(100,:),'g');
hold off;
legend('N=10','N=50','N=100')
xlabel('Neurons')
ylabel('Entropy')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3D plot of the entropies of all the neurons for different N
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure() 
h = zeros(Number_of_neurons,1);
hold on;

for i=1:Number_of_neurons
    h(i) = plot(binRange, entropies(:,i),'color',rand(1,3),'Linewidth',2);
    set(h(i), 'ZData',ones(LbinRange,1)*i)
end

box on;
view(3);
xlabel('N'); ylabel('Entropy'); zlabel('Number of Neurons')
xlim([0,NumBins]); ylim([0,6]); zlim([0,Number_of_neurons])


figure()
plot(binRange, mean(entropies,2))
xlabel('Number of Bins')
ylabel('All Entropies Meaned')

