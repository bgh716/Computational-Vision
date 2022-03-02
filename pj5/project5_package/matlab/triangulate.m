function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
N = length(pts1(:,1));
pts3d = zeros(N,3);
for i = 1:N
    %A = zeros(4,4,4);
    %max = 0;
    %best = zeros(4,1);
    %for j =1:4
    %    A(1,:,j) = pts1(i,2)*P1(3,:) - P1(2,:);
    %    A(2,:,j) = P1(1,:) - pts1(i,1)*P1(3,:);
    %    A(3,:,j) = pts2(i,2)*P2(3,:,j) - P2(2,:,j);
    %    A(4,:,j) = P2(1,:,j) - pts2(i,1)*P2(3,:,j);
    %    [U,S,V] = svd(A(:,:,j));
    %    line = V(:,4)/V(4,4);
    %    if line(3) > max
    %        max = line(3);
    %        best = line;
    %    end
    %end
    %pts3d(i,:) = best(1:3);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    A = zeros(4,4);
    A(1,:) = pts1(i,2)*P1(3,:) - P1(2,:);
    A(2,:) = P1(1,:) - pts1(i,1)*P1(3,:);
    A(3,:) = pts2(i,2)*P2(3,:) - P2(2,:);
    A(4,:) = P2(1,:) - pts2(i,1)*P2(3,:);
    [U,S,V] = svd(A);
    line = V(:,4)/V(4,4);
    pts3d(i,:) = line(1:3);
end
end