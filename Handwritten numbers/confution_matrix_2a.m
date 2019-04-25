%% Confutionmatrix task 2a

load('workspace_task2a.mat');

confution_matrix_count = zeros(10,10);

for t = 1:10000
    % filling confution matrix
    x = testset_num(t) + 1;
    y = testset_num_estimated(t) + 1;
    confution_matrix_count(x, y) = confution_matrix_count(x, y) + 1;
    
end

% calculating acuracy in prosent    
confution_matrix_prosent = zeros(10, 10);
for y = 1:10
    total = sum(confution_matrix_count(y,:));
    confution_matrix_prosent(y,:) = confution_matrix_count(y,:)./(total)*100;
end

% ruonding results
confution_matrix_rounded = round(confution_matrix_prosent);


%% Error rate
D = diag(confution_matrix_rounded);
D = diag(D)
A = confution_matrix_rounded - D;
sum_errors = sum(sum(A));
sum_classifications = sum(sum(confution_matrix_rounded));
error_rate = round(sum_errors / sum_classifications * 100, 1)
