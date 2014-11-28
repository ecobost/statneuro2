% Modified by: Erick Cobos T. (erick.cobo@epfl.ch)
% Compatible with octave and returns likelihood


%% EM algorithm for D dimensional data with K clusters
%%      data: contains a data vector in each row
%%      K: number of clusters (mixture components)
%%      Niter: number of iterations
         

function [alpha, means, covmx, postprob, likelihood] = EMX(data, K, Niter)
	N = size(data,1);   % number of data points
	D = size(data,2);   % dimension

	% Init alpha(?)
	alpha = 1/K*ones(K,1);
	%alpha = rand(K,1);
	%alpha = alpha./sum(alpha);

	% Init means
	inds = randi(N, [K,1]);
	means = data(inds,:);

	% Init covariance
	covmx = zeros(D,D,K);
	covs = diag(cov(data,1)); %1-row vector
	for c=1:K
		covmx(:,:,c) = diag(covs);
		%covmx(:,:,c) = diag(rand(D,1).*covs); % Random
		%covmx(:,:,c) = mean(covs)*eye(D); % I*sig
	end

	% Init likelihoods
	likelihood=zeros(Niter,1);

	% EM iterations
	for i=1:Niter
	    %E step - class membership probabilities
	    postprob = zeros(N,K); %rows: diffent data points, columns: classes
	    for c=1:K
		%postprob(:,c) = mvnpdf(data,means(c,:),covmx(:,:,c))*alpha(c);
		postprob(:,c) = mvnpdfX(data,means(c,:),covmx(:,:,c))*alpha(c);
	    end
	    % normalizing each row
	    postprob = postprob./repmat(sum(postprob,2),[1,K]);

	    %M step - updating parameters (alpha, means, covmx)
	    alpha = 1/N* sum(postprob,1);
	    for c=1:K
		means(c,:) = 1/(alpha(c)*N) * sum(data.*repmat(postprob(:,c),[1,D]),1);
		cov_temp = zeros(D,D);
		for d=1:N
		    cov_temp = cov_temp + 1/(alpha(c)*N) * postprob(d,c)* (data(d,:).-means(c,:))'*(data(d,:).-means(c,:)); 
		end

		covmx(:,:,c) = diag(diag(cov_temp)); % Diagonal
		%covmx(:,:,c) = mean(diag(cov_temp))*eye(D); % Identity*sigma
	    end
	
%{
		% Set same covariance for all
		sum_cov = zeros(D,D);
		for c=1:K
			sum_cov = sum_cov .+ covmx(:,:,c)./K;
		end
		for c=1:K
			covmx(:,:,c) = sum_cov;
		end
%}		
	    
	    % Calculating likelihood
	    l_d = zeros(N,1);
	    for d=1:N
		l_c = zeros(K,1);
		for c=1:K
		    l_c(c) = alpha(c)* mvnpdfX(data(d,:), means(c,:),covmx(:,:,c));   
		end
		l_d(d) = log(sum(l_c));  
	    end

	    likelihood(i) = sum(l_d);
	end
end

% Taken from Octave-Forge. Same defintion as mvnpdf in Matlab
function y = mvnpdfX(x, mu, sigma)
	[d p] = size(x);
	r = chol (sigma);
	y = (2*pi)^(-p/2) * exp (-sumsq ((x-mu)/r, 2)/2) / prod (diag (r));
end
