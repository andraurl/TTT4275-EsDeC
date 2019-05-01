references = Ci;
fliplr(trainlab)
for i = 1:64
    references_num(i) = mode(trainlab(idxi==i));
end


delete = [3 16 17 22 31 34 46 51 57 60];
M = 64;
M = M - length(delete);

references(delete, : ) = [];

references_num(delete) = [];
references_num(M+1+1:end) = [];

close all;

figure()

hist = zeros(1,10);
for plotId = 1:M
    subplot(8,8,plotId);
    x = zeros(28,28);
    x(:) = Ci(plotId,:);
    image(x');
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    actual_value = round(references_num(plotId));
    hist(actual_value+1) = hist(actual_value+1) + 1;
    title(sprintf('Estimert verdi: %d \n index: %d' , actual_value, plotId))
end

figure()
ref_index = [3 17 22 31 34 46 51 57 58];
for i = 1:4
    subplot(2,2,i);
    x = zeros(28,28);
    x(:) = Ci(ref_index(i),:);
    image(x');
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    actual_value = round(references_num(ref_index(i)));
    % hist(actual_value+1) = hist(actual_value+1) + 1;
    title(sprintf('Estimert verdi: %d', actual_value))
end
    

hist

figure()
histogram('Categories',{'0','1','2','3','4','5','6','7','8','9'},'BinCounts',hist)


   