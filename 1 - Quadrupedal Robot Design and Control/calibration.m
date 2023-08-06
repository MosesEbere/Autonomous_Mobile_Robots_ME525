function calibration(mylego)

% Create connections for the left (B) and right (C) motors.
MotorB = motor(mylego, 'B');

MotorC = motor(mylego, 'C');

EncoderB = readRotation(MotorB);
EncoderC = readRotation(MotorC);

% Set up the Touch Sensor on input port 1
mytouchsensor = touchSensor(mylego, 1);
% Read the state of the touch sensor. 
% Such that 1 - pressed; 0 - not pressed
pressed = readTouch(mytouchsensor);

if readTouch(mytouchsensor) == 1
    % Set the speed of left motor to 10%
    MotorB.Speed = 10;
    % Run the left motor
    start(MotorB);
    % Set the speed of right motor to 20%
    MotorC.Speed = 20;
    % Run the right motor
    start(MotorC);
else
    stop(MotorB);
    stop(MotorC);
end

while readTouch(mytouchsensor) == 0
    % Set the speed of left motor to 40%
    MotorB.Speed = 40;
    % Run the left motor
    start(MotorB);
end

% Stop the left motor
stop(MotorB);
% Reset the left Encoder
resetRotation(MotorB);

while readRotation(MotorB) > - 72
    % Set the speed of left motor to -50%
    MotorB.Speed = -50;
    % Run the left motor
    start(MotorB);
end
% Stop the left motor
stop(MotorB);

while readTouch(mytouchsensor) == 0
    % Set the speed of left motor to 40%
    MotorC.Speed = 40;
    % Run the left motor
    start(MotorC);
end
% Stop the right motor
stop(MotorC);
% Reset the right Encoder
resetRotation(MotorC);

while readRotation(MotorC) > - 72
    % Set the speed of right motor to -50%
    MotorC.Speed = -50;
    % Run the right motor
    start(MotorC);
end
% Stop the right motor
stop(MotorC);

end