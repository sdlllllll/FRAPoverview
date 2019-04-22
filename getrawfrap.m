function [rawfrapinf] = getrawfrap(imgs,roiMatrix,channel,date,experiment)
% Sum pixel brightness in each ROIs every fraps.
%
% [rawfrapinf] = getrawfrap(imgs,roiMatrix,channel,date,experiment)

t = size(imgs,3);
n = size(roiMatrix,3);
rawfrapinf = zeros(t,n);
for u = 1:t
    for m = 1:n
        r = imgs(:,:,u,channel).*roiMatrix(:,:,m);
        rawfrapinf(u,m) = sum(sum(r));
    end
end
save(sprintf('result/%s/%s/data.mat',date,experiment),'rawfrapinf',...
    '-append','-nocompression');
fprintf('Statistic FRAP finished./n');
end
