clc
close all
clear all
format long
w = 0.01;% radius of aperture
start = -2;
stop = 2;
midPoint = (start + stop )/2;
stepSize = (1/(2^9 - 1));
x = start:stepSize:stop;
y = x;
[X, Y] = meshgrid(x,y);
E = zeros(length(x), length(y));
E(sqrt((X - midPoint).^2 + (Y - midPoint).^2) <= w) = 1;
G = abs(fftshift(fft2(E))).^2;
G = G/max(max(G));
figure(2)
imagesc(imadjust(G, [0;.085],[0;1]));
title('Fraunhofer Diffraction of circular aperture','fontsize',14)
colormap gray; colorbar; axis equal;