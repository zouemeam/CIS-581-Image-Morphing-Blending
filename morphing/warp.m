function[warped]=warp(tri,im1, img1_pts,im2,img2_pts,warp_frac,dissolve_frac)
%WARP: create warped image given triangulation, warping and dissolving
%parameters
%Input tri: delaunay triangulation 
%Input im1: source image
%Input img1_pts: correspondence coordinates in the source image
%Input im2: target image 
%Input img2_pts: correspondence coordinates in the target image
%Input warp_frac: warping parameter 
%Input dissolve_frac: dissolving parameter 
%Output warped: result of image morphing 

warped=(1-dissolve_frac).*im1+(dissolve_frac).*im2;%preallocate return variable using only dissolve parameter
[row,col,~]=size(im1);%find size of source image
inter=(1-warp_frac).*img1_pts+warp_frac.*img2_pts;%find control points using correspondence points and warp parameter
numT=size(tri,1);%find number of triangles in triangulation

matrix=ones(col,row); %create matrix with number of rows as columns of image and number of columns as rows of image (needed to transform from image frame to x,y frame)
[X,Y]=find(matrix==1); %find pixel location in x,y frame from left to right and then up to down
T=tsearchn(inter,tri,[Y,X]); %find corresponding pixel in triangulation from left to right and then up to down

current=zeros(3,3,numT);%transformation matrix from bary to cartesian in current frame
Source=zeros(3,3,numT);%transformation matrix from bary to cartesian in source image
Target=zeros(3,3,numT);%transformation matrix from bary to cartesian in target image
%% Finding corresponding barycentric coordinates corresponding pixel locations in source and target 
for i=1:numT %iterate through each triangle
    vertices = tri(i,:); %find vertices of each triangle
    col1 = [inter(vertices(1),:) 1]'; %find each column in transformation matrix
    col2 = [inter(vertices(2),:) 1]';
    col3 = [inter(vertices(3),:) 1]';
    current(:,:,i) = [round(col1) round(col2) round(col3)];%define transformation matrix
    
    col1 = [img1_pts(vertices(1),:) 1]'; %find each column in transformation matrix
    col2 = [img1_pts(vertices(2),:) 1]';
    col3 = [img1_pts(vertices(3),:) 1]';
    Source(:,:,i) = [round(col1) round(col2) round(col3)];%define transformation matrix
    
    col1 = [img2_pts(vertices(1),:) 1]'; %find each column in transformation matrix
    col2 = [img2_pts(vertices(2),:) 1]';
    col3 = [img2_pts(vertices(3),:) 1]';
    Target(:,:,i) = [round(col1) round(col2) round(col3)];%define transformation matrix
end

pixelTriInd = find(T>0); %find index of pixel in result of tsearchn that have a valid triangulation 

pixelCurrent=zeros(3,length(pixelTriInd));%create matrix to store curret frame pixel locations  
baryCurrent=zeros(3,length(pixelTriInd));%create matrix to store current frame pixel locations in bary
xySource=zeros(3,length(pixelTriInd));%create matrix to store pixel location in source
xyTarget=zeros(3,length(pixelTriInd));%create matrix to store pixel location in target

for i = 1:length(pixelTriInd)%iterate through each pixel
    pixelCurrent(:,i) = [Y(pixelTriInd(i)); X(pixelTriInd(i)); 1]; %find current frame pixel location
    baryCurrent(:,i) = current(:,:,T(pixelTriInd(i))) \ pixelCurrent(:,i);%find current frame bary coordinate
    xySource(:,i)=round(Source(:,:,T(pixelTriInd(i))) * baryCurrent(:,i));%find corresponding pixel location in source image 
    xyTarget(:,i)=round(Target(:,:,T(pixelTriInd(i))) * baryCurrent(:,i));%find corresponding pixel location in target image
end
%% Check pixel locations do not exceed bound
xSource=xySource(1,:)./xySource(3,:);%compute corresponding pixel x coordinate in source image
ySource=xySource(2,:)./xySource(3,:);%compute corresponding pixel y coordinate in source image
xSource(xSource < 1) = 1;%any pixel x coordinate less than 1 becomes 1
ySource(ySource < 1) = 1;%any pixel y coordinate less than 1 becomes 1
xSource(xSource > col)=col;%also make sure x and y coordinates do not exceed max dimension
ySource(ySource > row)=row;


xTarget=xyTarget(1,:)./xyTarget(3,:);%compute corresponding pixel x coordinate in target image
yTarget=xyTarget(2,:)./xyTarget(3,:);%compute corresponding pixel y coordinate in target image
xTarget(xTarget < 1) = 1;%any pixel x coordinate less than 1 becomes 1
yTarget(yTarget < 1) = 1;%any pixel y coordinate less than 1 becomes 1
xTarget(xTarget >col)=col;%also make sure x and y coordinates do not exceed max dimension
yTarget(yTarget >row)=row;
%% Dissolve 
for i = 1:size(pixelCurrent, 2)
    warped(pixelCurrent(2,i), pixelCurrent(1,i),:) = (1-dissolve_frac) .* im1(ySource(i), xSource(i),:) + (dissolve_frac) .* im2(yTarget(i), xTarget(i), :);
end

warped=warped(1:row,1:col,:); %crop image just in case the return is larger than input
    
end
