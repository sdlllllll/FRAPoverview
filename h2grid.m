function h2grid(individualh,filename, displaylist, date, experiment, channel)
% Display up to 8 FRAP change videos and statistic information
% in one video.

if strcmp(displaylist,'all')
    displaylist = (1:size(individualh,2))';
end
frame = size(individualh,1);
gridh = zeros(720,1280,3,frame);
num = size(displaylist,1);
if num > 8
    num = 8;
end
partimg = zeros(180,640,3,frame,8);
for m = 1:num
    roi = displaylist(m);
    for n = 1:frame
        partimg(:,:,:,n,m) = individualh(n,roi).img;
    end
end
gridh = [
    partimg(:,:,:,:,1),partimg(:,:,:,:,2);
    partimg(:,:,:,:,3),partimg(:,:,:,:,4);
    partimg(:,:,:,:,5),partimg(:,:,:,:,6);
    partimg(:,:,:,:,7),partimg(:,:,:,:,8);];
gridh = uint8(gridh);
for m = 1:frame
    imwrite(gridh(:,:,:,m),sprintf('result/%s/%s/%s.tif',date,experiment,filename),'WriteMode','append');
end
disp('Readable video saved.');
end