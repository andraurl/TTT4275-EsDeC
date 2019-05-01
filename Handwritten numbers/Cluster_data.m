load('data_all.mat');

M = 64;
trainset = trainv;
trainset_num = trainlab;

references = [];
references_num = [];
for class = 0:9
    [idxi, Ci] = kmeans(trainset(trainset_num == class, :), M);

    references = [references; Ci];
    references_num = [references_num; repmat(class, M, 1)];
    size(references)
end

save('640_clusters.mat', 'references', 'references_num');