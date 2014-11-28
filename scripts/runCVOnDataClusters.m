% Written by: Erick M. Cobos (erick.cobos@epfl.ch)
% Date: 2-Jun-2014

% Receives a matrix and runs 10 fold crosvalidation to compute the best number of neurons to use.
% Uses the entropy of the neurons as the selection criteria.
% Input: 
%	data: Matrix of M trials x N neurons (208X184)
% Output:
%	Plot 1: Likelihood per iteration for all number of neurons tried
%	Plot 2:	Final likelihood per neuron

function runCVOnDataClusters(firingRates)
	
	%Set parameters
	binSizeForEntropyCalc = 50;
	numberOfClustersToTry = [2 4 6 8 10 12];
	numberOfRandomInitializations = 5;
	numberOfNeurons= 15;
	numberOfIterations = 30;

	% Reorder columns according to entropy
	entropies = calculate_entropies(firingRates,binSizeForEntropyCalc);
	[_, newOrder] = sort(entropies, 'descend');
	firingRates = firingRates(:, newOrder);
	data = firingRates(:, 1:numberOfNeurons);
	
	% Run crossvalidation for each number of neurons
	generalLikelihoods = []; % Store best likelihood for each number of neurons
	for numberOfClusters = numberOfClustersToTry

		% Initialize local data
		bestLocalLikelihood = -inf;
		
		% Run EM with different random initializations
		for i = [1:numberOfRandomInitializations]
			[_, _, _, _, likelihood] = EMX(data, numberOfClusters, numberOfIterations);
			if likelihood(end) > bestLocalLikelihood
				bestLocalLikelihood = likelihood;
			end
		end
		
		% Add best likelihood obtained for this number of neurons		
		generalLikelihoods = [generalLikelihoods bestLocalLikelihood];
	end

	% Plot likelihood per iteration for each number of neurons
	figure();
	hold on;
	numberOfLines = size(generalLikelihoods)(2);
	palette = jet(numberOfLines);
	for i = 1:numberOfLines
		plot(generalLikelihoods(:,i), 'color', palette(i,:));
	end
	title('Likelihood per iteration');
	xlabel('Iteration');
	ylabel('Likelihood');
	legends = [];
	for n = numberOfClustersToTry
		legends = [legends; ['# Clusters = ' num2str(n)]];
	end
	legend(legends,'location', 'southeast');
	print('plots/likelihoodPerIterationClusters.eps','-depsc');

	% Plot final likelihoods for all iterations
	figure();
	plot(numberOfClustersToTry, generalLikelihoods(numberOfIterations,:));
	title('Final likelihood per neuron');
	xlabel('Number of clusters');
	ylabel('Likelihood');

	print('plots/likelihoodPerCluster.eps','-depsc');
end
