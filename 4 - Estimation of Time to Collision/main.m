clear all; close all; clc;

mylego = legoev3('usb');

% Create connections for the left (B) and right (C) motors.
Rightmotor = motor(mylego, 'C');
Leftmotor = motor(mylego, 'B');
% Reset the encoders
resetRotation(Rightmotor);
resetRotation(Leftmotor);

cam = webcam(1);
cam.Resolution = '640x480';

while ~readButton(mylego, 'down')
    getImgFindCorners;
    pause(1/25);
end

% Set the speed for the motors and start
speed = 10;
Rightmotor.Speed = speed;
Leftmotor.Speed = speed;
start(Rightmotor);
start(Leftmotor);

% The Position and Orientation Arrays.
x_array = [];
theta_array = [];

x_array(1) = 0;
theta_array(1) = 0;

% Robot Parameters
R = 0.02;
L = 0.1;
% Counter
i = 1;
deltaT = 0.1;
while ~readButton(mylego, 'up')    
    resetRotation(Rightmotor);
    resetRotation(Leftmotor);
    % To change the time period
    pause(0.1)
    start = tic;
    % Plot the rectangle and calculate the length(s)
    subplot(1, 2, 1);
    getImgFindCorners;
    L1 = length;
    pause(deltaT);
    getImgFindCorners;
    L2 = length;
    
    calculateTTCandMove;
    
    % Travelled Distance
    % Read the Encoder values
    El = double(readRotation(Leftmotor));
    Er = double(readRotation(Rightmotor));
    
    % Calculate the required parameters
    Dl = 2*pi*R*(El/360);
    Dr = 2*pi*R*(Er/360);
    
    Dc = (Dr+Dl)/2;
    
    delta_theta=(Dr-Dl)/L;

    theta_array(i+1) = theta_array(i) + delta_theta;
    x_array(i+1) = x_array(i) + Dc*cos(theta_array(i) + (delta_theta/2));
    
    % Plot the distance travelled
    subplot(1, 2, 2);
    plot(x_array)
    ylabel('Distance Travelled')
    title(['Speed = ', num2str(speed)])
    
    elapsed = toc(start);
    pause((1/25) - elapsed);
    % Increment the counter for data storage
    i = i+1;
end
% Stop the motors
stop(Rightmotor);
stop(Leftmotor);