function [imgs,roiimage] = getrawimage(date,experiment)
% Input date and experiment name, return original images and ROI image.
% 
% [imgs, roiimage] = getrawimage(date,experiment)
%     originalimgs(m,n,t,c):
%         m: high
%         n: width
%         t: time
%         c: channel
%     roiimage(m,n):
%         m: high
%         n: width

roiimage = imread(sprintf('%s/%s_ROI.tif',date,experiment));
[x,y] = size(roiimage);
imgdir = sprintf('%s/%s',date,experiment);
list = dir(imgdir);
filenum = size(list,1);
maxframe = 0;
maxchannel = 0;
% Test filename length.
for k=1:filenum
    try
        t = extractAfter(string(regexp(list(k).name,'_t[0-9]+',...
            'match')),'_t');
        lent = strlength(t);
        t = str2double(t);
        if t > maxframe
            maxframe = t;
        end
        c = extractAfter(string(regexp(list(k).name,'_c[0-9]+',...
            'match')),'_c');
        c = str2double(c);
        if c > maxchannel
            maxchannel = c;
        end
    catch
        continue
    end
end
frame = maxframe;
imgs = zeros(x,y,frame,maxchannel);
% Put original images into matrix.
for c=1:maxchannel
    for t=1:frame
        switch lent
            case 3
                imgs(:,:,t,c) = imread(sprintf(...
                    '%s/%s/%s_t%03d_c%03d.tif',...
                    date,experiment,experiment,t,c));
            case 4
                imgs(:,:,t,c) = imread(sprintf(...
                    '%s/%s/%s_t%04d_c%04d.tif',...
                    date,experiment,experiment,t,c));
        end
    end
end
mkdir(sprintf('result/%s/%s',date,experiment))
% Save data in .mat file with -v7.3.
save(sprintf('result/%s/%s/data.mat',date,experiment),...
    'imgs','roiimage','-v7.3','-nocompression');
fprintf('Get original image finished.\n');
return
end
