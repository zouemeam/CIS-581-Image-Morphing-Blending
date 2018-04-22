function indexes = getIndexes(mask, targetH, targetW, offsetX, offsetY)
%% Enter Your Code Here

[maskR, maskC]=size(mask);%find size of mask

indexes=zeros(targetH+2*maskR, targetW+2*maskC);%preallocate return varibale

startR=maskR+offsetY+1;%define start and finish row and column of mask in indexes 
finishR=startR+maskR-1;
startC=maskC+offsetX+1;
finishC=startC+maskC-1;

indexes(startR:finishR, startC:finishC)=mask;%place mask on indexes

indexes=indexes(maskR+1:maskR+targetH,maskC+1:maskC+targetW);%resize indexes to the size of target 

k=1;%counter

%going through each pixel and set the identity of non zero pixel
for i=1:targetH
    for j=1:targetW
        if indexes(i,j)==1
            indexes(i,j)=k;
            k=k+1;
        end
    end
end

end