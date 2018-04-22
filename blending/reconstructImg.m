function resultImg = reconstructImg(indexes, red, green, blue, targetImg)
%% Enter Your Code Here
[colInd,rowInd]=find(indexes'>0);%find col and row indexes of interest pixels in indexes
numPixel=size(rowInd ,1);%find number of interest pixels 
for i=1:numPixel%pasting calcualated pixel colors back into target image
    targetImg(rowInd(i),colInd(i),1)=red(1,i);
    targetImg(rowInd(i),colInd(i),2)=green(1,i);
    targetImg(rowInd(i),colInd(i),3)=blue(1,i);
end
resultImg=targetImg;

end