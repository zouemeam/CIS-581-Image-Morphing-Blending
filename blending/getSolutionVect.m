function solVectorb = getSolutionVect(indexes, source, target, offsetX, offsetY)
%% Enter Your Code Here
laplacian=[0,-1,0;
           -1,4,-1;
           0,-1,0;];%define laplacian matrix 
source= conv2(double(source),double(laplacian),'same');%convolve source with the laplacian matrix
[Rt,Ct]=size(indexes);%find size of indexes
[Rs,Cs]=size(source);%find size of source image

map=zeros(Rt+2*Rs, Ct+2*Cs);%preallocate a map that will contain laplacian and target image
startR=Rs+offsetY+1;%define start and finish row and column of laplacian in the target image
finishR=startR+Rs-1;
startC=Cs+offsetX+1;
finishC=startC+Cs-1;

map(startR:finishR, startC:finishC)=source;%place laplacian of source image into the map 
map=map(Rs+1:Rs+Rt,Cs+1:Cs+Ct);%make map the same size as target image
mask=indexes>0;%define a mask of 1 and 0 according to indexes
map=mask.*map;%filter out laplacian in the source image that is of no interest 
mask=~mask;%invert mask 
maptarget=double(mask).*double(target);%filter out target image pixels that are of no interest 
mapcombined=double(map)+double(maptarget);%combining filtered target image and laplacian 

[colInd,rowInd]=find(indexes'>0);%find col and row indexes for pixels of interest 

numPixel=size(rowInd ,1);%find the number of pixels 
solVectorb =zeros(1,numPixel);%preallocating return variable
for i=1:numPixel%looping through pixel selected for the mask
    A=-1;B=-1;C=-1;D=-1;
    if (rowInd(i)+1)<=Rt
    A=indexes(rowInd(i)+1,colInd(i));
    end
    if (rowInd(i)-1)>=1
    B=indexes(rowInd(i)-1,colInd(i));
    end
    if (colInd(i)+1)<=Ct
    C=indexes(rowInd(i),colInd(i)+1);
    end
    if (colInd(i)-1)>=1
    D=indexes(rowInd(i),colInd(i)-1);
    end
    val=mapcombined(rowInd(i),colInd(i));
    if A==0
        val=val+mapcombined(rowInd(i)+1,colInd(i));
    end
    if B==0
        val=val+mapcombined(rowInd(i)-1,colInd(i));
    end
    if C==0
        val=val+mapcombined(rowInd(i),colInd(i)+1);
    end
    if D==0
        val=val+mapcombined(rowInd(i),colInd(i)-1);
    end
    solVectorb(1,i)=val;%compute its corresponding value on the b solution vector 
end

end
