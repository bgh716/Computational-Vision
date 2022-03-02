function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
N = length(pts1(:,1));
w = 25; %must be an odd
p = (w-1)/2;
threshold = sqrt(2);

im2_h = size(im2,1);
im2_w = size(im2,2);
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);

pts1t = ones(N,3);
pts2 = zeros(N,2);
for i = 1:N
    inliers = zeros(im2_h*im2_w,2);
    count = 0;
    
    pts1t(i,1) = pts1(i,1);
    pts1t(i,2) = pts1(i,2);
    L = F*pts1t(i,:).';
    
    for j = 1:im2_w
        for k =1:im2_h
            if abs(L(1)*j + L(2)*k + L(3)) / sqrt(L(1)^2 + L(2)^2) < threshold
                count = count + 1;
                inliers(count, 1) = j;
                inliers(count, 2) = k;
            end
        end
    end
    
    inliers = inliers(1:count,:);
    
    if pts1(i,1)+p < size(im1,2)
        x_size_end = pts1(i,1)+p;
    else
        x_size_end = size(im1,2);
    end
    
    if pts1(i,2)+p < size(im1,1)
        y_size_end = pts1(i,2)+p;
    else
        y_size_end = size(im1,1);
    end
    
    if pts1(i,1)-p > 1
        x_size_start = pts1(i,1)-p;
        x_center_original = p + 1;
    else
        x_size_start = 1;
        x_center_original = pts1(i,1);
    end
    
    if pts1(i,2)-p > 1
        y_size_start = pts1(i,2)-p;
        y_center_original = p + 1;
    else
        y_size_start = 1;
        y_center_original = pts1(i,2);
    end
    
    window_original = im1(y_size_start:y_size_end,x_size_start:x_size_end,:);
    
    min = 10000000000;
    indx = 1;
    for j = 1:count
        if inliers(j,1)+p < size(im2,2)
            x_size_end = inliers(j,1)+p;
        else
            x_size_end = size(im2,2);
        end

        if inliers(j,2)+p < size(im2,1)
            y_size_end = inliers(j,2)+p;
        else
            y_size_end = size(im2,1);
        end

        if inliers(j,1)-p > 1
            x_size_start = inliers(j,1)-p;
            x_center_target = p + 1;
        else
            x_size_start = 1;
            x_center_target = inliers(j,1);
        end

        if inliers(j,2)-p > 1
            y_size_start = inliers(j,2)-p;
            y_center_target = p + 1;
        else
            y_size_start = 1;
            y_center_target = inliers(j,2);
        end
        
        window_target = im2(y_size_start:y_size_end,x_size_start:x_size_end,:);
        if size(window_original,1) ~= size(window_target,1) || size(window_original,2) ~= size(window_target,2) || x_center_original ~= x_center_target || y_center_original ~= y_center_target
            continue
        end
        
        score = norm(single(window_original)-single(window_target));
        
        if score < min
            min = score;
            indx = j;
        end
    end
    pts2(i,1) = inliers(indx,1);
    pts2(i,2) = inliers(indx,2);
end
end