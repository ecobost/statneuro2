function [ output_args ] = displayMatrix( M )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

imagesc(M);
colormap('Jet')
axis square;
colorbar
end

