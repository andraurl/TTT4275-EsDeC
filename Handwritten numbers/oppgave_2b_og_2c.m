load('data_all.mat');
load('clusters.mat');

references = Ci;
for i = 1:M
    references_num(i) = mode(trainlab(idxi==i));
end 

testset = testv;
testset_num = uint8(testlab);
testset_num_estimated = zeros(size(testset_num));

correctly_guessed = 0;
confution_matrix_count = zeros(10,10);

for t = 1:10000
    nearest_num = 0;
    
    distances = (testset(t,:) - references).^2;
    distances = sum(distances')';

    % k = 1;
    k = 7;
    [~, template_index] = mink(distances,k);
    
    nearest_nums = references_num(template_index);
    guessed_num = mode(nearest_nums);
    
    testset_num_estimated(t) = guessed_num;
 
    % updating precition REMOVE IN HANDIN
    if testset_num(t) == guessed_num
        correctly_guessed = correctly_guessed + 1;
        fprintf('Prosent riktig: %f\n', correctly_guessed / t * 100)
    end
end



