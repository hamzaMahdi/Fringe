function original = inverseDiag(totals,mean)
original = zeros(length(mean));
for i = 1:length(totals)
    temp = totals(i,1);
    k = 1;
    while(~isnan(temp)&&k<length(totals)&&length(mean)-i+k>0)
        original(length(mean)-i+k,k) = totals(i,k);
        k = k+1;
        if(k<length(totals)+1)
            temp  = totals(i,k);
        end
    end
end 
for i = floor(length(totals)/2):length(totals)
    temp = totals(i,1);
    k = 1;
    l = 1;
    while(~isnan(temp)&&k<length(totals))
        %if(length(mean)-i+k<1)
            original(l,k) = totals(i,k);
            l = l+1;
        %end
        k = k+1;
        if(k<length(totals)+1)
            temp  = totals(i,k);
        end
    end
end 
end