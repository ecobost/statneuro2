function I = calculate_gauss_informations( data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[~,numNeurons] = size(data);

combInds = combnk(1:numNeurons,2);  % Find the unique combination indices of columns
dimComb  = size(combInds,1);        % Calculate the number of these combinations

I = zeros(numNeurons);

for i=1:dimComb
    
    X = data(:,combInds(i,1)); 
    Y = data(:,combInds(i,2));
    
    n = combInds(i,1);
    m = combInds(i,2);

    temp = gaussianInfo(X,Y);
    
    I(n,m) = temp;
    I(m,n) = temp;
end

save('gaussInfoMat.mat','I');

