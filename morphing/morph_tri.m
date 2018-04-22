function [morphed_im] = morph_tri(im1, im2, im1_pts, im2_pts, warp_frac, dissolve_frac)
%MORPH_TRI Image morphing via Triangulation
%	Input im1: source image
%	Input im2: target image
%	Input im1_pts: correspondences coordiantes in the source image
%	Input im2_pts: correspondences coordiantes in the target image
%	Input warp_frac: a vector contains warping parameters
%	Input dissolve_frac: a vector contains cross dissolve parameters
% 
%	Output morphed_im: a set of morphed images obtained from different warp and dissolve parameters

% Helpful functions: delaunay, tsearchn
numFrame=length(warp_frac); %find the number of desired frames based on size of warping vector
morphed_im=cell(numFrame,1); %preallocating return variable
assert(size(im1_pts,1)==size(im2_pts,1)); %check number of correspondence points are equal
assert(length(warp_frac)==length(dissolve_frac))%check size of warping and dissolve vectors are the same 

avgpts=0.5*im1_pts+0.5*im2_pts; %compute intermediate control points
tri=delaunay(avgpts(:,1), avgpts(:,2)); %perform delaunay triangulation using intermediate control points

[row1, col1, ~]=size(im1);%find size of im1
[row2, col2, ~]=size(im2);%find size of im2
row=max(row1, row2);%find largest dimension of input images
col=max(col1, col2);
im1=padarray(im1, [row-row1, col-col1], 'replicate', 'post');%pad input images so they are same size
im2=padarray(im2, [row-row2, col-col2], 'replicate', 'post');

for i=1:length(warp_frac)%find intermediate frames by iteration 
    morphed_im{i}=warp(tri,im1, im1_pts,im2,im2_pts,warp_frac(i),dissolve_frac(i));
end

end

