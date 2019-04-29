

fprintf('\t\t\tSetosa\tVersicolor\tVirginica\n');

x_vec = [x1test, ones(50-N_train,1)]';
z = W * x_vec; g = 1./(1+exp(-z)); % Squashing function
classifier_guess = g==max(g);
fprintf('Setosa  \t%i\t\t%i\t\t\t %i\n', sum(classifier_guess(1,:)), sum(classifier_guess(2,:)), sum(classifier_guess(3,:)))

x_vec = [x2test, ones(50-N_train,1)]';
z = W * x_vec; g = 1./(1+exp(-z)); % Squashing function
classifier_guess = g==max(g);
fprintf('Versicolor\t%i\t\t%i\t\t\t %i\n', sum(classifier_guess(1,:)), sum(classifier_guess(2,:)), sum(classifier_guess(3,:)))

x_vec = [x3test, ones(50-N_train,1)]';
z = W * x_vec; g = 1./(1+exp(-z)); % Squashing function
classifier_guess = g==max(g);
fprintf('Virginica \t%i\t\t%i\t\t\t %i\n', sum(classifier_guess(1,:)), sum(classifier_guess(2,:)), sum(classifier_guess(3,:)))

