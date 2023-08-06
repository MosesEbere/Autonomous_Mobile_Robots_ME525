clear all
close all
clc

mylego = legoev3('usb');

% Set up infrared sensor on port 2
myirsensor = irSensor(mylego, 2);

Rightmotor = motor(mylego,'C');
Leftmotor = motor(mylego,'B');

resetRotation(Rightmotor);
resetRotation(Leftmotor);

Rightmotor.Speed = 0;
Leftmotor.Speed = 0;

Leftarray = [];
Rightarray = [];

Leftarray(1)= 0;
Rightarray(1) = 0;

calibration(mylego);
stop(Rightmotor);
stop(Leftmotor);

i=1;

while ~readButton(mylego, 'up')
    % Read the button from the beacon
    button = readBeaconButton(myirsensor,2);
    
    % Forward Motion
    if button == 1 
        Rightmotor.Speed = -80;
        Leftmotor.Speed = -80;
        start(Rightmotor);
        start(Leftmotor);
    
    end
    
    % Backward Motion
    if button == 2 
        Rightmotor.Speed = 80;
        Leftmotor.Speed = 80;
        start(Rightmotor);
        start(Leftmotor);
    
    end
    
    % Rightward Motion
    if button == 3 
        Rightmotor.Speed = -20;
        Leftmotor.Speed = -80;
        start(Rightmotor);
        start(Leftmotor);
    
    end
    
    % Leftward Motion
    if button == 4 
        Rightmotor.Speed = -80;
        Leftmotor.Speed = -20;
        start(Rightmotor);
        start(Leftmotor);
    
    end
   
    % Read the Encoder values
    Leftarray(i+1)= readRotation(Leftmotor);
    Rightarray(i+1) = readRotation(Rightmotor);
    
    i=i+1;
end

 stop(Rightmotor);
 stop(Leftmotor);
