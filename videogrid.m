function videogrid(imgs,roiCo,displaylist,channel,filename,date,experiment)
% Display up to 16 FRAP change videos in one video.

t = size(imgs,3);
rgbgrid = zeros(40,40,3,t,16);
if strcmp(displaylist,'all')
    displaylist = (1:size(roiCo,1))';
for m=1:size(displaylist,1)
    n=displaylist(m);
    if (roiCo(n,3)>40) || (roiCo(n,4)>40)
        continue
    end
    xstart = roiCo(n,2)-floor((40-roiCo(n,4))/2);
    ystart = roiCo(n,1)-floor((40-roiCo(n,3))/2);
    dis = roiCo(n,7);
    rect=[(40-roiCo(n,3))/2,(40-roiCo(n,4))/2,roiCo(n,3)+2,roiCo(n,4)+2];
    graygrid = imgs(xstart:xstart+39,ystart:ystart+39,:,channel);
    graygrid = graygrid/4095;
    rgbgrid(:,:,2,:,m) = graygrid(:,:,:);
    for f = 1:t
        rgbgrid(:,:,:,f,m) = insertText(rgbgrid(:,:,:,f,m),[-1,-1],dis,'TextColor','red','BoxOpacity',0,'FontSize',8);
        rgbgrid(:,:,:,f,m) = insertShape(rgbgrid(:,:,:,f,m),'Rectangle',rect,'Color','red');
    end
end
bigimg = [
    rgbgrid(:,:,:,:,1),rgbgrid(:,:,:,:,2),rgbgrid(:,:,:,:,3),rgbgrid(:,:,:,:,4);
    rgbgrid(:,:,:,:,5),rgbgrid(:,:,:,:,6),rgbgrid(:,:,:,:,7),rgbgrid(:,:,:,:,8);
    rgbgrid(:,:,:,:,9),rgbgrid(:,:,:,:,10),rgbgrid(:,:,:,:,11),rgbgrid(:,:,:,:,12);
    rgbgrid(:,:,:,:,13),rgbgrid(:,:,:,:,14),rgbgrid(:,:,:,:,15),rgbgrid(:,:,:,:,16);];
for m = 1:size(bigimg,4)
imwrite(bigimg(:,:,:,m),sprintf('result/%s/%s/%s.tif', date, experiment, filename),'WriteMode','append');
end
disp('Multiple image saved.');
end