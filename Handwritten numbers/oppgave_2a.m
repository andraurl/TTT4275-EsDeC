load('data_all.mat');
load('clusters.mat');

references = trainv;
M = 64;

% [idxi, Ci] = kmeans(trainv,M);

for i = 1:M
   reference(i) = Ci(i);
end

references_num = trainlab;

testset = testv;
testset_num = testlab;
testset_num_estimated = zeros(size(testlab));

for t = 1:10000
    nearest_num = -1;
    nearest_distance = inf;
    chunk_size = 50;
    for r = 1:(60000/chunk_size)
        indecies = 1+(r-1)*chunk_size : r*chunk_size;
        distances = (testset(t,:) - references( indecies, : ) ).^2;
        distances = sum(distances')';
        [min_distance_in_chunk, I] = min(distances);
        if min_distance_in_chunk < nearest_distance
            nearest_num = references_num(indecies(I(1)));
            nearest_distance = min_distance_in_chunk;
        end
    end
    
    testset_num_estimated(t) = nearest_num;
    fprintf('Fasit: %i, Gjettet: %i. Indeksen var %i. Riktig: %i\n', testset_num(t), nearest_num, t,testset_num(t) == nearest_num);
end


% misklassifiserte indekser: 
%{
Fasit: 4, Gjettet: 9. Indeksen var 116. Riktig: 0 
Fasit: 3, Gjettet: 5. Indeksen var 196. Riktig: 0
Fasit: 9, Gjettet: 8. Indeksen var 242. Riktig: 0
Fasit: 8, Gjettet: 5. Indeksen var 269. Riktig: 0
Fasit: 4, Gjettet: 1. Indeksen var 301. Riktig: 0
Fasit: 9, Gjettet: 7. Indeksen var 321. Riktig: 0
Fasit: 2, Gjettet: 7. Indeksen var 322. Riktig: 0
%}
