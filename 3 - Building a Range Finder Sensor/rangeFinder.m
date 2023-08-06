clear all;
clc;

mylego = legoev3('usb');

% Set up infrared sensor on port 3
myirsensor = irSensor(mylego, 3);

% Set up the motor
MyMotor = motor(mylego,'A');

% Set up the parameters
d_array = [];
x_array = [];
y_array = [];
theta_array = [];

resetRotation(MyMotor);
start(MyMotor);
MyMotor.Speed = 20;

% The coefficient is for conversion is obtained through a simple test on
% the IR sensor. 
coefficient = 30/66;
i = 1;

while ~readButton(mylego, 'up')
    theta = double(readRotation(MyMotor));
    % Conditions to maintain the scanning range between 0 and 180 degrees
    if theta < 0
        MyMotor.Speed = 20;
        start(MyMotor);
    end
    if theta > 180
        MyMotor.Speed = -20;
        start(MyMotor);
    end
    
    % Calculate the distance & angle, and update the coordinates.
    theta_array(i) = theta;
    d_array(i) = readProximity(myirsensor);
    x_array(i) = d_array(i)*cosd(theta)*coefficient;
    y_array(i) = d_array(i)*sind(theta)*coefficient;
    
    % Plot the results
    clf;
    plot(x_array, y_array, '*'); 
    hold on;
    plot([0 x_array(i)], [0 y_array(i)], '-r')
    xlabel('x [cm]')
    ylabel('y [cm]')
    legend('Coordinates','Current Measurement' ) 
    pause(0.001)
    i = i+1;
end

stop(MyMotor);