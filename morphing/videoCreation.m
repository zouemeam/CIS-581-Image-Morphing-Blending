function videoCreation(morphed_im)
%VideoCreation
%INPUT morphed_im, cell containing all frames of the video

video = VideoWriter('TrumpPutin.avi');%create a videowriter object

for i=1:size(morphed_im)%add each frame to the video
    open(video);
    frame=morphed_im{i};
    writeVideo(video,frame);
end
close(video);
implay ('TrumpPutin.avi');%play video 
end