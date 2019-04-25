function drawmap(imgs, input, channel, roiCo, date, experiment, name)
% Show all FRAP changes in one figure and mark ROIs on the photo.

fig = figure('Name', sprintf('%s-%s-%s', date, experiment, name));
fig.Visible = 'off';
subplot(1, 2, 1);
imshow(imgs(:, :, 1, channel),[]);
axis on;
%colormap(gray(4096));
hold on;
for n = 1:size(roiCo,1)
    rectangle("Position", roiCo(n,1:4), "Edgecolor", "r");
    text(roiCo(n,1)+roiCo(n,3)+1, roiCo(n,2), string(n), "Color", "red");
end
subplot(1, 2, 2);
plot(input);
legend1 = legend(string(roiCo(:,7)));
set(legend1,...
    'Position',[0.907779875494835 0.660119047619048 0.114285714285714 0.26547619047619]);
saveas(fig, sprintf('result/%s/%s/%s.fig', date, experiment, name));
close
disp('Map saved.');
end