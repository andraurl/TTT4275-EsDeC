x1all = load('class_1','-ascii'); % setosa
x2all = load('class_2','-ascii'); % versicolor
x3all = load('class_3','-ascii'); % virginica

C = 3; % Number of classes
D = 4; % Number of features

features(:,:,1) = [x1all(:,1), x2all(:,1), x3all(:,1)];
features(:,:,2) = [x1all(:,2), x2all(:,2), x3all(:,2)];
features(:,:,3) = [x1all(:,3), x2all(:,3), x3all(:,3)];
features(:,:,4) = [x1all(:,4), x2all(:,4), x3all(:,4)];

classes = {'Iris Setosa', 'Iris versicolor', 'Iris Virginica'};

for feature = 1:4
    figure(feature);
    sgtitle(sprintf('feature %i', feature));
    X = min(min(features(:,:, feature))):0.2:max(max(features(:,:, feature)));
    for class = 1:3
        subplot(3,1,class);
        hist(features(:,class, feature),X);
        title(classes{class});
    end
end

