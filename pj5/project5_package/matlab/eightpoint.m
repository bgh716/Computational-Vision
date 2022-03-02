function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)
S1 = std(pts1);
S2 = std(pts2);
S11 = S1(1);
S12 = S1(2);
S21 = S2(1);
S22 = S2(2);
% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

% Normalization
N = length(pts1);
%scaled_pts1 = pts1 / M;
%scaled_pts2 = pts2 / M;
scaled_pts1 = zeros(N,2);
scaled_pts2 = zeros(N,2);
for i = 1:N
    scaled_pts1(i,1) = pts1(i,1) / S11;
    scaled_pts1(i,2) = pts1(i,2) / S12;
    scaled_pts2(i,1) = pts2(i,1) / S21;
    scaled_pts2(i,2) = pts2(i,2) / S22;
end

%   construct A
A = zeros(length(pts1),9);
for i = 1:N
    A(i,1) = scaled_pts2(i,1)*scaled_pts1(i,1);
    A(i,2) = scaled_pts2(i,1)*scaled_pts1(i,2);
    A(i,3) = scaled_pts2(i,1);
    A(i,4) = scaled_pts2(i,2)*scaled_pts1(i,1);
    A(i,5) = scaled_pts2(i,2)*scaled_pts1(i,2);
    A(i,6) = scaled_pts2(i,2);
    A(i,7) = scaled_pts1(i,1);
    A(i,8) = scaled_pts1(i,2);
    A(i,9) = 1;
end

% Decompose A to get F
[U,S,V] = svd(A);
f = V(:,9);
F = zeros(3,3);
for i = 1:3
    F(i,:) = f(i*3-2:i*3);
end

% Debugging tool for F
scaled_pts1t = ones(N,3);
scaled_pts2t = ones(N,3);
for i = 1:N
    scaled_pts1t(i,1) = scaled_pts1(i,1);
    scaled_pts1t(i,2) = scaled_pts1(i,2);
    scaled_pts2t(i,1) = scaled_pts2(i,1);
    scaled_pts2t(i,2) = scaled_pts2(i,2);
end

pts1t = ones(N,3);
pts2t = ones(N,3);
for i = 1:N
    pts1t(i,1) = pts1(i,1);
    pts1t(i,2) = pts1(i,2);
    pts2t(i,1) = pts2(i,1);
    pts2t(i,2) = pts2(i,2);
end

% Decompose F to get F'
[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V;


% Refine F
F = refineF(F, scaled_pts1, scaled_pts2);


% Un-Normalization
scale_matrix1 = zeros(3,3);
scale_matrix1(1,1) = 1/S11;
scale_matrix1(2,2) = 1/S12;
scale_matrix1(3,3) = 1;
scale_matrix2 = zeros(3,3);
scale_matrix2(1,1) = 1/S21;
scale_matrix2(2,2) = 1/S22;
scale_matrix2(3,3) = 1;
F = scale_matrix2*F*scale_matrix1;

%meann = mean(mean(pts2t*F*pts1t.'));

% Display the result
%I1 = imread("../data/im1.png");
%I2 = imread("../data/im2.png");
%displayEpipolarF(I1, I2, F)
end