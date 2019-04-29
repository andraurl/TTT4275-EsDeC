%% Confution matrix and error rate

N = 3; % number of classes

% innput
% 
solution = testset_class;
estimated = testset_class_estimated;
% solution = trainset_class;
% estimated = trainset_class_estimated;

confution_matrix_count = zeros(N,N);

test_length = length(solution);
for t = 1:test_length
    % filling confution matrix
    x = solution(t);
    y = estimated(t);
    confution_matrix_count(x, y) = confution_matrix_count(x, y) + 1;
end

% calculating acuracy in prosent
confution_matrix_prosent = zeros(N, N);
for y = 1:N
    total = sum(confution_matrix_count(y,:));
    confution_matrix_prosent(y,:) = confution_matrix_count(y,:)./(total)*100;
end
confution_matrix_rounded = round(confution_matrix_prosent)

%% Error rate
D = diag(confution_matrix_rounded);
D = diag(D);
A = confution_matrix_rounded - D;
sum_errors = sum(sum(A));
sum_classifications = sum(sum(confution_matrix_rounded));
error_rate = round(sum_errors / sum_classifications * 100, 1)
