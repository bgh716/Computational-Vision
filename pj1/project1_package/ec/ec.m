layers = get_lenet();
load lenet.mat

img1 = imread('../images/image1.jpg');
img2 = imread('../images/image2.jpg');
img3 = imread('../images/image3.png');
img4 = imread('../images/image4.jpg');

img1 = rgb2gray(img1);
img1 = im2bw(img1);
img1 = imcomplement(img1);
img1 = rescale(img1);

img2 = rgb2gray(img2);
img2 = im2bw(img2);
img2 = imcomplement(img2);
img2 = rescale(img2);

img3 = rgb2gray(img3);
img3 = im2bw(img3);
img3 = imcomplement(img3);
img3 = rescale(img3);

img4 = rgb2gray(img4);
img4 = im2bw(img4);
img4 = imcomplement(img4);
img4 = rescale(img4);

curr_img = img4; %change img here
splits = bwconncomp(curr_img); 
objects = splits.NumObjects;
stats = regionprops(splits,'BoundingBox');%left top width height

pad_size = 6;
img_tray_temp = zeros(28*28,objects);
objects_modified = objects;
for i=1:objects
    boundary = stats(i).BoundingBox;
    if boundary(3) == 1 && boundary(4) == 1
        objects_modified = objects_modified - 1;
        continue;
    end
    xMin = ceil(boundary(1));
    xMax = xMin + boundary(3) - 1;
    yMin = ceil(boundary(2));
    yMax = yMin + boundary(4) - 1;
    img = curr_img(yMin:yMax,xMin:xMax);
    img = imresize(img.',[16 16]);
    img = padarray(img,[pad_size pad_size],0,'both');
    img = reshape(img,28*28,1);
    img_tray_temp(:,i) = img;
end
layers{1}.batch_size = objects_modified;
img_tray = zeros(28*28,objects_modified);
for i=1:objects_modified
    img_tray(:,i) = img_tray_temp(:,i);
    %subplot(1,objects_modified,i), imshow(reshape(img_tray(:,i),28,28)');
    subplot(5,11,i), imshow(reshape(img_tray(:,i),28,28)');
    %subplot(2,5,i), imshow(reshape(img_tray(:,i),28,28)');
end
[output, P] = convnet_forward(params, layers, img_tray);
[mx, index] = max(P);

disp(index-1);