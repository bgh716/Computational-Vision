clear all ;
im1 = imread("../data/im1.png");
im2 = imread("../data/im2.png");
corr_mat = load("../data/someCorresp.mat");
pts1 = corr_mat.pts1;
pts2 = corr_mat.pts2;
M  = corr_mat.M;
F = eightpoint(pts1, pts2, M);
displayEpipolarF(im1, im2, F);
epipolarMatchGUI(im1, im2, F);
ins_mat = load("../data/intrinsics.mat");
K1 = ins_mat.K1;
K2 = ins_mat.K2;
E = essentialMatrix(F, K1, K2);
P1 = zeros(3,4);
P1(1,1) = 1;
P1(2,2) = 1;
P1(3,3) = 1;
%E(1,1)=-0.0025;
%E(1,2)=0.4070;
%E(1,3)=0.0476;
%E(2,1)=0.1863;
%E(2,2)=0.0127;
%E(2,3)=-2.2833;
%E(3,1)=0.0076;
%E(3,2)=2.3114;
%E(3,3)=0.0026;
P2 = camera2(E);
disp(P2)
%P2 = K2*P2(:,:,1);
P2 = K2*P2(:,:,2);
%P2 = K2*P2(:,:,3);
%P2 = K2*P2(:,:,4);
P1 = K1*P1;


pts1 = load("../data/templeCoords.mat").pts1;
pts2 = epipolarCorrespondence(im1, im2, F, pts1);
pts3d = triangulate(P1, pts1, P2, pts2 );
pts3dd = ones(length(pts3d(:,1)),4);
pts2d1 = zeros(length(pts3d(:,1)),2);
pts2d2 = zeros(length(pts3d(:,1)),2);
for i =1:length(pts3d(:,1))
    pts3dd(i,1:3) = pts3d(i,:);
    temp = P1*pts3dd(i,:).';
    temp = temp/temp(3);
    pts2d1(i,:) = temp(1:2);
    temp = P2*pts3dd(i,:).';
    temp = temp/temp(3);
    pts2d2(i,:) = temp(1:2);
end
error1 = 0;
error2 = 0;
for i = 1:110
    error1 = error1 + norm(pts1(i,:) - pts2d1(i,:));
    error2 = error2 + norm(pts2(i,:) - pts2d2(i,:));
end
disp(error1/110)
disp(error2/110)