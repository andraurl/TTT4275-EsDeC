%% Confution matrix and error rate

% load('workspace_task_xx.mat');

N = 10; % number of classes

confution_matrix_count = zeros(N,N);

% filling confution matrix
for t = 1:length(testset_num)
    x = testset_num(t) + 1;
    y = testset_num_estimated(t) + 1;
    confution_matrix_count(x, y) = confution_matrix_count(x, y) + 1;
end

confution_matrix_count

% confution matrix in prosent
confution_matrix_prosent = zeros(N, N);
for y = 1:N
    total = sum(confution_matrix_count(y,:));
    confution_matrix_prosent(y,:) = confution_matrix_count(y,:)./(total)*100;
end

% rounding results
confution_matrix_rounded = round(confution_matrix_prosent);

%% Error rate
D = diag(confution_matrix_count);
D = diag(D);
A = confution_matrix_count - D;
sum_errors = sum(sum(A));
sum_classifications = sum(sum(confution_matrix_count));
error_rate = round(sum_errors / sum_classifications * 100, 1)

Matrise_7 = confution_matrix_count;
