 % Create a logical image of a ring with specified
% inner diameter, outer diameter center, and image size.
% First create the image.
imageSizeX = 640;
imageSizeY = 480;
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
phaseImage = zeros(size(columnsInImage));
phaseImage(100,200) = 30;phaseImage(400,100) = 20;%manually create two point sources
phaseImage(300,400) = 10;
%the code below is to find the coordinates of the point created manually
hLocalMax = vision.LocalMaximaFinder;
      hLocalMax.MaximumNumLocalMaxima = 3;%TODO: make this automatic int the future
      hLocalMax.NeighborhoodSize = [5 5];
      hLocalMax.Threshold = 0.3*max(max(phaseImage));

      location = step(hLocalMax, phaseImage)
% Next create the circle in the image.

%initialize some values
ringPixels = zeros(size(columnsInImage));
for i = 1:size(location,1)%adapts to the number of local maxima
    innerRadius = 35;
    outerRadius = 45;
    centerX = location(i,1);
    centerY = location(i,2);
    array2D = (int16(rowsInImage) - int16(centerY)).^2 ...
    + (int16(columnsInImage) - int16(centerX)).^2;
    k = 1;
    while 1  
        ringPixels = ringPixels+ (array2D >= innerRadius.^2 & array2D <= outerRadius.^2);
        imagesc(ringPixels)
        if(phaseImage(centerY,centerX)-2*pi*k<=0)
            break;
        end
        innerRadius = outerRadius+20;
        outerRadius = outerRadius+40-exp(1)^(-(k-5)^2/(2*4))*20;%the 20 is a factor to amplify the gaussian function effect
        k = k+1;
    end
end
imagesc(ringPixels);colormap(gray(256))
title('final wrapped phase information (reverse process)');
figure;imagesc(phaseImage);
hold on;plot(200,100,'ow');plot(100,400,'ow');plot(400,300,'ow');
title('original unwrapped phase information with point sources highlighted')
colormap(gray(256))
%%

unwrapped = do_all_rows(ringPixels*255);
BW = imregionalmax(unwrapped);
%figure;imshow(BW);
unwrapped1 = unwrapped .* BW;
unwrapped1 = imhmax(unwrapped1,max(max(unwrapped1)-0.001));%this thresholds a second time to clear the image completely

CPL =0.01;%10 mm
alpha = 36;%degrees
WL = 650*10^-9;%wave length
RI = unwrapped1 * WL/(cos(alpha/2))/CPL;
figure;
a = subplot(3,2,[1 ; 4]);imagesc(ringPixels);title("original");colormap(a, gray);
subplot(3,2,5);
mesh(unwrapped);title("mathematical unwrapping");colormap default;
subplot(3,2,6);mesh(RI);title("point source refractive index modification");