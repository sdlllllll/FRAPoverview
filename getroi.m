function [roiStack,roiCo] = getroi(roiimage,date,experiment)
% Input ROI image, return ROI stacks and ROI coordinate. Date and
% experiment name use for saving.
%
% [roiStack,roiCo] = getroi(roiimage,date,experiment)
%     roiStack(m,n,p):
%         m: high
%         n: width
%         p: the serial number of ROI
%     roiCo(m,n):

res = size(roiimage);
roiStack = zeros(res(1),res(2),100);
roiCo = zeros(100,7);
roiNum = 1;
for y = 1:res(1)
    for x = 1:res(2)
        newROI = true;
        if roiimage(y,x) == 1
            if roiNum > 1
                s = sum(roiStack,3);
                if s(y,x) > 0
                    newROI = false;
                end
            end
            if newROI == true
                yend = y;
                xend = x;
                while roiimage(yend+1,x) == 1
                    yend = yend+1;
                end
                while roiimage(y,xend+1) == 1
                    xend = xend+1;
                end
                for m = y:yend
                    for n = x:xend
                        roiStack(m,n,roiNum) = 1;
                    end
                end
                roiCo(roiNum,:) = [x,y,xend-x+1,yend-y+1,xend,yend,roiNum];
                roiNum = roiNum + 1;
            end
        end
    end
end
roiCo = roiCo(1:roiNum-1,:);
roiStack = roiStack(:,:,1:roiNum-1);
roiStack = logical(roiStack);
%%
save(sprintf('result/%s/%s/data.mat',date,experiment),'roiStack',...
    'roiCo','-append','-nocompression');
fprintf('Get ROI information finished.\n');
end