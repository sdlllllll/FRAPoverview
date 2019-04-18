function [normalizedfrapinf] = normalizefrap(rawfrapinf, date, experiment)
%%
normalizedfrapinf = normalize(rawfrapinf, 'range');
save(sprintf('result/%s/%s/data.mat', date, experiment),...
    'normalizedfrapinf', '-append', '-nocompression');
disp('FRAP information normalized.')
end