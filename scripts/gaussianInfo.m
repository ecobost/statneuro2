function I = gaussianInfo( X,Y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

covM = cov(X,Y);


I = 0.5.*log2(covM(1,1).*covM(2,2)./det(covM));

end

