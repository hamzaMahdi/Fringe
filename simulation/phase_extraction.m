%% Developer
% *Donggyu Jang* , Dept. Physics and Photon Science, Gwangju Institute of
% Science and Technology, South Korea, 10/09/2015.
%% Function description
% *File Name*: phase_extraction.m
%%
% *Objective*: Phase extraction from the interferogram by following step:
% The FFT over the interferogram -> Shifting a positive side 
% peak on the frequency space to the center with removing other
% peaks.->Inverse FFT and phase extraction. [1]
%%
% *How to use 1*: _phase_extraction(data,mode)_ or
% _phase_extraction(data,mode,peak_width)_. Return: extracted phase in rad.
%%
% *How to use 2*: data is for interferogram image and mode is parameter determining operation mode.
% If the mode is set as 2, Automatic finding of side peak (containing phase shift information) in frequency space is done. (based on the condition 
% that number of of fringes is large enough so peaks in frequency space 
% are well separated) In this mode peak on top semicircle (in matrix 
% index order) of the frequency space except for left peak
% (for vertical fringe) is found. you can set side peak width
% in variable peak_width if default is not relevant for you.if the mode is set as other than 1, 
% peak is manually selected.
%%
% *List of user-defined parameters in function*: default_peak_width,
% separator (defines how much clean other peaks are cleared.)
%% Function definition
function F_angle = phase_extraction(varargin)
% Argument extraction.
default_peak_width = 30;
data = varargin{1}; mode = varargin{2}; % Data is interferogram image.

img_size = size(data);

% FFT Process and Shift of FFT matrix.
F_data = fft2(data); F_shift_data = fftshift(F_data);

% Data processing on Frequency space.
if (mode == 2)
    % setting width of side peak on frequency space.
    if (length(varargin) == 3)
        peak_width = varargin{3};
    else
        peak_width = default_peak_width;
    end
    % Copying top semicircle of the frequency space to include only one side peak for phase extraction. 
    separator = 10; % Defining copy-limit from center on frequency space to exclude DC and other side peak.
    F_copy_plane = zeros(img_size);
    % Copying top semicircle to copy-limit defined by separator.
    F_copy_plane(1:round(img_size(1)/2) - separator,:) = F_shift_data(1:round(img_size(1)/2) - separator,:);
    % Copying additional region to include right side peak for vertical fringe.
    F_copy_plane(round(img_size(1)/2) - separator + 1:round(img_size(1)/2) + separator,round(img_size(2)/2) + separator:img_size(2)) = F_shift_data(round(img_size(1)/2) - separator + 1:round(img_size(1)/2) + separator,round(img_size(2)/2) + separator:img_size(2));
    peak_value = max(max(abs(F_copy_plane))); [peak_row,peak_col,~] = find(abs(F_copy_plane) == peak_value); % Finding of peak location. 
    % Copying only selected region (peak) to the new clean matrix.
    F_only_peak = zeros(img_size);
    F_only_peak(peak_row - round(peak_width/2):peak_row + round(peak_width/2),peak_col - round(peak_width/2):peak_col + round(peak_width/2)) = F_copy_plane(peak_row - round(peak_width/2):peak_row + round(peak_width/2),peak_col - round(peak_width/2):peak_col + round(peak_width/2));
    F_shift_to_center = circshift(F_only_peak,[(round(img_size(1)/2) - peak_row) (round(img_size(2)/2) - peak_col)]);    
else
    figure; imagesc(log10(abs(F_shift_data)));  colormap('Gray');
    title('Select side peak for phase extraction by drawing rectanglar box.');    
    rect = getrect; % Selecting peak for phase extraction by drawing rectanglar box.
    rect = round(rect);
    % Copying only selected region (peak) to the new clean matrix.
    F_only_peak = zeros(img_size);
    F_only_peak(rect(2):rect(2) + rect(4),rect(1) : rect(1) + rect(3)) = F_shift_data(rect(2):rect(2) + rect(4),rect(1) : rect(1) + rect(3));
    peak_value = max(max(abs(F_only_peak))); [peak_row,peak_col,~] = find(abs(F_only_peak) == peak_value); % Finding of peak location. 
    % Shifting peak to the center
    F_shift_to_center = circshift(F_only_peak,[(round(img_size(1)/2) - peak_row) (round(img_size(2)/2) - peak_col)]);
end

% Inverse FFT.
F_ishift = ifftshift(F_shift_to_center); Inv = ifft2(F_ishift);

% Phase extraction.
F_angle = angle(Inv);  % The interferogram is represented as g(x,y) = a(x,y) + b(x,y)cos(2*pi*f_0*x + phi(x,y)) and the right (left) side peak is corresponding to phi (-phi). 
                         % But it should be noted that the sign of the actual phase phi is depending on the how the two beams are overlapped on the measurement plane.
%% Reference
% # M. Takeda, H. Ina, and S. Kobayashi, ¡°Fourier-transform method of fringe-pattern analysis for computer-based topography and interferometry,¡± J. Opt. Soc. Am., vol. 72, no. 1, p. 156, Jan. 1982.