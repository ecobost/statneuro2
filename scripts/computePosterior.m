function [posteriors, clusters] = computePosterior(firingRates)

	binSizeForEntropyCalc = 50;
	numberOfRandomInitializations = 20;
	numberOfClusters = 8;
	numberOfIterations = 40;
	numberOfNeurons = 15;

%{
	% Reorder columns according to entropy and highFiring
	entropies = calculate_entropies(firingRates,binSizeForEntropyCalc);
	[_, entropyIndices] = sort(entropies, 'descend');
	[_, newOrder1] = sort(entropyIndices);

	highResponses = std(firingRates);
	[_, responseIndices] = sort(highResponses, 'descend');
	[_, newOrder2] = sort(responseIndices);

	newOrder = (newOrder1' + 0.5*newOrder2)./2;
	[_, finalOrder] = sort(newOrder);

	firingRates = firingRates(:, finalOrder);
	data = firingRates(:, 1:numberOfNeurons);

	% Filter uninteresting data
%}

	% Reorder columns according to entropy
	entropies = calculate_entropies(firingRates,binSizeForEntropyCalc);
	[_, newOrder] = sort(entropies, 'descend');
	firingRates = firingRates(:, newOrder);
	data = firingRates(:, 1:numberOfNeurons);

	% Run EM with different random initializations and select best parameters
	generalLikelihoods = []; % Store best likelihood for each number of neurons
	bestLocalLikelihood = -inf;
	for i = [1:numberOfRandomInitializations]
		[alphaL, meansL, covmxL, _, likelihood] = EMX(data, numberOfClusters, numberOfIterations);
		if likelihood(end) > bestLocalLikelihood
			bestLocalLikelihood = likelihood;
			alpha = alphaL;
			means = meansL;
			covmx = covmxL;
		end
		generalLikelihoods = [generalLikelihoods likelihood];
	end
	
	% Calculate posteriors
	for k = 1:numberOfClusters
		posteriors(:,k) = alpha(k)*mvnpdfX(data, means(k,:),covmx(:,:,k));
	end

	% Order the posteriors by p(c) to try and match always the same configuration
	[_, order] = sort(alpha);
	posteriors = posteriors(:,order);
		
	% Assign clusters
	[_ clusters] = max(posteriors');

	% Plot likelihood per iteration
	figure();
	hold on;
	numberOfLines = size(generalLikelihoods)(2);
	palette = jet(numberOfLines);
	for i = 1:numberOfLines
		plot(generalLikelihoods(:,i), 'color', palette(i,:));
	end
	title('Likelihood per iteration using 15 Neurons');
	xlabel('Iteration');
	ylabel('Likelihood');
	hold off;
	print('plots/likelihoodPerRunWith15_S.eps','-depsc');

	% Plot labels
	figure();
	bar(clusters);
	axis([0 size(clusters)(2)+1]);
	title('Assignments for each trial');
	xlabel('Trial index');
	ylabel('Cluster #');
	print -depsc 'plots/BarOfClassification_S';
	

	% Plot histograms with distribution of results
	figure();
	hist(clusters,8);
	title('Distribution of trials over clusters');
	xlabel('Cluster');
	ylabel('Number of trials');
	print -depsc 'plots/HistogramOfClassification_S';
 
end

% Taken from Octave-Forge. Same defintion as mvnpdf in Matlab
function y = mvnpdfX(x, mu, sigma)
	[d p] = size(x);
	r = chol (sigma);
	y = (2*pi)^(-p/2) * exp (-sumsq ((x-mu)/r, 2)/2) / prod (diag (r));
end
