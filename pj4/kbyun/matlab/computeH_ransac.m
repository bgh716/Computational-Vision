function [ bestH2to1, inliers, max] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
N = 18; %assume that error is 0.5, and 72 iterations is not actually expensive.
len = length(locs1);
pts = 4;
max = 0;
threshold = sqrt(2);
for i =1:N
    count = 0;
    inliers_t = zeros(N);
    r = randperm(len,pts);
    sample1 = zeros(pts,2);
    sample2 = zeros(pts,2);
    for j =1:pts
        sample1(j,:) = locs1(r(j),:);
        sample2(j,:) = locs2(r(j),:);
    end
    H = computeH_norm(sample1, sample2);
    
    loc2 = ones(length(locs2),3);
    loc2(:,1:2) = locs2;
    loc1 = zeros(length(locs1),2);
    
    for j = 1:len
        mat = H * loc2(j,:).';
        mat = mat/mat(3);
        loc1(j,:) = mat(1:2).';
        %d = pdist([loc1(j,1:2),locs1(j,:)],'euclidean');
        d = norm(loc1(j,1:2) - locs1(j,:));
        if d < threshold
            count = count + 1;
            inliers_t(j) = 1;
        end
    end
    
    if count > max
        inliers = inliers_t;
        max = count;
    end
end

final_sample1 = zeros(max,2);
final_sample2 = zeros(max,2);
count = 1;

for i =1:len
    if inliers(i) == 1
        final_sample1(count,:) = locs1(i,:);
        final_sample2(count,:) = locs2(i,:);
        count = count + 1;
    end
end

%Q2.2.3
bestH2to1 = computeH_norm(final_sample1, final_sample2);
end

%N = 72 iterations