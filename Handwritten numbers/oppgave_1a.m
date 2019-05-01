load('data_all.mat');

references = trainv;
references_num = trainlab;

testset = testv;
testset_num = testlab;
testset_num_estimated = zeros(size(testlab));

for t = 1:10000
    nearest_num = 0;
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
end
