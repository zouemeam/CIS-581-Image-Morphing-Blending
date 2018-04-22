function resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask, offsetX, offsetY)
%% Enter Your Code Here
redMapTarget=double(targetImg(:,:,1));%extract red color channel from target image
greenMapTarget=double(targetImg(:,:,2));%extrac green color channel from target image
blueMapTarget=double(targetImg(:,:,3));%extract blue color channel from target image
redMapS=double(sourceImg(:,:,1));%extract red color channel from source image
greenMapS=double(sourceImg(:,:,2));%extract green color channel from source image
blueMapS=double(sourceImg(:,:,3));%extract blue color channel from source image
[targetH,targetW,~]=size(targetImg);%find size of target image 
indexes=getIndexes(mask,targetH, targetW, offsetX, offsetY);%compute indexes

coeffA = getCoefficientMatrix(indexes);%compute coefficient matrix 
redSol = getSolutionVect(indexes, redMapS, redMapTarget, offsetX, offsetY);%find solution vector for each color channel
greenSol=getSolutionVect(indexes, greenMapS, greenMapTarget, offsetX, offsetY);
blueSol=getSolutionVect(indexes, blueMapS, blueMapTarget, offsetX, offsetY);

red=sparse(coeffA)\(redSol');%solve for each color channel 
green=sparse(coeffA)\(greenSol');
blue=sparse(coeffA)\(blueSol');

resultImg=reconstructImg(indexes, red', green', blue', targetImg);%reconstruct image


end