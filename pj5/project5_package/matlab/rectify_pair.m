function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m
%clear all;
%ext_mat = load("../data/extrinsics.mat");
%ins_mat = load("../data/intrinsics.mat");
%K1 = ins_mat.K1;
%K2 = ins_mat.K2;
%R1 = ext_mat.R1;
%R2 = ext_mat.R2;
%t1 = ext_mat.t1;
%t2 = ext_mat.t2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c1 = -1 * ((K1*R1)^(-1)*(K1*t1));
c2 = -1 * ((K2*R2)^(-1)*(K2*t2));

r1 = (c1-c2)/norm(c1-c2);
r2 = cross(R1(3,:),r1);
r3 = cross(r2,r1);

K = K2;
R = zeros(3,3);
R(:,1) = r1;
R(:,2) = r2;
R(:,3) = r3;
R = R.';
%%%%%%%%%
t1n = -1*R*c1;
t2n = -1*R*c2;
R1n = R;
R2n = R;
K2n = K2;
K1n = K2;
%%%%%%%%%

M1 = (K*R)*(K1*R1)^(-1);
M2 = (K*R)*(K2*R2)^(-1);
end