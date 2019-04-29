load('trained_classifier')
% load('alt_trained_classifier')

x1all = load('class_1','-ascii'); % setosa
x2all = load('class_2','-ascii'); % versicolor
x3all = load('class_3','-ascii'); % virginica

% x1all = flipud(x1all);
% x2all = flipud(x2all);
% x3all = flipud(x3all);

%% Classification of training set

N_train = 30;
N_test = 20;
C = 3; % Number of classes

x1train = x1all(1:N_train, :);
x2train = x2all(1:N_train, :);
x3train = x3all(1:N_train, :);

x_all_train = [x1train; x2train; x3train]';
t_all_train = [repmat([1 0 0],N_train,1); repmat([0 1 0],N_train,1); repmat([0 0 1],N_train,1)]';

x_vec = [x_all_train', ones(C*N_train,1)]';

z = W * x_vec;
g = 1./(1+exp(-z));


trainset_class = zeros(1,90);
trainset_class_estimated = zeros(1,90);

for t = 1:90
    for c = 1:3
        if t_all_train(c,t) == max(t_all_train(:,t))
           trainset_class(t) = c; 
        end
        if g(c,t) == max(g(:,t))
           trainset_class_estimated(t) = c;
        end
    end
end

%% Classification of testing set

x1test = x1all(N_train+1:50, :);
x2test = x2all(N_train+1:50, :);
x3test = x3all(N_train+1:50, :);


x_all_test = [x1test; x2test; x3test]';
t_all_test = [repmat([1 0 0],(50-N_train),1); repmat([0 1 0],(50-N_train),1); repmat([0 0 1],(50-N_train),1)]';

x_vec_ = [x_all_test', ones(C*N_test,1)]';

z = W * x_vec_;
g = 1./(1+exp(-z));


testset_class = zeros(1,60);
testset_class_estimated = zeros(1,60);

for t = 1:60
    for c = 1:3
        if t_all_test(c,t) == max(t_all_test(:,t))
           testset_class(t) = c; 
        end
        if g(c,t) == max(g(:,t))
           testset_class_estimated(t) = c;
        end
    end
end