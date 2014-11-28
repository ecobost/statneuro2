function [] = graphMatrix( I )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%# 60-by-60 sparse adjacency matrix
A = I;
N = length(A);


%# x/y coordinates of nodes in a circular layout
r =  1;
theta = linspace(0,2*pi,N+1)'; theta(end) = [];
xy = r .* [cos(theta) sin(theta)];

%# labels of nodes
txt = cellstr(num2str((1:N)','%02d'));

p = symrcm(A);
A = A(p,p);
txt = txt(p);
%# show nodes and edges
line(xy(:,1), xy(:,2),'LineStyle','none', ...
    'Marker','.', 'MarkerSize',5, 'Color','g')
hold on
wgPlot(A, xy)
axis([-1 1 -1 1]); axis equal off
hold off

%# show node labels
h = text(xy(:,1).*1.05, xy(:,2).*1.05, txt, 'FontSize',10);
set(h, {'Rotation'},num2cell(theta*180/pi))

end

