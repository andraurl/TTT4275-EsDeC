x1all = load('class_1','-ascii'); % setosa
x2all = load('class_2','-ascii'); % versicolor
x3all = load('class_3','-ascii'); % virginica

x1all = x1all(:,[3 4]);
x2all = x2all(:,[3 4]);
x3all = x3all(:,[3 4]);



N_train = 30;
C = 3; % Number of classes
D = 2; % Number of features

x1train = x1all(1:N_train, :);
x2train = x2all(1:N_train, :);
x3train = x3all(1:N_train, :);

x1test = x1all(N_train+1:50, :);
x2test = x2all(N_train+1:50, :);
x3test = x3all(N_train+1:50, :);

x_all_train = [x1train; x2train; x3train]';
t_all_train = [repmat([1 0 0],N_train,1); repmat([0 1 0],N_train,1); repmat([0 0 1],N_train,1)]';

x_all_test = [x1test; x2test; x3test]';
t_all_test = [repmat([1 0 0],(50-N_train),1); repmat([0 1 0],(50-N_train),1); repmat([0 0 1],(50-N_train),1)]';

% g_i(x) = w_i'*x + w_i0,   i = {1, ...C}
% g = Wx + w_0
% g and w_0 are vectors of dimention C(numer of classes=3), and W is a CxD matrix
% C: number of classes (3)
% D: Number of features (4)

W   = zeros(C, D); % 3x4 matrise
w_0 = zeros(C, 1); %3x1 vektor

W = [W, w_0];
x_vec = [x_all_train', ones(C*N_train,1)]';

z = W * x_vec;
g = 1./(1+exp(-z)); % Squashing function
t = t_all_train;

% g(i,k)

%MSE = 0;
%for k=1 % C*N_train % k = 1:90
%    MSE = MSE + 1/2 * (g(:,k)-t(:,k))'*(g(:,k)-t(:,k));
%end
%MSE;


% Training:
alpha = 0.005;
NumIterations = 10000;
for iteration = 1:NumIterations    
    z = W * x_vec;
    g = 1./(1+exp(-z)); % Squashing function
    
    grad_W_MSE = 0;
    for k=1:C*N_train % Equation 3.22 in the merged compendium
        grad_W_MSE = grad_W_MSE + ...
             ( (g(:,k)-t(:,k)) .* g(:,k) .* (1-g(:,k)) )...
            * x_vec(:,k)';
    end
    
    W = W - alpha * grad_W_MSE;
    
    % Test how fast MSE converges:
    %if (mod(iteration,100)==0 && 0)
    %    MSE = 0;
    %    for k=1:C*N_train % k = 1:90
    %        MSE = MSE + 1/2 * (g(:,k)-t(:,k))'*(g(:,k)-t(:,k));
    %    end
    %    MSE
    %end
end


z = W * x_vec;
g = 1./(1+exp(-z)); % Squashing function

fprintf('Training with %i iterations, alpha = %f\n', NumIterations, alpha);
fprintf('After the classifier training, %i of the %i flowers in the training set are classified correctly.\n', ...
    C*N_train-sum(sum(((g==(max(g))) - t) ==1)),...
    C*N_train ...
);

% Tester på testsettet:
x_vec = [x_all_test', ones((C*(50-N_train)),1)]';
z = W * x_vec;
g = 1./(1+exp(-z)); % Squashing function

fprintf('After the classifier training, %i of the %i flowers in the test set are classified correctly.\n\n', ...
    C*(50-N_train)-sum(sum(((g==(max(g))) - t_all_test) ==1)),...
    C*(50-N_train) ...
);







fprintf('\nConfusion matrix for the training set (Actual class vertically, chosen class horisontally):\n');
fprintf('\t\t\t&Setosa\t&Versicolor\t&Virginica\\\\  \\hline\n');

x_vec = [x1train, ones(N_train,1)]';
z = W * x_vec; g = 1./(1+exp(-z)); % Squashing function
chosen_class = g==max(g);
fprintf('Setosa  \t&%i\t\t&%i\t\t\t& %i\\\\\n', sum(chosen_class(1,:)), sum(chosen_class(2,:)), sum(chosen_class(3,:)))

x_vec = [x2train, ones(N_train,1)]';
z = W * x_vec; g = 1./(1+exp(-z)); % Squashing function
chosen_class = g==max(g);
fprintf('Versicolor\t&%i\t\t&%i\t\t\t& %i\\\\\n', sum(chosen_class(1,:)), sum(chosen_class(2,:)), sum(chosen_class(3,:)))

x_vec = [x3train, ones(N_train,1)]';
z = W * x_vec; g = 1./(1+exp(-z)); % Squashing function
chosen_class = g==max(g);
fprintf('Virginica \t&%i\t\t&%i\t\t\t& %i\n', sum(chosen_class(1,:)), sum(chosen_class(2,:)), sum(chosen_class(3,:)))








fprintf('\nConfusion matrix for the testset (Actual class vertically, chosen class horisontally):\n');
fprintf('\t\t\t&Setosa\t&Versicolor\t&Virginica\\\\  \\hline\n');

x_vec = [x1test, ones(50-N_train,1)]';
z = W * x_vec; g = 1./(1+exp(-z)); % Squashing function
chosen_class = g==max(g);
fprintf('Setosa  \t&%i\t\t&%i\t\t\t& %i\\\\\n', sum(chosen_class(1,:)), sum(chosen_class(2,:)), sum(chosen_class(3,:)))

x_vec = [x2test, ones(50-N_train,1)]';
z = W * x_vec; g = 1./(1+exp(-z)); % Squashing function
chosen_class = g==max(g);
fprintf('Versicolor\t&%i\t\t&%i\t\t\t& %i\\\\\n', sum(chosen_class(1,:)), sum(chosen_class(2,:)), sum(chosen_class(3,:)))

x_vec = [x3test, ones(50-N_train,1)]';
z = W * x_vec; g = 1./(1+exp(-z)); % Squashing function
chosen_class = g==max(g);
fprintf('Virginica \t&%i\t\t&%i\t\t\t& %i\n', sum(chosen_class(1,:)), sum(chosen_class(2,:)), sum(chosen_class(3,:)))
