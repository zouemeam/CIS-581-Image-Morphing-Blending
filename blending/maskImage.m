function mask = maskImage(Img)
%% Enter Your Code Here
imshow(Img);%display image
h=imfreehand(gca); %define area of interest using imfreehand
[row, col,~]=size(Img); %find size of source image 
mask = zeros(row, col); %create mask the same size as source image 
mask(h.createMask)=1; %set selected area to 1
mask=logical(mask); %convert result to logical 

end

