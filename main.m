%% 批处理
clear
INDEX = {
    };

T = INDEX';
for U = T
    clearvars -except INDEX T U
    DATE = U{1};
    EXPERIMENT = U{2};
    CHANNEL = U{3};
    %% 批处理命令
%     load(sprintf('result/%s/%s/data.mat', DATE, EXPERIMENT));

    
end
%%
clear
DATE = '';
EXPERIMENT = '';
CHANNEL = ;

%% 获取原始图像和ROI信息
[roiimage, imgs, frame] = getrawimage(DATE, EXPERIMENT);
[roiMatrix, roiCo] = getroi(roiimage, DATE, EXPERIMENT);
%% 获取每帧的frap数据（ROI内之和）
rawfrapinf = getrawfrap(imgs, roiMatrix, CHANNEL, DATE, EXPERIMENT);
%% 归一化frap信息
normalizedfrapinf = normalizefrap(rawfrapinf, DATE, EXPERIMENT);
%% 所有ROI的frap变化
% normalizedfrapinf
INPUT_FRAP_INF = normalizedfrapinf;
drawmap(imgs, INPUT_FRAP_INF, CHANNEL, roiCo, DATE, EXPERIMENT,...
    'normalizedmap');
%% 每个ROI的变化
% normalizedfrapinf
INPUT_FRAP_INF = normalizedfrapinf;
drawindividual(imgs, INPUT_FRAP_INF, CHANNEL, roiCo, DATE, EXPERIMENT);

%% 将ROI图像拼接到一副图中，列表内为需要拼接的ROI
DISPLAY_LIST = [1;2;3;4;5;6;7;8;9];
videogrid(imgs, roiCo, DISPLAY_LIST, CHANNEL, 'grid', DATE, EXPERIMENT);
%% 将ROI和对应的FRAP信息输出到一组4维tif图像中
INPUT_FRAP_INF = normalizedfrapinf;
DISPLAY_LIST = 'all';
drawh(imgs, roiCo, INPUT_FRAP_INF, DISPLAY_LIST, DATE, EXPERIMENT, CHANNEL);
%%
DISPLAY_LIST = [1,2,3,4,5,6,7,8];
FILENAME = 'hgrid1';
h2grid(individualh,FILENAME,DISPLAY_LIST,DATE,EXPERIMENT,CHANNEL);
%%
% %% 添加新的ROI
% add = [1,1,248,200];
% [roiMatrix, roiCo] = addroi(roiMatrix, roiCo, DATE, EXPERIMENT, add);
% %%
% cuttedimgs = cutimg(imgs, diroiMatrix, roiCo, 10, CHANNEL, DATE,...
%     EXPERIMENT);
% diroiMatrix = dilateroi(roiMatrix, 10, DATE, EXPERIMENT);
