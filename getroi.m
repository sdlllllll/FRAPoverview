function [roiMatrix, roiCo] = getroi(roiimage, date, experiment)
%%
res = size(roiimage);
roiMatrix = zeros(res(1),res(2),100);
roiCo = zeros(100, 7);
roiNum = 1;
for y = 1:res(1)
    for x = 1:res(2)
        newROI = true;
        if roiimage(y,x) == 1
            if roiNum > 1
                s = sum(roiMatrix, 3);
                if s(y,x) > 0
                    newROI = false;
                end
            end
            if newROI == true
                yend = y;
                xend = x;
                while roiimage(yend+1, x) == 1
                    yend = yend+1;
                end
                while roiimage(y, xend+1) == 1
                    xend = xend+1;
                end
                for m = y:yend
                    for n = x:xend
                        roiMatrix(m, n, roiNum) = 1;
                    end
                end
                roiCo(roiNum,:) = [x, y, xend-x+1, yend-y+1, xend, yend,...
                    roiNum];
                roiNum = roiNum + 1;
            end
        end
    end
end
roiCo = roiCo(1:roiNum-1, :);
roiMatrix = roiMatrix(:,:,1:roiNum-1);
roiMatrix = logical(roiMatrix);
%%
save(sprintf('result/%s/%s/data.mat', date, experiment), 'roiMatrix',...
    'roiCo', '-append');
end