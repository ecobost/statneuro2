function  H  = neuron_pair_hist2D( N1,N2, rates_all )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

H = histogram2D(rates_all(:,N1),rates_all(:,N2));
H = H./sum(H(:));
title_str = ['2D histogram of Neuron ',num2str(N1),' and Neuron ',num2str(N2)];

h = bar3(H);
xlabel(['Neuron ',num2str(N1)])
ylabel(['Neuron ',num2str(N2)])
title(title_str)

for k=1:length(h)
    zdata = get(h(k),'ZData');
    set(h(k),'CData',zdata,'FaceColor','interp')
end
end

