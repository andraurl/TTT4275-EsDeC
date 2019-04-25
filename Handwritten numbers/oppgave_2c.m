load('data_all.mat');
load('clusters.mat');


M = 64;
% [idxi, Ci] = kmeans(trainv,M);

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
    
    k = 7;
    [~, template_index] = mink(distances,k);
    
    nearest_nums = references_num(template_index);
    guessed_num = mode(nearest_nums);
    
    % filling confution matrix
    x = testset_num(t) + 1;
    y = guessed_num + 1;
    confution_matrix_count(x, y) = confution_matrix_count(x, y) + 1;
    
    % updating precition
    if testset_num(t) == guessed_num
        correctly_guessed = correctly_guessed + 1;
        fprintf('Prosent riktig: %f\n', correctly_guessed / t * 100)
    end
%     fprintf('Fasit: %i, Gjettet: %i. Indeksen var %i. Riktig: %i\n', testset_num(t), guessed_num, t,testset_num(t) == guessed_num);
end

confution_matrix_prosent = zeros(10, 10);
for y = 1:10
    total = sum(confution_matrix_count(y,:));
    confution_matrix_prosent(y,:) = confution_matrix_count(y,:)./(total)*100;
end

confution_matrix_rounded = round(confution_matrix_prosent);

