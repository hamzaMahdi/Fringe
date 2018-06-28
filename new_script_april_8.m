im = imread('six_circles_one_Overlap.tif');
im = im(:,:,1);
im = double(im)';
unwrapped = do_all_rows(im);
BW = imregionalmax(unwrapped);
%figure;imshow(BW);
unwrapped1 = unwrapped .* BW;
unwrapped1 = imhmax(unwrapped1,max(max(unwrapped1)-0.001));%this thresholds a second time to clear the image completely

CPL =0.01;%10 mm
alpha = 36;%degrees
WL = 650*10^-9;%wave length
RI = unwrapped1 * WL/(cos(alpha/2))/CPL;
figure;
a = subplot(3,2,[1 ; 4]);imagesc(im);title("original");colormap(a, gray);
subplot(3,2,5);
mesh(unwrapped);title("mathematical unwrapping");colormap default;
subplot(3,2,6);mesh(RI);title("point source refractive index modification");