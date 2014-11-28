function [] = display2dHist( Hs, numPair )
% Creates a pretty histogram plot with colored bars depending on their
% height

load combInds;
N1 = num2str(combInds(numPair,1));
N2 = num2str(combInds(numPair,2));
title_str = ['2D histogram of Neuron ',N1,' and Neuron ',N2]

h = bar3(Hs{numPair});
xlabel(['Neuron ',N1])
ylabel(['Neuron ',N2])
title(title_str)

for k=1:length(h)
    zdata = get(h(k),'ZData');
    set(h(k),'CData',zdata,'FaceColor','interp')
end

