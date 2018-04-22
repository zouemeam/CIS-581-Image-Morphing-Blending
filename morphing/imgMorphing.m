 
im1=imread('trump1.jpg');%desired source image
im2=imread('putin.jpg');%desired target image
[im1_pts, im2_pts]=click_correspondences(im1, im2);%define correspondence points 
warp_frac=0:0.0167 :1;%defining increments of warp parameter
dissolve_frac=0:0.0167:1;%defining increments of dissolve parameter 
morphedim=morph_tri(im1, im2, im1_pts, im2_pts, warp_frac, dissolve_frac);%compute all frames of the video
videoCreation(morphedim);%generate video
 