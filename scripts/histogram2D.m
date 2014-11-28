function  H  = histogram2D(X,Y)
% Calculates the 2D histogram of two vectors

% Round all the rates of neuron X and neuron Y
X = round(X); Y = round(Y);

numTrials = size(X,1);  % Number of trials. Presumably 208

% Store the max rates plus one of both neuron vectors
max_N1 = max(X)+1; max_N2 = max(Y)+1; 
min_N1 = min(X); min_N2 = min(Y); 

% Create two arrays of rates with a step of 1 rate
N1_range = min_N1:max_N1; N2_range = min_N2:max_N2; 

lenN1 = length(N1_range); lenN2 = length(N2_range);
index_i = 1:lenN1; index_j = 1:lenN2;

% create all the combinations of rate pair indices

[p,q] = meshgrid(index_i, index_j);
inds = [p(:) q(:)];

% calculate their length
Lpairs = size(inds,1);

% Initialize the histogram
H = zeros(lenN1,lenN2);

for i = 1:Lpairs         % for all the combination indices pairs
    for j=1:numTrials    % parse all the X,Y pairs
        
     % if the rates with the ith respective indices is found in X,Y 
     % add one count to the histogram
     
     if (N1_range(inds(i,1)) == X(j) && N2_range(inds(i,2))==Y(j))
         
        H(inds(i,1),inds(i,2)) = H(inds(i,1),inds(i,2)) + 1;
        
     end
     
    end
end

end

