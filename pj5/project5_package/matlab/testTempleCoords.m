% A test script using templeCoords.mat
%
% Write your code here
%
clear all ;
im1 = imread("../data/im1.png");
im2 = imread("../data/im2.png");
corr_mat = load("../data/someCorresp.mat");
pts1 = corr_mat.pts1;
pts2 = corr_mat.pts2;
M  = corr_mat.M;
F = eightpoint(pts1, pts2, M);
pts1 = load("../data/templeCoords.mat").pts1;
pts2 = epipolarCorrespondence(im1, im2, F, pts1);
ins_mat = load("../data/intrinsics.mat");
K1 = ins_mat.K1;
K2 = ins_mat.K2;
E = essentialMatrix(F, K1, K2);
P1 = zeros(3,4);
P1(1,1) = 1;
P1(2,2) = 1;
P1(3,3) = 1;
P2 = camera2(E);
%P1=[R1|t1] R1 = 3x3 t1 = 3x1
%P2=[R2|t2] R2 = 3x3 t2 = 3x1
R1 = P1(:,1:3);
t1 = P1(:,4);
R2 = P2(:,1:3,2);
t2 = P2(:,4,2);

%P2 = K2*P2(:,:,1);
P2 = K2*P2(:,:,2);
%P2 = K2*P2(:,:,3);
%P2 = K2*P2(:,:,4);
%P2 = P2(:,:,4);
P1 = K1*P1;



pts3d = triangulate(P1, pts1, P2, pts2 );
plot3(pts3d(:,1),pts3d(:,2),pts3d(:,3),'.');
axis equal
% save extrinsic parameters for dense reconstruction

save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
