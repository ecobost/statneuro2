function I = information( P )
% P is a matrix with non-negative entries summing to one
 p1 = sum(P);
 p2 = sum(P');
 Pind = meshgrid(p1,p2).*meshgrid(p2,p1)';
 I = sum( P(P>0).*log2(P(P>0)./Pind(P>0)) );
end

