 % Create a logical image of a ring with specified
% inner diameter, outer diameter center, and image size.
% First create the image.
imageSizeX = 640;
imageSizeY = 480;
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% Next create the circle in the image.
centerX = 320;
centerY = 240;
innerRadius = 40;
outerRadius = 60;

innerRadius1 = 80;
outerRadius1 = 100;
array2D = (rowsInImage - centerY).^2 ...
    + (columnsInImage - centerX).^2;
ringPixels = (array2D >= innerRadius.^2 & array2D <= outerRadius.^2) ...
+ (array2D >= innerRadius1.^2 & array2D <= outerRadius1.^2);
% ringPixels is a 2D "logical" array.
% Now, display it.
ringPixels = ringPixels*256;%increase contrast
image(ringPixels) ;
colormap([0 0 0; 1 1 1]);
title('refractive index modification sample', 'FontSize', 25);