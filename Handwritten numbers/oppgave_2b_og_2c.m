load('data_all.mat');
load('clusters.mat');

M = 64;
delete = [3 16 17 22 31 34 46 51 57 60];
delete = [20];
delete = [];
M = M - length(delete);

references = Ci;
%% remove unwanted references
references(delete, : ) = [];
 
for i = 1:M + length(delete)
    references_num(i) = mode(trainlab(idxi==i));
end 

references_num(delete) = [];
references_num(M+1+1:end) = [];

testset = testv;
testset_num = uint8(testlab);
testset_num_estimated = zeros(size(testset_num));

correctly_guessed = 0;
confution_matrix_count = zeros(10,10);

for t = 1:10000
    nearest_num = 0;
    
    distances = (testset(t,:) - references).^2;
    distances = sum(distances')';

    k = 1;
    % k = 7;
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
end

