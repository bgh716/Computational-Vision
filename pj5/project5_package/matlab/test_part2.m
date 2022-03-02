clear all;
ext_mat = load("../data/extrinsics.mat");
ins_mat = load("../data/intrinsics.mat");
K1 = ins_mat.K1;
K2 = ins_mat.K2;
R1 = ext_mat.R1;
R2 = ext_mat.R2;
t1 = ext_mat.t1;
t2 = ext_mat.t2;

im1 = imread("../data/im1.png");
im2 = imread("../data/im2.png");
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
maxDisp = 20;
windowSize = 3;

[M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = rectify_pair(K1, K2, R1, R2, t1, t2);
[rectIL, rectIR, bbL, bbR] = warp_stereo(im1, im2, M1, M2) ;

[nR nC] = size(rectIL) ;
rectImg = zeros(nR, 2*nC, 'uint8') ;
rectImg(:,1:nC) = rectIL ;
rectImg(:,nC+1:end) = rectIR ;
im1 = rectImg(:,423:960);
im2 = rectImg(:,961:1498);
figure;
imshow(im1)
figure;
imshow(im2)
dispM = get_disparity(im1, im2, maxDisp, windowSize);
figure; imagesc(dispM.*(im1>40)); colormap(gray); axis image;