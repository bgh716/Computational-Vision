function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
w = (windowSize-1)/2;
dispM = zeros(size(im1,1),size(im1,2));
for y = 1:size(dispM,1)
    for x = 1:size(dispM,2)
        args = zeros(1,maxDisp+1);
        for d =0:maxDisp
            dist = 0;
            for i = -w:w
                for j = -w:w
                    y0 = y+i;
                    x0 = x+j;
                    x1 = x+j-d;
                    if y+i<1
                        y0 = 1;
                    end
                    if y+i>size(im1,1)
                        y0 = size(im1,1);
                    end
                    if x+j<1
                        x0 = 1;
                    end
                    if x+j>size(im1,2)
                        x0 = size(im1,2);
                    end
                    if x+j-d<1
                        x1 = 1;
                    end
                    if x+j-d>size(im1,2)
                        x1 = size(im1,2);
                    end
                    dist = dist + (im1(y0,x0)-im2(y0,x1))^2;
                end
            end
            args(d+1) = dist;
        end
        [val,ind]=min(args);
        dispM(y,x) = ind-1;
    end
    disp(y/size(dispM,1))
end
end