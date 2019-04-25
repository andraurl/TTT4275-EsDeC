%% confution matrix

% filling confution matrix
x = testset_num(t) + 1;
y = guessed_num + 1;
confution_matrix_count(x, y) = confution_matrix_count(x, y) + 1;

% calculating acuracy in prosent    
confution_matrix_prosent = zeros(10, 10);
for y = 1:10
    total = sum(confution_matrix_count(y,:));
    confution_matrix_prosent(y,:) = confution_matrix_count(y,:)./(total)*100;
end

% ruonding results
confution_matrix_rounded = round(confution_matrix_prosent);

