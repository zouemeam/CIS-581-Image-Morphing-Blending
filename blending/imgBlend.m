img=imread('ufosource.jpg'); %source image
targetImg=imread('skyBackground.jpg');%target image
mask=maskImage(img);%define mask
offsetX=210;%define offsets
offsetY=105;
resultImg=seamlessCloningPoisson(img, targetImg, mask, offsetX, offsetY);%compute result image 
imagesc(resultImg);%show result image