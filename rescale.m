function out = rescale(in,minval,maxval)
%rescales data to required max and min values
out = in - min(in(:));
out = (out/range(out(:)))*(maxval-minval);
out = out + minval;
end