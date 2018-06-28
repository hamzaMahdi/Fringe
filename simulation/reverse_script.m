 % Create a logical image of a ring with specified
% inner diameter, outer diameter center, and image size.
% First create the image.
imageSizeX = 640;
imageSizeY = 480;
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
phaseImage = zeros(size(columnsInImage));
phaseImage(100,200) = 40;phaseImage(400,100) = 40;%manually create two point sources
%the code below is to find the coordinates of the point created manually
hLocalMax = vision.LocalMaximaFinder;
      hLocalMax.MaximumNumLocalMaxima = 2;%TODO: make this automatic int the future
      hLocalMax.NeighborhoodSize = [5 5];
      hLocalMax.Threshold = 0.7*max(max(phaseImage));

      location = step(hLocalMax, phaseImage)
% Next create the circle in the image.

%initialize some values
innerRadius = 20;
outerRadius = 40;
ringPixels = zeros(size(columnsInImage));
for i = 1:size(location,1)%adapts to the number of local maxima
    centerX = location(i,1);
    centerY = location(i,2);
    array2D = (int16(rowsInImage) - int16(centerY)).^2 ...
    + (int16(columnsInImage) - int16(centerX)).^2;
    while 1
        ringPixels = ringPixels+ (array2D >= innerRadius.^2 & array2D <= outerRadius.^2);
        if(phaseImage(centerX,centerY)-2*pi<=0)
            break;
        end
        innerRadius = outerRadius+20;
        outerRadius = outerRadius+40;
    end
end
centerX = 320;
centerY = 240;


% ringPixels is a 2D "logical" array.
% Now, display it.
ringPixels = ringPixels*256;%increase contrast
image(ringPixels) ;
colormap([0 0 0; 1 1 1]);
title('refractive index modification sample', 'FontSize', 25);