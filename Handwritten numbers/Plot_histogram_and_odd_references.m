load('clusters.mat');
load('data_all.mat')
M = 64;
references = Ci;

for i = 1:M
    references_num(i) = mode(trainlab(idxi==i));
end 
close all;

figure(1)
hist(references_num,0:9);
title('Number of references');
xlabel('Digit');
grid on;


%{
%  title('correctly classified numbers')
figure(2)
bad_references = [3, 16, 17, 22, 31, 34, 46, 51];
title('References')
for plotId = 1:8
   subplot(2, 4, plotId);
   x = zeros(28,28);
   x(:) = Ci(bad_references(plotId),:);
   image(x');
   title(sprintf('Referansetall for %i', references_num(bad_references(plotId))));
end
%}

