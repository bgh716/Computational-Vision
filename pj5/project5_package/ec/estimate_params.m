function [K, R, t] = estimate_params(P)
M = P(:,1:3);
[U,S,V] = svd(P);
c = V(1:3,4)/V(4,4);

%https://www.uio.no/studier/emner/matnat/its/nedlagte-emner/UNIK4690/v17/forelesninger/lecture_5_2_pose_from_known_3d_points.pdf
%QR-decomposition to RQ-decomposition
[R,K] = qr(rot90(M,3));
K = rot90(K,2);
R = rot90(R);

%http://ksimek.github.io/2012/08/14/decompose/
%make diagonal of K positive
T = diag(sign(diag(K)));
K = K * T;
R = T * R;
K = K/K(3,3);
t = -1*R*c;
end