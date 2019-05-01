%% Ploting of misclassified/classified numbers
load('workspace_task_1a')

count = 0;
indicies = zeros(1,9);
for t = 1:10000
    if testset_num(t) == testset_num_estimated(t)
    % if testset_num(t) ~= testset_num_estimated(t)
       count = count + 1;
       indicies(count) = t;
    end
    if count >= 9
        break
    end
end

close all;
 figure()
 title('correctly classified numbers')
 % title('misclassified numbers')
 for plotId = 1 : 9
    subplot(3, 3, plotId);
    x = zeros(28,28);
    x(:) = testv(indicies(plotId),:);
    image(x')
    actual_value = round(testset_num(indicies(plotId)));
    classified_value = round(testset_num_estimated(indicies(plotId)));
    title(sprintf('Faktisk verdi: %d \nKlasifisert verdi: %d',...
        actual_value, classified_value))
    set(gca,'xtick',[])
    set(gca,'ytick',[])
 end
  

