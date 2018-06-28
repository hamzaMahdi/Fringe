im = imread('six_circles_one_Overlap.tif');
im = im(:,:,1);
im = double(im)';
[r,c] = size(im);
im = im(100:600,100:600);%this makes it square 
windowlength = 5;
for i = 1:length(im)-1-windowlength
    for k = 1:length(im)-1-windowlength
       window_data = im(i:i+windowlength,k:k+windowlength); 
       mean(i,k) = mean2(window_data);
    end
end
%imshow(diagMat);

totals  = zeros(2*length(mean)-1);
k = 1;%counter
original = zeros(1439);
for i = -floor((2*length(mean)-1)/2):floor((2*length(mean)-1)/2)
   temp = diag(mean,i);
   data = [temp' nan(1,abs(size(totals,2)-size(temp,1)))];
   [phase, phase1,combined] = countPhase(data);

    totals(k,:)= [combined]; %zeros(1,abs(size(totals,2)-size(phase,1)))];
    total(k,:) = data; 
    k = k+1;
end
    original = inverseDiag(totals,mean);


figure;
subplot(1,3,1)
imagesc(mean);colormap(gray);title("image windowed");
subplot(1,3,3)
imagesc(totals);title("unwrapped diagonal matrix");
subplot(1,3,2)
imagesc(total);title("diagonal matrix");