function [im1_pts, im2_pts] = click_correspondences(im1, im2)
%CLICK_CORRESPONDENCES Find and return point correspondences between images
%   Input im1: target image
%	Input im2: source image
%	Output im1_pts: correspondence-coordiantes in the target image
%	Output im2_pts: correspondence-coordiantes in the source image

%% Your code goes here
% You can use built-in functions such as cpselect to manually select the
% correspondences

[row1, col1, ~]=size(im1);%find size of source image
[row2, col2, ~]=size(im2);%find size of target image 
row=max(row1, row2);%find max row dimension out of two images
col=max(col1, col2);%find max column dimension out of two images
im1padded=padarray(im1, [row-row1, col-col1], 'replicate', 'post');%pad image if they are too small
im2padded=padarray(im2, [row-row2, col-col2], 'replicate', 'post');
[im1_pts, im2_pts]=cpselect(im1padded, im2padded,'Wait',true  );%define correspondence points
%add corner points 
im1_pts=[im1_pts; 0,0; 0,col; row,col; row,0;];
im2_pts=[im2_pts; 0,0; 0,col; row,col; row,0;];

end