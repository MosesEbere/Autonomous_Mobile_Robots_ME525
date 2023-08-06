clear all
close all
clc

mylego = legoev3('usb');

% Set up infrared sensor on port 3
myirsensor = irSensor(mylego, 3);

Rightmotor = motor(mylego,'C');
Leftmotor = motor(mylego,'B');

resetRotation(Rightmotor);
resetRotation(Leftmotor);

speed = 20;
Rightmotor.Speed = speed;
Leftmotor.Speed = speed;

start(Rightmotor);
start(Leftmotor);

x_k = 0;
x_k_minus_1 = 0;
w_k_list = [];
w_k_list(1) = 0;

EXE_TIME = 2; 
PERIOD = 0.1;
t = timer('TimerFcn', 'stat=false', 'StartDelay', EXE_TIME);
i = 0;
while stat == true && ~readButton(mylego, 'up')
      
    Rightmotor.Speed = 20;
    Leftmotor.Speed = 20;
    w_k_list = [w_k_list; double(readProximity(myirsensor))];
    pause(2)
    Rightmotor.Speed = -20;
    Leftmotor.Speed = -20;
    w_k_list = [w_k_list; double(readProximity(myirsensor))];
    pause(2)
    i = i+1;
    if i == 3
        break
    end
end
stop(Rightmotor);
stop(Leftmotor);

Q = var(w_k_list);

figure %1
plot(w_k_list)
xlabel('Time Index')
ylabel('Process Noise')

%     start(t);
%     stat = true;
%     Rightmotor.Speed = 30;
%     Leftmotor.Speed = 30;
%     while stat == true
%         w_k_list = [w_k_list; double(readProximity(myirsensor))];
%         pause(PERIOD);
%     end
%     
%     start(t);
%     stat = true;
%     Rightmotor.Speed = -30;
%     Leftmotor.Speed = -30;
%     while stat == true
%         w_k_list = [w_k_list; double(readProximity(myirsensor))];
%         pause(PERIOD);
%     end