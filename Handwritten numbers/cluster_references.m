references = Ci;
for i = 1:M
    references_num(i) = mode(trainlab(idxi==i));
end
figure()
for plotId = 1:64
    subplot(8,8,plotId);
    x = zeros(28,28);
    x(:) = Ci(plotId,:);
    image(x');
    set(gca,'xtick',[])
    set(gca,'ytick',[])
end