function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
%H_template_to_img = inv(H2to1);
composite_img = img;
%% Create mask of same size as template
mask = ones(size(template,1), size(template,2));
%% Warp mask by appropriate homography
mask_warped = warpH(mask, H2to1, size(img));
%imshow(mask_warped)
%% Warp template by appropriate homography
temp_warped = warpH(template, H2to1, size(img));
%imshow(temp_warped)
%imshow(composite_img)
%% Use mask to combine the warped template and the image
for i = 1:size(img,1)
    for j=1:size(img,2)
        if mask_warped(i,j) > 0
            composite_img(i,j,:) = temp_warped(i,j,:);
        end
    end
end
%imshow(composite_img)
end