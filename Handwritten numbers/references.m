%% Ploting of misclassified numbers
load('640_clusters.mat');

figure(1)

class = 9;
title(sprintf('References for %i', class));
for plotId = 1:64
   subplot(8, 8, plotId);
   x = zeros(28,28);
   x(:) = references(plotId+64*class,:);
   image(x');
end

