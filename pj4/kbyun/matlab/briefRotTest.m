% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
cv_cover = imread('../data/cv_cover.jpg');
%% Compute the features and descriptors
hist = zeros(1,37);
for i = 0:36
    %% Rotate image
    angle = i*10;
    cv_cover_ro = imrotate(cv_cover,angle);
    %% Compute features and descriptors
    
    %% Match features
    [locs1, locs2] = matchPics(cv_cover, cv_cover_ro, '4.2');
    %% Update histogram
    if length(locs1) == length(locs2)
        hist(i+1) = length(locs1);
    end
    if i == 10
        figure;
        showMatchedFeatures(cv_cover, cv_cover_ro, locs1, locs2, 'montage');
        title('Showing all matches');
    end
end
%% Display histogram
%h = histogram(hist)