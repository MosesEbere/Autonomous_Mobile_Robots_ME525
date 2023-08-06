clear all; close all; clc

% Define the Intrinsic Parameters
image_frame = 1000; % in pixels
image_plane = 24; % in mm

principal_point = [image_frame/2; image_frame/2]; % (u0,v0) in pixels
focal_length = 30; % in mm
scale_factor = image_frame/image_plane; % k in pixel/mm
effective_focal_length = scale_factor*focal_length; % in pixels

theta = 12*pi/180; % in radians

% Coordinates of Point in World Frame
Xw = 0.05; % in meters
Yw = 0.03; % in meters
Zw = 0.3; % in meters
point_in_world = [Xw; Yw; Zw];
H_world = [point_in_world; 1]; % Homogeneous World Coordinates

% Extrinsic Parameters
T = [0.1; 0.2; 1]; % Translation vector

% Obtain the coordinates of the point with respect to the camera center
% using the rotation and translation vectors. 
rotationMatrix = [cos(theta) -sin(theta) 0;
                  sin(theta)  cos(theta) 0;
                  0              0      1];

point_in_camera = [];
point_in_camera = rotationMatrix * point_in_world + T;

% Define lambda which corresponds to the depth (Z_camera)
lambda = point_in_camera(3);
            
% Create the intrinsic parameter matrix, K
K = [effective_focal_length            0           principal_point(1);
     0                     effective_focal_length  principal_point(2);
     0                                 0                           1];

% Concatenate the columns of the rotation matrix and the translation
% vector.
pixel_coordinate_unscaled = K * [rotationMatrix T] * H_world;
% OR pixel_coordinate_unscaled = K * point_in_camera;

homogeneous_pixel_coordinates = 1/lambda*pixel_coordinate_unscaled;

% Final pixel coordinates (a 2x1 vector)
pixel_coordinates = [homogeneous_pixel_coordinates(1); homogeneous_pixel_coordinates(2)];
