function [normalizedfrapinf] = normalizefrap(rawfrapinf,date,experiment)
% Normalize FRAP statistic results.

% Sometimes the lowest value is not at the frame after bleaching, how to
% notmalize data at this case?
normalizedfrapinf = normalize(rawfrapinf,'range');
save(sprintf('result/%s/%s/data.mat',date,experiment),...
    'normalizedfrapinf','-append','-nocompression');
fprintf('FRAP information normalized.\n')
end