load('data_all.mat');
load('clusters.mat');

M = 64;

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
    [template_distances, template_index] = mink(distances,k);
    nearest_nums = references_num(template_index);
    [~,~,most_frequent] = mode(nearest_nums);
    most_frequent = most_frequent{1}';
    
    if length(most_frequent) == 1 % Hvis en klasse dominerer i de K referansene
        guessed_num = most_frequent;
    else % Hvis flere klasser har likt antall referanser:
        % Fjern alle de andre klassene fra referansesettet:
        for i = k:-1:1
            if ~ismember(nearest_nums(i), most_frequent)
                nearest_nums(i) = [];
                template_distances(i) = [];
            end
        end
        % Og velg deretter den nærmeste referansen:
        [~, I] = min(template_distances);
        guessed_num = nearest_nums(I);
    end
    
    testset_num_estimated(t) = guessed_num;
 
    % updating precition REMOVE IN HANDIN
    if testset_num(t) == guessed_num
        correctly_guessed = correctly_guessed + 1;
    end
    fprintf('Prosent riktig: %f\n', correctly_guessed / t * 100)
end

% 71,23% riktig


