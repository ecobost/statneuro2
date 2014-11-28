close all;
clear all;

load rates_all;

bins = 50;

% calculate entropies from data
disp('Calculating and saving entropies...')

calculate_entropies(rates_all, bins);

disp('done!')

% create all the 2D histograms

disp('Calculating 2D histograms...')

Hs = calculate_2D_histograms(rates_all);

disp('done!')

% calculate respective informations

disp('Calculating and saving pairwise mutual informations...')

I = calculate_informations(Hs);

disp('done!')
%{
clear Hs
figure; displayMatrix(I);
xlabel('Number of Neuron');
ylabel('Number of Neuron')
title('Mutual Information Matrix')
%}
disp('Calculating and saving gauss mutual informations...')

Igauss = calculate_gauss_informations(rates_all);

disp('done!')

figure; displayMatrix(Igauss);
xlabel('Number of Neuron');
ylabel('Number of Neuron')
title('Gauss Mutual Information Matrix')