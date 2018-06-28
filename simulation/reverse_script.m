 % Create a logical image of a ring with specified
% inner diameter, outer diameter center, and image size.
% First create the image.
imageSizeX = 640;
imageSizeY = 480;
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
phaseImage = zeros(size(columnsInImage));
phaseImage(100,200) = 10;phaseImage(400,100) = 20;%manually create two point sources
%the code below is to find the coordinates of the point created manually
hLocalMax = vision.LocalMaximaFinder;
      hLocalMax.MaximumNumLocalMaxima = 2;%TODO: make this automatic int the future
      hLocalMax.NeighborhoodSize = [5 5];
      hLocalMax.Threshold = 0.4*max(max(phaseImage));

      location = step(hLocalMax, phaseImage)
% Next create the circle in the image.

%initialize some values
innerRadius = 20;
outerRadius = 40;
ringPixels = zeros(size(columnsInImage));
for i = 1:size(location,1)%adapts to the number of local maxima
    innerRadius = 20;
    outerRadius = 40;
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
        outerRadius = outerRadius+40;
        k = k+1;
    end
end
imagesc(ringPixels);colormap gray;
