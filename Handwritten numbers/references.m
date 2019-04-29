%% Ploting of misclassified numbers
load('workspace_task_1a')
close all;
figure()
%  title('correctly classified numbers')
title('misclassified numbers')
for plotId = 1:25
   subplot(5, 5, plotId);
   x = zeros(28,28);
   x(:) = Ci(plotId,:);
   image(x');
end