clc;clear all;close all;
% load('pattern.mat');
% [D_sub,rect_D] = imcrop(D_prime);
% D_prime = padarray(D_prime,[700 700],0,'both');
% D1 = circshift(D_prime,[-530,100]);
% D2 = circshift(D_prime,[-350,100]);
% D3 = circshift(D_prime,[530,75]);
% D4 = circshift(D_prime,[300,100]);
% D5 = circshift(D_prime,[0,0]);
% D6 = circshift(D_prime,[0,150]);
% D = D1+D2+D3+D4+D5+D6;
D = imread('six_circles_noOverlap.tif');
D = D(:,:,1);
D = double(D)';
[D_sub,rect_D] = imcrop(D);
figure;imagesc(D);colormap gray;

crr = normxcorr2(D_sub,D);%D_prime is template
%[ssr,snd] = max(abs(crr(:)));%maximum
% [ypeak,xpeak] = ind2sub(size(crr),snd(1));
% corr_offset = [(xpeak-size(D_sub,2)) 
%                (ypeak-size(D_sub,1))];


%computer vision toolbox
hLocalMax = vision.LocalMaximaFinder;
      hLocalMax.MaximumNumLocalMaxima = 6;
      hLocalMax.NeighborhoodSize = [5 5];
      hLocalMax.Threshold = 0.9;

      location = step(hLocalMax, crr)

           
figure
plot(crr(:))
title('Cross-Correlation')
hold on
plot(snd,ssr,'or')
hold off
text(snd*1.05,ssr,'Maximum')
