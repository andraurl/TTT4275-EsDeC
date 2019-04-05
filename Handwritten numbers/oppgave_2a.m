load('data_all.mat');

M = 64;
[idxi, Ci] = kmeans(trainv,M)

references = Ci;
for i = 1:M
    references_num(i) = mode(trainlab(idxi==i));
end 

testset = testv;
testset_num = testlab;
testset_num_estimated = zeros(size(testset_num));


for t = 1:10000
    nearest_num = 0;
    
    distances = (testset(t,:) - references( indecies, : ) ).^2;
    distances = sum(distances')';
    [min_distance_in_chunk, I] = min(distances);
    nearest_num = references_num(I(1));
    
    fprintf('Fasit: %i, Gjettet: %i. Indeksen var %i. Riktig: %i\n', testset_num(t), nearest_num, t,testset_num(t) == nearest_num);
end
