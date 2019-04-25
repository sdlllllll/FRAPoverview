function [normalizedfrapinf] = normalizefrap(rawfrapinf,date,experiment)
% Normalize FRAP statistic results.

normalizedfrapinf = normalize(rawfrapinf,'range');
save(sprintf('result/%s/%s/data.mat',date,experiment),...
    'normalizedfrapinf','-append','-nocompression');
fprintf('FRAP information normalized.\n')
end