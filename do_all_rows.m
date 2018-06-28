function totals = do_all_rows(im)
row = size(im,1);
total = zeros(size(im));total1 = zeros(size(im));totals = zeros(size(im));
for i=1:row
var = im(i,:);%extract all values of that row 
% [var, outliers_idx] = outliers(var, 20);%remove outliers
% var(find(isnan(var)))=[];
var1 = sgolayfilt(var,1,7);
var1 = -var1;
var1 = var1+abs(min(var1));
[phase, phase1,combined] = countPhase(var1);
total(i,:) = [phase zeros(1,abs(size(total,2)-size(phase,2)))];
total1(i,:) = [phase1 zeros(1,abs(size(total1,2)-size(phase,2)))];
totals(i,:)= [combined zeros(1,abs(size(totals,2)-size(phase,2)))];
end

% subplot(2,2,[1;3]);
% imagesc(total);title("unwrapped phase (row wise)");
% colormap(gray);
% subplot(2,2,[2;4]);
% imagesc(total1);title("original");
% colormap(gray);

%