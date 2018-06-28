clear all; clc
X=[];Y=[];
x = -15:0.2:15; %Size of the image and step-size
I0 = 10;  %Peak amplitude of the disk
%Obtain intensities using Bessel function of the first kind
I = I0*(2*besselj(1,x)./(x)).^2;
%Create matrix of surface intensities
for theta = 0:10:180; %Rotation interval is 10 degrees
    X(:,end+1) = x'*cosd(theta); Y(:,end+1) = x'*sind(theta);
end
% 19 intervals obtained using relation{(180-0)/10} + 1 = 19
II = repmat(I',[1,19]);

figure1 = figure;
colormap('gray');

% Create axes properties. Change according to need.
axes1 = axes('Parent',figure1,...
    'Color',[0 0.447058823529412 0.741176470588235],...
    'CameraViewAngle',6.66396777998441,...
    'CameraUpVector',[0 0 1],...
     'CameraTarget',[-0.715079209947286 -1.22226354685104 4.20072651896962],...
    'CameraPosition',[-134.843094325174 -176.021296053844 50.093080997041]);
view(axes1,[-37.5 32]);
grid(axes1,'on');
zlabel('Intensity');
hold(axes1,'all');

surf(X,Y,II,'Parent',axes1,'FaceColor',[1 1 1],...
    'EdgeColor',[0.313725490196078 0.313725490196078 0.313725490196078]);