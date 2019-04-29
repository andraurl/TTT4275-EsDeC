x1all = load('class_1','-ascii'); % setosa
x2all = load('class_2','-ascii'); % versicolor
x3all = load('class_3','-ascii'); % virginica

%% Selecting last 30 samples as trainingset
x1all = flipud(x1all);
x2all = flipud(x2all);
x3all = flipud(x3all);
%%%%%%%%%%%%%%%%%%%%%%

N_train = 30;
C = 3; % Number of classes
D = 4; % Number of features

x1train = x1all(1:N_train, :);
x2train = x2all(1:N_train, :);
x3train = x3all(1:N_train, :);

x_all_train = [x1train; x2train; x3train]';
t_all_train = [repmat([1 0 0],N_train,1); repmat([0 1 0],N_train,1); repmat([0 0 1],N_train,1)]';

% g_i(x) = w_i'*x + w_i0,   i = {1, ...C}
% g = Wx + w_0
% g and w_0 are vectors of dimention C(numer of classes=3), and W is a CxD matrix
% C: number of classes (3)
% D: Number of features (4)

W   = zeros(C, D); % 3x4 matrise
w_0 = zeros(C, 1); % 3x1 vektor

W = [W, w_0];
x_vec = [x_all_train', ones(C*N_train,1)]';

z = W * x_vec;
g = 1./(1+exp(-z)); % Squashing function
t = t_all_train;

% g(i,k)

MSE = 0;
for k=1 % C*N_train % k = 1:90
    MSE = MSE + 1/2 * (g(:,k)-t(:,k))'*(g(:,k)-t(:,k));
end
MSE;


alpha = 0.005;
NumIterations = 10000;
for iteration = 1:NumIterations
    
    z = W * x_vec;
    g = 1./(1+exp(-z)); % Squashing function
    
    grad_W_MSE = 0;
    for k=1:C*N_train % k = 1:90
        grad_W_MSE = grad_W_MSE + ...
             ( (g(:,k)-t(:,k)) .* g(:,k) .* (1-g(:,k)) )...
            * x_vec(:,k)';
    end
    
    W = W - alpha * grad_W_MSE;
    %%{
    if (mod(iteration,100)==0 && 0)
        MSE = 0;
        for k=1:C*N_train % k = 1:90
            MSE = MSE + 1/2 * (g(:,k)-t(:,k))'*(g(:,k)-t(:,k));
        end
        MSE
    end
    %{
    %}
end