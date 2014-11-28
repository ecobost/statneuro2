%
%
%
%  given a vector of probabilities,
%   compute the log2-entropy
%
%
%
%
%


function H = entropy(p);

   p ( p==0 ) = 1;
   H = sum(-p.*log2(p));    
