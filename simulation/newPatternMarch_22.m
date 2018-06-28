clc;clear all;
image  = imread('fringe pattern .png');
image  = im2double(image);
normalized = (image  - min(image(:)))/(max(image(:)) - min(image(:)));
original = normalized;
newMatrix = zeros(500,500); % all zero matrix
newMatrix(50:449,50:449) = original; % oldMatrix is a, newMatrix is b
imagesc(newMatrix);colormap gray
I2  = normalized/3;
newInterference = zeros(size(newMatrix));
newInterference(1:size(I2,1),1:size(I2,2)) = I2;
x =1;y = 1;
for i = 1:2
rx = (size(I2,1)-0).*rand(1,1);
rx = int64(rx);
ry = (size(I2,2)-0).*rand(1,1);
ry = int64(ry);
G = circshift(newInterference,[rx,ry]);
newMatrix  = newMatrix+G;
end
figure;
subplot(1,2,1);
imagesc(newMatrix);colormap(gray);title("randomized interference");
subplot(1,2,2);
imagesc(original);colormap(gray);title("original");
%%
img = normalized;
figure;
h_im = imshow(img);
% 3) Create an ellipse defining a ROI:
e = imellipse(gca,[21 23 358 355]);
position = wait(e);
% 4) Create a mask from the ellipse:
BW = createMask(e,h_im);
% 4a) (For color images only) Augment the mask to three channels:
% 5) Use logical indexing to set area outside of ROI to zero:
ROI = img;
ROI(BW == 0) = 0;
% 6) Display extracted portion:
figure, imshow(ROI);
close all;
figure;
h_im2 = imshow(img);
e2 = imellipse(gca,[73 69 259 264]);
position = wait(e2);
BW = createMask(e2,h_im2);
ROI2 = img;
ROI2(BW == 0) = 0;
figure, imshow(ROI2);
close all;
%%%%%%%%
%CROPPING DONE 
%%%%%%%%%
for i = 1:2
rx = (100-0).*rand(1,1);
rx = int64(rx);
ry = (100-0).*rand(1,1);
ry = int64(ry);
G = circshift(ROI2,[rx,ry]);
ROI  = ROI+G/3;
end
G = circshift(ROI2,[-60,-80]);
ROI  = ROI+G/3;
figure;
subplot(1,2,1);
imagesc(ROI);colormap(gray);title("randomized interference");
subplot(1,2,2);
imagesc(original);colormap(gray);title("original");

