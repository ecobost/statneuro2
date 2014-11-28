function histograms = calculate_2D_histograms(data)
% Creates the 2D histograms for all the unique combinations of columns(neurons)
% saves the histograms in a a cell array.

[~,dimy] = size(data);

combInds = combnk(1:dimy,2);  % Find the unique combination indices of columns
dimComb  = size(combInds,1);  % Calculate the number of these combinations
save('combInds.mat','combInds'); % Save them in case of emergency!

% Initialize the cell array which will have all 2D histograms of the unique
% combinations of neurons

histograms = cell(dimComb);  

for i=1:dimComb
    
    % for each combination pick the respective neuron
    
    X = data(:,combInds(i,1)); 
    Y = data(:,combInds(i,2)); 
    
    % calculate the 2D histogram
    H = hist3([X Y], [round(max(X))+1 round(max(Y))+1]);
    %H = histogram2D(X,Y);
    histograms{i} = H./sum(H(:));
end

%save('histograms.mat','histograms')
end

