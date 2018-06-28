im = imread('pattern.png');
im = im(:,:,1);
im = double(im);
row = floor(size(im,1)/2);%middle row
var = im(row,:);%extract all values of that row 
subplot(5,2,[1;3])
imagesc(im);colormap(gray);
title('original image')
subplot(5,2,2)
plot(var);
title('extracted middle row')
[var, outliers_idx] = outliers(var, 20);%remove outliers
var(find(isnan(var)))=[];
subplot(5,2,4);plot(var);title('outliers removed');
%check this it might not be correct 
%var1 = cos(var);%wrap the values
var1 = sgolayfilt(var,1,7);
subplot(5,2,[5 6]);plot(var1);title('savtzy-golay filter');
var1 = -var1;
var1 = var1+abs(min(var1));
subplot(5,2,[7 8]);plot(var1);title('inverted values');
%%
%phase = unwrap(var1(:));
phase = countPhase(var1);
subplot(5,2,[9 10])
plot(phase);
title('unwrapped values')