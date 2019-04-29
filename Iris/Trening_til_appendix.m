x1all = load('class_1','-ascii'); % Setosa
x2all = load('class_2','-ascii'); % Versicolor
x3all = load('class_3','-ascii'); % Virginica

N_train = 30;
C = 3; % Number of classes
D = 4; % Number of features

x1train = x1all(1:N_train, :);
x2train = x2all(1:N_train, :);
x3train = x3all(1:N_train, :);

x1test = x1all(N_train+1:50, :);
x2test = x2all(N_train+1:50, :);
x3test = x3all(N_train+1:50, :);

% Ale blomster som skal brukes til trening og testing
x_train = [x1train; x2train; x3train]';
x_test = [x1test; x2test; x3test]';

% Fasit for klassetilhørigheten til blomstene:
t_train = [repmat([1 0 0], N_train,1);      repmat([0 1 0], N_train,1);     repmat([0 0 1], N_train,1)]';
t_test =  [repmat([1 0 0],(50-N_train),1);  repmat([0 1 0],(50-N_train),1); repmat([0 0 1],(50-N_train),1)]';

% Startpunkt for W settes til nullmatrise:
W   = zeros(C, D); % 3x4 matrise
w_0 = zeros(C, 1); %3x1 vektor
W = [W, w_0];

x_vec = [x_train', ones(C*N_train,1)]';

% Trening:
t = t_train;
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
end

z = W * [x_test', ones(C*(50-N_train),1)]';
g = 1./(1+exp(-z)); % Squashing function
classifier_guess = g==max(g);

