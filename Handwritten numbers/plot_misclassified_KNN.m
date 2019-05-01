% Plots the errors that occur in K=7, but not in K=1.
% Press enter in the command window while running to proceed


for error_num = 1:256;    
    load('classified_with_knn');
    load('640_clusters');
    load('data_all', 'testv', 'testlab')
    
    testset = testv; clear testv;
    testset_num = testlab; clear testlab;
    
    wrong_with_k_1 = testset_num_estimated_k_1 - testset_num ~=0;
    wrong_with_k_7 = testset_num_estimated_k_7 - testset_num ~=0;
    
    wrong_only_with_k_7 = 1==(wrong_with_k_7 .* (1-wrong_with_k_1));
    wrong_only_with_k_7_idx = 1:10000;
    wrong_only_with_k_7_idx = wrong_only_with_k_7_idx(wrong_only_with_k_7);
    t = wrong_only_with_k_7_idx(error_num);
    
    
    distances = (testset(t,:) - references).^2;
    distances = sum(distances')';
    
    [template_distances, template_index] = mink(distances,7);
    nearest_nums = references_num(template_index);
    [~,~,most_frequent] = mode(nearest_nums);
    most_frequent = most_frequent{1}';
    
    if length(most_frequent) == 1 % Hvis en klasse dominerer i de K referansene
        guessed_num = most_frequent;
    else % Hvis flere klasser har likt antall referanser:
        % Fjern alle de andre klassene fra referansesettet:
        for i = 7:-1:1
            if ~ismember(nearest_nums(i), most_frequent)
                nearest_nums(i) = [];
                template_distances(i) = [];
            end
        end
        % Og velg deretter den nærmeste referansen:
        [~, I] = min(template_distances);
        guessed_num = nearest_nums(I);
    end
    
    figure(1);
    subplot(2, 4, 1);
    x = zeros(28,28);
    x(:) = testset(t,:);
    image(x');
    title(sprintf('Classified as %i\n instead of %i', guessed_num, testset_num(t)));
    
    for plotId = 2:8
        subplot(2, 4, plotId);
        x = zeros(28,28);
        x(:) = references(  template_index(plotId-1)  ,:);
        image(x');
        title(sprintf('Reference of %i', references_num(  template_index(plotId-1))));
    end
    input('');
end