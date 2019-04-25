function drawindividual(imgs, data, channel, roiCo, date, experiment)
% Show each ROIs FRAP changes in seprate figure.

for r = 1:size(data,2)
    fig = figure('Name', sprintf('%s-%s-roi%d',date, experiment, r));
    fig.Visible = 'off';
%     set(fig, 'Visible', 'off');
    subplot(1, 2, 1);
    imshow(imgs(:, :, 1, channel), []);
    axis on;
    hold on;
    rectangle("Position", roiCo(r,1:4), "Edgecolor", "r");
    text(roiCo(r,1)+roiCo(r,3)+1, roiCo(r,2), string(r), "Color", "red");
    subplot(1, 2, 2);
    plot(data(:,r));
    legend1 = legend(string(r));
    set(legend1,...
        'Position',[0.907779875494835 0.660119047619048...
        0.114285714285714 0.26547619047619]);
    saveas(fig, sprintf('result/%s/%s/roi%d_c%d.fig',...
        date, experiment, r, channel));
    close;
end
disp('Individual figure saved.');
end