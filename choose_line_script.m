im = imread('six_circles_one_Overlap.tif');
im = im(:,:,1);
A = double(im)';
figure(1), imagesc(A);colormap('Gray');
p = ginput(2)
figure(1);hold all; plot(p(:,1),p(:,2),'ro');
N=max(abs(p(1,1)-p(2,1)),abs(p(2,1)-p(2,2)));
Lx=linspace(p(1,1),p(2,1),N);
Ly=linspace(p(1,2),p(2,2),N);
figure(1);hold all; plot(Lx,Ly,'r');
Lx2=uint64(floor(Lx));
Ly2=uint64(floor(Ly));
R = size(A,1);
C= size(A,2);%columns

CS1=A(sub2ind([C,R],Lx2,Ly2));
nCS1=[1:length(CS1)];
figure;plot(nCS1,CS1);

unwrapped = do_all_rows(CS1);
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
subplot(3,2,[5 6]);plot(RI);
