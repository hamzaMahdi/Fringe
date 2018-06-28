function [phase,phase1,combined]  = countPhase(wrapped)
phase= zeros(size(wrapped));
phase1= zeros(size(wrapped));
combined= zeros(size(wrapped));

[pks,locs] = findpeaks(wrapped,'MinPeakHeight',4);
for i = 1:ceil(size(wrapped,2))
   for j = 1:size(locs,2)
       if locs(j) == i
        for k=floor(size(wrapped,2)):-1:i
           phase(k) = phase(k)+2*pi;
        end
       end 
   end 
    
end
for i = ceil(size(wrapped,2)): -1:1
   for j = 1:size(locs,2)
       if locs(j) == i
        for k=i:-1:1
           phase1(k) = phase1(k)+2*pi;
        end
       end
   end
    
end
combined  = phase;
%disp(size(phase));disp(size(phase1));disp(size(combined));
for i = 1:floor(size(wrapped,2))
    if phase(i) == phase1(i)
       combined(i:end) = phase1(i:end);
       break;
    end
    
end
%phase  = wrapped;
end