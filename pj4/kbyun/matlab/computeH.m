function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
A = zeros(2*length(x1),9);
for i = 1 : length(x1)
    A(i*2-1,1) = -x2(i,1);
    A(i*2-1,2) = -x2(i,2);
    A(i*2-1,3) = -1;
    A(i*2-1,4) = 0;
    A(i*2-1,5) = 0;
    A(i*2-1,6) = 0;
    A(i*2-1,7) = x2(i,1)*x1(i,1);
    A(i*2-1,8) = x2(i,2)*x1(i,1);
    A(i*2-1,9) = x1(i,1);
    A(i*2,1) = 0;
    A(i*2,2) = 0;
    A(i*2,3) = 0;
    A(i*2,4) = -x2(i,1);
    A(i*2,5) = -x2(i,2);
    A(i*2,6) = -1;
    A(i*2,7) = x2(i,1)*x1(i,2);
    A(i*2,8) = x2(i,2)*x1(i,2);
    A(i*2,9) = x1(i,2);
end

%%%svd
[U,S,V] = svd(A);
h = V(:,9);

%%eig
%[V,D] = eig(A.'*A);
%[d,ind] = sort(diag(D));
%A*V(:,ind(1))
%h = V(:,ind(1));

H2to1 = zeros(3,3);
for i = 1:3
    H2to1(i,:) = h(i*3-2:i*3);
end
end