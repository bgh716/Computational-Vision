function P = estimate_pose(x, X)
N = size(x,2);
A = zeros(2*N,12);
for i = 1:N
    A(i*2-1,1) = -X(1,i);
    A(i*2-1,2) = -X(2,i);
    A(i*2-1,3) = -X(3,i);
    A(i*2-1,4) = -1;
    A(i*2-1,5) = 0;
    A(i*2-1,6) = 0;
    A(i*2-1,7) = 0;
    A(i*2-1,8) = 0;
    A(i*2-1,9) = x(1,i)*X(1,i);
    A(i*2-1,10) = x(1,i)*X(2,i);
    A(i*2-1,11) = x(1,i)*X(3,i);
    A(i*2-1,12) = x(1,i);
    A(i*2,1) = 0;
    A(i*2,2) = 0;
    A(i*2,3) = 0;
    A(i*2,4) = 0;
    A(i*2,5) = -X(1,i);
    A(i*2,6) = -X(2,i);
    A(i*2,7) = -X(3,i);
    A(i*2,8) = -1;
    A(i*2,9) = x(2,i)*X(1,i);
    A(i*2,10) = x(2,i)*X(2,i);
    A(i*2,11) = x(2,i)*X(3,i);
    A(i*2,12) = x(2,i);
end
[U,S,V] = svd(A);
h = V(:,12);
P = zeros(3,4);
for i = 1:3
    P(i,:) = h(i*4-3:i*4);
end
%disp(A*h)
P = P * sign(det(P(1:3,1:3)));
end