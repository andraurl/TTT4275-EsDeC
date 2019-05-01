load('data_all.mat');
load('640_clusters.mat');
M = 64;


testset = testv;
testset_num = uint8(testlab);
testset_num_estimated = zeros(size(testset_num));

correctly_guessed = 0;
confution_matrix_count = zeros(10,10);

k = 1;

for t = 1:10000
    nearest_num = 0;
    
    distances = (testset(t,:) - references).^2;
    distances = sum(distances')';

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
end
avviksrate = 100-100 * correctly_guessed / 10000;
fprintf('\n\nAvviksrate med K=%i: %.2f %%\n', k, avviksrate);
% 71,23% riktig


fprintf('  '); for i = 0:9; fprintf('& %4i', i); end;
for rett_tall = 0:9
    testset_num_estimated;
    testset_num;
    fprintf(' \\\\\n%i ', rett_tall)
    for klassifisert_tall = 0:9
        fprintf('& %4i', sum(testset_num_estimated(testset_num'==rett_tall) == klassifisert_tall)); % /sum(testset_num==klassifisert_tall))
    end
end
fprintf('\n\n');
