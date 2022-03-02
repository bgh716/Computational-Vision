clear all;
plane = load("../data/PnP.mat");
P = estimate_pose(plane.x, plane.X);
[K, R, t] = estimate_params(P);
N = size(plane.X,2);
projection = zeros(2,N);

for i = 1:N
    coord = ones(4,1);
    coord(1:3) = plane.X(:,i);
    coord = P*coord;
    coord = coord/coord(3);
    projection(:,i) = coord(1:2);
end

figure;
imshow(plane.image);
axis on
hold on;
plot(projection(1,:),projection(2,:),'go');
plot(plane.x(1,:),plane.x(2,:),'y.');

M = size(plane.cad.vertices,1);
rotated = zeros(M,3);
for i = 1:M
    rotated(i,:) = R*plane.cad.vertices(i,:).';
end
%figure;
%trimesh(plane.cad.faces,plane.cad.vertices(:,1),plane.cad.vertices(:,2),plane.cad.vertices(:,3))
figure;
trimesh(plane.cad.faces,rotated(:,1),rotated(:,2),rotated(:,3))


in = K;
ex = zeros(3,4);
ex(:,1:3) = R;
ex(:,4) = t;
newP = in*ex;
cad_projection = zeros(2,M);
for i =1:M
    coord = ones(4,1);
    coord(1:3) = plane.cad.vertices(i,:);
    coord = P*coord;
    coord = coord/coord(3);
    cad_projection(:,i) = coord(1:2);
end
figure;
imshow(plane.image);
axis on
hold on;
patch(cad_projection(1,:),cad_projection(2,:),'red')