function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
c1 = -1 * ((K1*R1)^(-1)*(K1*t1));
c2 = -1 * ((K2*R2)^(-1)*(K2*t2));
depthM = zeros(size(dispM,1),size(dispM,2));
b = norm(c1-c2);
f = K1(1,1);
for i =1:size(dispM,1)
    for j =1:size(dispM,2)
        if dispM(i,j) == 0
            continue
        end
        depthM(i,j) = b * f/dispM(i,j);
    end
end
end