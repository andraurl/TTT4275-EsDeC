load('data_all.mat');
load('640_clusters.mat');

k = 1;
    
testset = testv;
testset_num = testlab;
testset_num_classified = zeros(size(testset_num));

for t = 1:10000
    nearest_num = 0;
    
    distances = (testset(t,:) - references).^2;
    distances = sum(distances, 2);

    [k_distances, k_indexes] = mink(distances, k);
    k_nearest_nums = references_num(k_indexes);
    [~,~,most_frequent] = mode(k_nearest_nums);
    most_frequent = most_frequent{1}';
    
    if length(most_frequent) == 1 % Hvis en klasse dominerer i de K referansene
        guessed_num = most_frequent;
    else % Hvis flere klasser har likt antall referanser:
        % Fjern alle de andre klassene fra referansesettet:
        for i = k:-1:1
            if ~ismember(k_nearest_nums(i), most_frequent)
                k_nearest_nums(i) = [];
                k_distances(i) = [];
            end
        end
        % Og velg deretter den nærmeste referansen:
        [~, I] = min(k_distances);
        guessed_num = k_nearest_nums(I);
    end
    testset_num_classified(t) = guessed_num;
end

avviksrate = 100 - 100*(sum(testset_num == testset_num_classified))/10000;
fprintf('\n\nAvviksrate med K=%i: %.2f %%\n', k, avviksrate);
% 71,23% riktig


fprintf('  '); for i = 0:9; fprintf('& %4i', i); end;
for rett_tall = 0:9
    fprintf(' \\\\\n%i ', rett_tall)
    for klassifisert_tall = 0:9
        fprintf('& %4i', sum(testset_num_classified(testset_num'==rett_tall) == klassifisert_tall)); % /sum(testset_num==klassifisert_tall))
    end
end
fprintf('\n\n');


%save('testset_classified.mat', 'testset_num', 'testset_num_classified');
