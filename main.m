%% batch
clear
INDEX = {
    };

T = INDEX';
for U = T
    clearvars -except INDEX T U
    DATE = U{1};
    EXPERIMENT = U{2};
    CHANNEL = U{3};
    %% batch command
%     load(sprintf('result/%s/%s/data.mat', DATE, EXPERIMENT));

    
end
%%
clear
DATE = '';
EXPERIMENT = '';
CHANNEL = ;

%% Read original image and ROI file.
[imgs,roiimage] = getrawimage(DATE,EXPERIMENT);
[roiStack,roiCo] = getroi(roiimage,DATE,EXPERIMENT);
%% Statistic each fraps pixel data in ROI in sum.
rawfrapinf = getrawfrap(imgs, roiStack, CHANNEL, DATE, EXPERIMENT);
%% Normalize statistic results.
normalizedfrapinf = normalizefrap(rawfrapinf, DATE, EXPERIMENT);
%% Show all ROI and FRAP changes in one big map.
INPUT_FRAP_INF = normalizedfrapinf;

drawmap(imgs, INPUT_FRAP_INF, CHANNEL, roiCo, DATE, EXPERIMENT,...
    'normalizedmap');
%% Show FRAP changes in each ROI in individual figure.
INPUT_FRAP_INF = normalizedfrapinf;

drawindividual(imgs, INPUT_FRAP_INF, CHANNEL, roiCo, DATE, EXPERIMENT);
%% Splicing each ROI changing videos into one video, up to 16.
% DISPLAY_LIST = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16];
DISPLAY_LIST = [1;2;3;4;5;6;7;8;9];

videogrid(imgs, roiCo, DISPLAY_LIST, CHANNEL, 'grid', DATE, EXPERIMENT);
%% Show ROI changing video and FRAP statistic result in one video.
INPUT_FRAP_INF = normalizedfrapinf;
DISPLAY_LIST = 'all';

drawh(imgs, roiCo, INPUT_FRAP_INF, DISPLAY_LIST, DATE, EXPERIMENT, CHANNEL);
%% Splicing each ROI changing videos and FRAP statistic results in one video, up to 8.
DISPLAY_LIST = [1,2,3,4,5,6,7,8];
FILENAME = 'hgrid1';

h2grid(individualh,FILENAME,DISPLAY_LIST,DATE,EXPERIMENT,CHANNEL);