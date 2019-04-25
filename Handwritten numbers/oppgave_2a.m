load('data_all.mat');

M = 64;
[idxi, Ci] = kmeans(trainv,M);