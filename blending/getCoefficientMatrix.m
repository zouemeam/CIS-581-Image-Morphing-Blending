function coeffA = getCoefficientMatrix(indexes)
%% Enter Your Code Here
tic
[colInd,rowInd]=find(indexes'>0);%find row and col index of non-zero pixel
toc
[rsize, csize]=size(indexes);
coeffA=zeros(size(rowInd,1),size(rowInd,1));%preallocating return variable

for i=1:size(rowInd,1)%iterate through each non-zero pixel 
    coeffA(i,i)=4;%check pixel's neighbors and set their value on the matrix accordingly
    A=0;B=0;C=0;D=0;
    if (rowInd(i)+1)<=rsize
    A=indexes(rowInd(i)+1,colInd(i));
    end
    if (rowInd(i)-1)>=1
    B=indexes(rowInd(i)-1,colInd(i));
    end
    if (colInd(i)+1)<=csize
    C=indexes(rowInd(i),colInd(i)+1);
    end
    if (colInd(i)-1)>=1
    D=indexes(rowInd(i),colInd(i)-1);
    end
    if A~=0
        coeffA(i,A)=-1;
    end
    if B~=0
        coeffA(i,B)=-1;
    end
    if C~=0
        coeffA(i,C)=-1;
    end
    if D~=0
        coeffA(i,D)=-1;
    end
end


end
