close all;
clear all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');

[locs1, locs2] = matchPics(cv_desk, cv_cover, '4.1');
%locs1 = locs1.Location;
%locs2 = locs2.Location;
H2to1 = computeH( locs1, locs2 );
H2to1N = computeH_norm( locs1, locs2 );

r = rand(20,1);
a = size(cv_cover);

loc2 = ones(length(locs2),3);
for i =1:10
    loc2(i,1:2) = [a(1)*r(i), a(2)*r(i+10)];
end

%loc2(:,1:2) = locs2;
loc1 = zeros(length(locs1),2);
for i = 1:length(locs2)
    mat = H2to1 * loc2(i,:).';
    mat = mat/mat(3);
    loc1(i,:) = mat(1:2).';
end

loc1N = zeros(length(locs1),2);
for i = 1:length(locs2)
    mat = H2to1N * loc2(i,:).';
    mat = mat/mat(3);
    loc1N(i,:) = mat(1:2).';
end

figure;
showMatchedFeatures(cv_desk, cv_cover, loc1, loc2(:,1:2), 'montage');
title('H');

figure;
showMatchedFeatures(cv_desk, cv_cover, loc1N, loc2(:,1:2), 'montage');
title('H norm');
[ bestH2to1, inliers, max] = computeH_ransac( locs1, locs2 );
loc2RANSAC = ones(max,3);
count = 1;
for i =1:length(locs2)
    if inliers(i) == 1
        loc2RANSAC(count,1:2) = locs2(i,:);
        count = count + 1;
    end
end
loc1RANSAC = zeros(max,2);
for i = 1:max
    mat = bestH2to1 * loc2RANSAC(i,:).';
    mat = mat/mat(3);
    loc1RANSAC(i,:) = mat(1:2).';
end
figure;
showMatchedFeatures(cv_desk, cv_cover, loc1RANSAC, loc2RANSAC(:,1:2), 'montage');
title('H RANSAC');