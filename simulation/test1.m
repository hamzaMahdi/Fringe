%Unwrap the image using the Itoh algorithm: the first method is performed
%by first sequentially unwrapping the all rows, one at a time.
image1_wrapped = ringPixels*256;
N = size(image1_wrapped,1);
image1_unwrapped = image1_wrapped;
for i=1:N
 image1_unwrapped(i,:) = unwrap(image1_unwrapped(i,:));
end
%Then sequentially unwrap all the columns one at a time
for i=1:N
 image1_unwrapped(:,i) = unwrap(image1_unwrapped(:,i));
end
figure, colormap(gray(256)), imagesc(image1_unwrapped)
title('Unwrapped phase image using the Itoh algorithm: the first method')
xlabel('Pixels'), ylabel('Pixels')
figure
surf(image1_unwrapped,'FaceColor','interp', 'EdgeColor','none',...
'FaceLighting','phong')
view(-30,30), camlight left, axis tight
title('Unwrapped phase image using the Itoh algorithm: the first method')
xlabel('Pixels'), ylabel('Pixels'), zlabel('Phase in radians')