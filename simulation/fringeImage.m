clc;clear all;
image  = imread('fringe pattern .png');
image  = im2double(image);
normalized = (image  - min(image(:)))/(max(image(:)) - min(image(:)));
original = normalized;
%I = imcrop(normalized,[100 100 150 150]);
I2  = normalized/3;
newInterference = zeros(size(normalized));
newInterference(1:size(I2,1),1:size(I2,2)) = I2;
x =1;y = 1;
for i = 1:4
rx = (size(I2,1)-0).*rand(1,1);
rx = int64(rx);
ry = (size(I2,2)-0).*rand(1,1);
ry = int64(ry);
G = circshift(newInterference,[rx,ry]);
normalized  = normalized+G;
end
figure;
subplot(1,2,1);
imagesc(normalized);colormap(gray);title("randomized interference");
subplot(1,2,2);
imagesc(original);colormap(gray);title("original");
