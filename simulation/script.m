clc
close all
clear all
format long
w = 0.015;% radius of aperture
start = -2;
stop = 2;
G = generateMatrix(start,stop,w);
G2 = circshift(G,[-400,-400]);
G3 = circshift(G,[400,400]);
G4 = circshift(G,[-400,400]);
G5 = circshift(G,[400,-400]);
Gfinal  = G+G2+G3+G4+G5;
%Gfinal = imfuse(G,G2,'blend','Scaling','joint');
%Gfinal = imfuse(Gfinal,G3,'blend','Scaling','joint');
%Gfinal = imfuse(Gfinal,G4,'blend','Scaling','joint');
%Gfinal = imfuse(Gfinal,G5,'blend','Scaling','joint');

figure(2)
imagesc(imadjust(Gfinal, [0;.085],[0;1]));
title('Fraunhofer Airy pattern','fontsize',14)
colormap gray; colorbar; axis equal;