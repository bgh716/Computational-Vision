% Q3.3.1
close all;
clear all;

source = loadVid("../data/ar_source.mov");
book = loadVid("../data/book.mov");
cv_img = imread('../data/cv_cover.jpg');
frames = length(source);

%https://www.mathworks.com/matlabcentral/answers/280635-make-video-from-images
video = VideoWriter('ar.avi');
open(video);
for i =1:frames
    fprintf('%d/%d\n',i,frames);
    source_img = source(i).cdata;
    source_img_cropped = source_img(45:size(source_img,1)-45, int32(size(source_img,2)*(1/3)):int32(size(source_img,2)*(2/3)),:);
    book_img = book(i).cdata;
    [locs1, locs2] = matchPics(book_img, cv_img, '4.1');
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    scaled_source_img_cropped = imresize(source_img_cropped, [size(cv_img,1) size(cv_img,2)]);
    warped_image = compositeH(bestH2to1, scaled_source_img_cropped, book_img);
    writeVideo(video,warped_image);
end
close(video);