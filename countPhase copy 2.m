function phase  = countPhase(wrapped)
phase= zeros(size(wrapped));
[pks,locs] = findpeaks(wrapped,'MinPeakHeight',4);
for i = 1:floor(size(wrapped,2)/2)
   for j = 1:size(locs,2)
       if locs(j) == i
        for k=floor(size(wrapped,2)/2):-1:i
           phase(k) = phase(k)+2*pi;
        end
       end 
   end 
    
end
for i = ceil(size(wrapped,2)/2)+1: size(wrapped,2)
   for j = 1:size(locs,2)
       if locs(j) == i
        for k=i:-1:ceil(size(wrapped,2)/2)+1
           phase(k) = phase(k)+2*pi;
        end
       end
   end
    
end
%phase  = wrapped;
end