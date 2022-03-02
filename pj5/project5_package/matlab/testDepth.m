clear all ;
% Load image and paramters
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);



load('rectify.mat', 'M1', 'M2', 'K1n', 'K2n', 'R1n', 'R2n', 't1n', 't2n');

[rectIL, rectIR, bbL, bbR] = warp_stereo(im1, im2, M1, M2) ;
[nR nC] = size(rectIL) ;
rectImg = zeros(nR, 2*nC, 'uint8') ;
rectImg(:,1:nC) = rectIL ;
rectImg(:,nC+1:end) = rectIR ;
im1 = rectImg(:,423:960);
im2 = rectImg(:,961:1498);

maxDisp = 20; 
windowSize = 3;
dispM = get_disparity(im1, im2, maxDisp, windowSize);

% --------------------  get depth map

depthM = get_depth(dispM, K1n, K2n, R1n, R2n, t1n, t2n);
c1 = -1 * ((K1n*R1n)^(-1)*(K1n*t1n)); %3x1 vector
c2 = -1 * ((K2n*R2n)^(-1)*(K2n*t2n));

% --------------------  Display

figure; imagesc(dispM.*(im1>40)); colormap(gray); axis image;
figure; imagesc(depthM.*(im1>40)); colormap(gray); axis image;
