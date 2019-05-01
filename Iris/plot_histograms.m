x1all = load('class_1','-ascii'); % setosa
x2all = load('class_2','-ascii'); % versicolor
x3all = load('class_3','-ascii'); % virginica

features(:,:,1) = [x1all(:,1), x2all(:,1), x3all(:,1)];
features(:,:,2) = [x1all(:,2), x2all(:,2), x3all(:,2)];
features(:,:,3) = [x1all(:,3), x2all(:,3), x3all(:,3)];
features(:,:,4) = [x1all(:,4), x2all(:,4), x3all(:,4)];
%{
classes = {'Iris Setosa', 'Iris versicolor', 'Iris Virginica'};
feature_names = {'Sepal length', 'Sepal width', 'Petal length', 'Petal width'};
for feature = 1:4
    figure(feature);
    sgtitle(feature_names{feature});
    X = min(min(features(:,:, feature))): (max(max(features(:,:, feature))) - min(min(features(:,:, feature))))/20 :max(max(features(:,:, feature)));
    for class = 1:3
        subplot(3,1,class);
        hist(features(:,class, feature),X);
        title(classes{class});
    end
end
%}

figure(5);
class_colors = {'r', 'g', 'b'};
for class = 1:3
    %a = [features(:,class,3), features(:,class,4)]
    %plot3(features(:,class,1)', features(:,class,3)', features(:,class,4)', ['*', class_colors{class}]); hold on;
    plot(features(:,class,3)', features(:,class,4)', ['*', class_colors{class}]); hold on;
end
legend('Iris Setosa', 'Iris Versicolor', 'Iris Virginica');
title('Feature overlap');
%xlabel('feature 1');
%ylabel('feature 3');
%zlabel('feature 4');

xlabel('Petal length');
ylabel('Petal width');
