clear all; clc

% Define camera parameters without lens distortion or skew.
% Specify the focal length and principal point in pixels.
f = 30; % focal length in mm.
focalLength    = [1000/24 * f, 1000/24 * f]; % in pixels
principalPoint = [500, 500];
imageSize      = [1000, 1000];

% Create a camera intrinsics object.
intrinsics = cameraIntrinsics(focalLength,principalPoint,imageSize);

theta = 12*pi/180; % in radians

% Create the Rotation Matrix and intialize the Translation Vector
rotationMatrix = [cos(theta) -sin(theta) 0;
                  sin(theta)  cos(theta) 0;
                  0              0      1];
translationVector = [0.1; 0.2; 1];

% Coordinates of Point in World Frame
Xw = 0.05; % in meters
Yw = 0.03; % in meters
Zw = 0.3; % in meters
worldPoints = [Xw; Yw; Zw];

% Final pixel coordinates (a 1x2 row vector)
projectedPoints = worldToImage(intrinsics,rotationMatrix,translationVector,worldPoints');