function [ entropies ] = calculate_entropies(data, binSize )
% Calculates the entropies of a matrix, the columns of which are
% the vectors for the entropy calculation


[numTrials,numNeurons] = size(data);
entropies=zeros(numNeurons,1);

for i=1:numNeurons
    
    histogram = hist(data(:,i),binSize)./numTrials;
    entropies(i) = entropy(histogram);

end

save('entropies.mat','entropies')

