function [H2to1] = computeH_norm(x1, x2)
N = length(x1);
%% Compute centroids of the points
%polyin1 = polyshape(x1(:,1),x1(:,2));
%polyin2 = polyshape(x2(:,1),x2(:,2));
%[centroid1x, centroid1y] = centroid(polyin1);
%[centroid2x, centroid2y] = centroid(polyin2);
centroid1x = mean(x1(:,1));
centroid1y = mean(x1(:,2));
centroid2x = mean(x2(:,1));
centroid2y = mean(x2(:,2));
%% Shift the origin of the points to the centroid
x1x = x1(:,1) - centroid1x;
x1y = x1(:,2) - centroid1y;
x11 = [x1x,x1y];
x2x = x2(:,1) - centroid2x;
x2y = x2(:,2) - centroid2y;
x22 = [x2x,x2y];

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
total1 = 0;
total2 = 0;

for i = 1:N
    total1 = total1 + sqrt(x11(N,1)^2 + x11(N,2)^2);
    total2 = total2 + sqrt(x22(N,1)^2 + x22(N,2)^2);
end
ave1 = total1 / N;
ave2 = total2 / N;
ratio1 = sqrt(2) / ave1;
ratio2 = sqrt(2) / ave2;

x11 = x11 * ratio1;
x22 = x22 * ratio2;
%% similarity transform 1
T1 = computeH( x11, x1 );

%% similarity transform 2
T2 = computeH( x22, x2 );

%% Compute Homography
H = computeH(x11,x22);
%% Denormalization
%H2to1 = computeH(x1,x2);
%H2to1 = computeH(x11,x22);
H2to1 = inv(T1)*H*T2;