clear all;
clc;

mylego = legoev3('usb');

% Set up infrared sensor on port 1
myirsensor = irSensor(mylego, 2);

% Set up the motors
Rightmotor = motor(mylego,'B');
Leftmotor = motor(mylego,'C');

% The Position and Orientation Arrays.
x_array = [];
y_array = [];
theta_array = [];

x_array_d = [];
y_array_d = [];
theta_array_d = [];

x_array(1) = 0;
y_array(1) = 0;
theta_array(1) = 0;

x_array_d(1) = 0;
y_array_d(1) = 0;
theta_array_d(1) = 0;

% Robot Parameters
R = 0.02;
L = 0.1;
% Counter
i = 1;

while ~readButton(mylego, 'up')
    resetRotation(Rightmotor);
    resetRotation(Leftmotor);
    % To change the time period
    pause(0.1)
    % Read the button from the beacon
    button = readBeaconButton(myirsensor,2);
    
    % Forward Motion
    if button == 1 
        Rightmotor.Speed = 50;
        Leftmotor.Speed = 50;
        start(Rightmotor);
        start(Leftmotor);
    end
    
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
    y_array(i+1) = y_array(i) + Dc*sin(theta_array(i) + (delta_theta/2));
    
    % Desired Trajectory for Linear Motion
    Er_d = double(readRotation(Rightmotor));
    El_d = Er_d;
    
    Dl_d = 2*pi*R*(El_d/360);
    Dr_d = 2*pi*R*(Er_d/360);
    
    Dc_d = (Dr_d+Dl_d)/2;
    
    delta_theta_d =(Dr_d-Dl_d)/L;

    theta_array_d(i+1) = theta_array_d(i) + delta_theta_d;
    x_array_d(i+1) = x_array_d(i) + Dc*cos(theta_array_d(i) + (delta_theta_d/2));
    y_array_d(i+1) = y_array_d(i) + Dc*sin(theta_array_d(i) + (delta_theta_d/2));
    
    i=i+1;
end

stop(Rightmotor);
stop(Leftmotor);

% Plot the results
figure
plot(x_array, y_array, 'b')
hold
plot(x_array_d, y_array_d, 'r')
legend('Calculated Odometry', 'Desired Trajectory')