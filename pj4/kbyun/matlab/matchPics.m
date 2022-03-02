function [ locs1, locs2] = matchPics( I1, I2, Q )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
I11 = im2gray(I1);
I22 = im2gray(I2);
%% Detect features in both images
if strcmp(Q,'4.1')
    corners1 = detectFASTFeatures(I11);
    corners2 = detectFASTFeatures(I22);
elseif strcmp(Q,'4.2')
    corners1 = detectSURFFeatures(I11);
    corners2 = detectSURFFeatures(I22);
end
%% Obtain descriptors for the computed feature locations
if strcmp(Q,'4.1')
    [desc1, loc1] = computeBrief(I11,corners1.Location);
    [desc2, loc2] = computeBrief(I22,corners2.Location);
elseif strcmp(Q,'4.2')
    [desc1, loc1] = extractFeatures(I11,corners1.Location,'Method','SURF');
    [desc2, loc2] = extractFeatures(I22,corners2.Location,'Method','SURF');
end
%% Match features using the descriptors
threshold = 10.0;
ratio = 0.69555;
indexPairs = matchFeatures(desc1, desc2, 'MatchThreshold', threshold, 'MaxRatio', ratio);
locs1 = loc1(indexPairs(:,1),:);
locs2 = loc2(indexPairs(:,2),:);
end