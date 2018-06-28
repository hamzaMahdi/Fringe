function phase = findPhase(data)
t= [1:size(data,2)];                                                % Time Vector
s  = data;                                                 % Signal Vector
Ts = mean(diff(t));                                         % Sampling Time
Fs = 1/Ts;                                                  % Sampling Frequency
Fn = Fs/2;                                                  % Nyquist Frequency
L  = length(s);
fts = fft(s)/L;                                             % Normalised Fourier Transform
Fv = linspace(0, 1, fix(L/2)+1)*Fn;                         % Frequency Vector
Iv = 1:length(Fv);                                          % Index Vector
amp_fts = abs(fts(Iv))*2;                                   % Spectrum Amplitude
phase = angle(fts(Iv));                                   % Spectrum Phase
end