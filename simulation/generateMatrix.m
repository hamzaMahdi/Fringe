function G = generateMatrix(start,stop,w)
midPoint = (start + stop )/2;
stepSize = (1/(2^9 - 1));
x = start:stepSize:stop;
y = x;
[X, Y] = meshgrid(x,y);
E = zeros(length(x), length(y));
E(sqrt((X - midPoint).^2 + (Y - midPoint).^2) <= w) = 1;
G = abs(fftshift(fft2(E))).^2;
G = G/max(max(G));

end