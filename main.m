%% ������
clear
INDEX = {
    '20190123', 'CHO-VH-B-FRAP001', 1;
    '20190123', 'CHO-VH-B-FRAP002', 1;
    '20190123', 'CHO-VH-B-FRAP003', 1;
    '20190129', 'CHO-PIEZO-VH-H+DOX-DOX-FRAP-001', 1;
    '20190129', 'CHO-PIEZO-VH-H+DOX-DOX-FRAP-003', 1;
    '20190227', 'CHO-Piezo-DiD_001', 1;
    '20190227', 'CHO-Piezo-DiD_002', 1;
    '20190227', 'CHO-Piezo-DiD_003', 1;
    '20190227', 'CHO-Piezo-DiD_004', 1;
    '20190227', 'CHO-Piezo-DiD_005', 1;
    };

T = INDEX';
for U = T
    clearvars -except INDEX T U
    DATE = U{1};
    EXPERIMENT = U{2};
    CHANNEL = U{3};
    %% ����������
%     load(sprintf('result/%s/%s/data.mat', DATE, EXPERIMENT));

    
end
%%
clear
DATE = '20190123';
EXPERIMENT = 'CHO-VH-B-FRAP002';
CHANNEL = 1;

%% ��ȡԭʼͼ���ROI��Ϣ
[roiimage, imgs, frame] = getrawimage(DATE, EXPERIMENT);
[roiMatrix, roiCo] = getroi(roiimage, DATE, EXPERIMENT);
%% ��ȡÿ֡��frap���ݣ�ROI��֮�ͣ�
rawfrapinf = getrawfrap(imgs, roiMatrix, CHANNEL, DATE, EXPERIMENT);
%% ��һ��frap��Ϣ
normalizedfrapinf = normalizefrap(rawfrapinf, DATE, EXPERIMENT);
%% ����ROI��frap�仯
% normalizedfrapinf
INPUT_FRAP_INF = normalizedfrapinf;
drawmap(imgs, INPUT_FRAP_INF, CHANNEL, roiCo, DATE, EXPERIMENT,...
    'normalizedmap');
%% ÿ��ROI�ı仯
% normalizedfrapinf
INPUT_FRAP_INF = normalizedfrapinf;
drawindividual(imgs, INPUT_FRAP_INF, CHANNEL, roiCo, DATE, EXPERIMENT);

%% ��ROIͼ��ƴ�ӵ�һ��ͼ�У��б���Ϊ��Ҫƴ�ӵ�ROI
DISPLAY_LIST = [1;2;3;4;5;6;7;8;9];
videogrid(imgs, roiCo, DISPLAY_LIST, CHANNEL, 'grid', DATE, EXPERIMENT);
%% ��ROI�Ͷ�Ӧ��FRAP��Ϣ�����һ��4άtifͼ����
INPUT_FRAP_INF = normalizedfrapinf;
DISPLAY_LIST = 'all';
drawh(imgs, roiCo, INPUT_FRAP_INF, DISPLAY_LIST, DATE, EXPERIMENT, CHANNEL);
%%
DISPLAY_LIST = [1,2,3,4,5,6,7,8];
% DISPLAY_LIST = [9,10,11];
FILENAME = 'hgrid1';
h2grid(individualh,FILENAME,DISPLAY_LIST,DATE,EXPERIMENT,CHANNEL);
%%
% %% ����µ�ROI
% add = [1,1,248,200];
% [roiMatrix, roiCo] = addroi(roiMatrix, roiCo, DATE, EXPERIMENT, add);
% %%
% cuttedimgs = cutimg(imgs, diroiMatrix, roiCo, 10, CHANNEL, DATE,...
%     EXPERIMENT);
% diroiMatrix = dilateroi(roiMatrix, 10, DATE, EXPERIMENT);
