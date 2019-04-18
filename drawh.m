function drawh(imgs, roiCo, frapinf, displaylist, date, experiment, channel)
%%
switch get(groot, 'ScreenPixelsPerInch')
    case 72
        % MacOS
        PICTUREHEIGHT = 90;
        PICTUREWIDTH = 320;
        AX11 = 2;
        AX12 = 86;
        AX21 = 100;
        AX22 = 10;
        AX23 = 215;
        AX24 = 75;
    case 96
        % Windows
        PICTUREHEIGHT = 180;
        PICTUREWIDTH = 640;
        AX11 = 4;
        AX12 = 172;
        AX21 = 200;
        AX22 = 20;
        AX23 = 430;
        AX24 = 150;
end
total = size(imgs, 3);
if displaylist == 'all'
    displaylist = (1:size(roiCo,1))';
end
for m=1:size(displaylist, 1)
    %%
    n=displaylist(m);
    if (roiCo(n,3)>40) || (roiCo(n,4)>40)
        continue
    end
    imgstack = zeros(40, 40, 3, total);
    xstart = roiCo(n,2)-floor((40-roiCo(n,4))/2);
    ystart = roiCo(n,1)-floor((40-roiCo(n,3))/2);
    dis = roiCo(n,7);
    rect=[(40-roiCo(n,3))/2,(40-roiCo(n,4))/2,roiCo(n,3)+2,roiCo(n,4)+2];
    graygrid = imgs(xstart:xstart+39,ystart:ystart+39,:,channel);
    imgstack(:,:,2,:) = graygrid/4095;
    for f = 1:total
        imgstack(:,:,:,f) = insertText(imgstack(:,:,:,f),[-1,-1],dis,'TextColor','red','BoxOpacity',0,'FontSize',8);
        imgstack(:,:,:,f) = insertShape(imgstack(:,:,:,f),'Rectangle',rect,'Color','red');
    end
    %%
    for f = 1:total
        %%
        fig = figure();
        fig.Visible = 'off';
        fig.Units = 'pixels';
        fig.Position = [0,0,PICTUREWIDTH,PICTUREHEIGHT];
        ax1 = axes('Units', 'pixels', 'Position', [AX11,AX11,AX12,AX12]);
        imshow(imgstack(:,:,:,f));
        ax2 = axes('Units','pixels','Position',[AX21,AX22,AX23,AX24]);
        plot(frapinf(:,m));
        hold on;
        plot([f,f],[0,1],'r');
        hold off;
        % problem
        ax2.FontSize = 6;
        tmp = getframe(fig);
        imwrite(tmp.cdata,sprintf('result/%s/%s/roi%dC%dh.tif', date, experiment, n, channel), 'WriteMode', 'append');
        close;
    end
    %%
    for f = 1:total
        individualh(f,m).img = imread(sprintf('result/%s/%s/roi%dC%dh.tif', date, experiment, n, channel),f);
    end
end
save(sprintf('result/%s/%s/data.mat', date, experiment), 'individualh',...
    '-append', '-nocompression');
disp('Readable individual image saved.')
end