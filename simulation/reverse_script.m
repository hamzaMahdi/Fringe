%this script starts from a RI modification and produces wrapped phase then
%proceeds to unwrap the produced matrix and calculate the resultant RI
%modification in order to compare it to the original which enables
%determination of effectiveness of used unwrapping algorithm


%below are parameters used in the conversion from RI to unwrapped phase 
CPL =0.010000;%10 mm
alpha = 36.000;%degrees
WL = 650.0000*10^-9;%wave length

%unwrapped =  WL/(cos(alpha/2))/CPL/RI

% Create a logical image of a ring with specified
% inner diameter, outer diameter center, and image size.
% First create the image.
imageSizeX = 640;
imageSizeY = 480;
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
phaseImage = zeros(size(columnsInImage));
phaseImage(100,200) = 0.0030;phaseImage(400,100) =   0.0020;%manually create two point sources
phaseImage(300,400) =  9.8438e-04;
figure;imagesc(phaseImage);
phaseImage = phaseImage/( WL/(cos(alpha/2))/CPL);colormap gray
%%
phaseImage(phaseImage==Inf) = 0; %ensures zeroes stay as zeroes
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
figure;imagesc(ringPixels);colormap(gray(256))
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


RI = unwrapped1 * WL/(cos(alpha/2))/CPL;
figure;


imagesc(unwrapped);title("mathematical unwrapping");colormap default;
figure;mesh(RI);title("point source refractive index modification");