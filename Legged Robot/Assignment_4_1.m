clear all
close all
clc

% DATA ENTRY
% ---------------------------------------
% Simulation Parameters
step_time = 0.001; % We'd like to have data for every millisecond

% Recall: T_walk = 2(T_single + T_double)
T_walk = 3;
T_single = 1;
T_double = 0.5;
Step_size = 0.1;
Step_height = 0.05;
Body_height = 0.5;
y_offset = 0.4;

stop_time = 5*T_walk;

% Data Storage Dimension - The +1 is for time = 0s.
record_length = (stop_time/step_time) + 1;

% References for all axes for each leg.
x_right_list = zeros(record_length, 1);
x_left_list = zeros(record_length, 1);
y_right_list = zeros(record_length, 1);
y_left_list = zeros(record_length, 1);
z_right_list = zeros(record_length, 1);
z_left_list = zeros(record_length, 1);
time_list = zeros(record_length, 1);

% Foot Coordinates
x_left_foot_list = zeros(record_length, 1);
x_right_foot_list = zeros(record_length, 1);
y_left_foot_list = zeros(record_length, 1);
y_right_foot_list = zeros(record_length, 1);
z_left_foot_list = zeros(record_length, 1);
z_right_foot_list = zeros(record_length, 1);

x_l_list = zeros(record_length, 1);
x_r_list = zeros(record_length, 1);

for iteration_index = 1:1:record_length
   time = (iteration_index - 1)*step_time;
   % Normalize the time to always be between 0 and 1
   time_ratio_of_walk_period = (time/T_walk) - floor(time/T_walk);
   % Now, scale this value with the step period. This is to ensure that the
   % reference at any time instant could be correctly calculated. 
   time_in_walk_period = time_ratio_of_walk_period * T_walk;
   
   % There are four segments per period: 0 <= t <= T_single,
   % T_single < t <= T_single + T_double, T_single + T_double < t <=
   % 2*T_single + T_double, and 2*T_single + T_double < t.
   if (time_in_walk_period <= T_single)
       x_right = -Step_size + Step_size*(1 - cos(time_in_walk_period*pi/T_single));
       x_left = Step_size - Step_size*(1 - cos(time_in_walk_period*pi/T_single));
       y_right = -y_offset;
       y_left = y_offset;
       z_right = -Body_height + Step_height*0.5*(1 - cos(time_in_walk_period*2*pi/T_single));
       z_left = -Body_height;
       
       x_right_foot = Step_size*(1 - cos(time_in_walk_period*pi/T_single));
       x_left_foot = 0;
       y_right_foot = -y_offset;
       y_left_foot = y_offset;
       z_right_foot = Step_height*0.5*(1 - cos(time_in_walk_period*2*pi/T_single));
       z_left_foot = 0;
   end
   
   if (T_single < time_in_walk_period  && time_in_walk_period <= T_single + T_double)
       x_right = Step_size;
       x_left = -Step_size;
       y_right = -y_offset;
       y_left = y_offset;
       z_right = -Body_height;
       z_left = -Body_height;
       
       x_right_foot = 0;
       x_left_foot = 0;
       y_right_foot = -y_offset;
       y_left_foot = y_offset;
       z_right_foot = 0;
       z_left_foot = 0;
   end
   
   if (T_single + T_double < time_in_walk_period  && time_in_walk_period <= 2*T_single + T_double)
       x_right = Step_size - Step_size*(1 - cos((time_in_walk_period...
           - (T_single + T_double)) *pi/T_single));
       x_left = -Step_size + Step_size*(1 - cos((time_in_walk_period...
           - (T_single + T_double))*pi/T_single));
       y_right = -y_offset;
       y_left = y_offset;
       z_right = -Body_height;
       z_left = -Body_height + Step_height*0.5*(1 - cos((time_in_walk_period...
           - (T_single + T_double))*2*pi/T_single));
       
       x_right_foot = 0;
       x_left_foot = Step_size*(1 - cos((time_in_walk_period...
           - (T_single + T_double))*pi/T_single));
       y_right_foot = -y_offset;
       y_left_foot = y_offset;
       z_right_foot = 0;
       z_left_foot = Step_height*0.5*(1 - cos((time_in_walk_period...
           - (T_single + T_double))*2*pi/T_single));
   end
   
   if (2*T_single + T_double < time_in_walk_period)
       x_right = -Step_size;
       x_left = Step_size;
       y_right = -y_offset;
       y_left = y_offset;
       z_right = -Body_height;
       z_left = -Body_height;
       
       x_right_foot = 0;
       x_left_foot = 0;
       y_right_foot = -y_offset;
       y_left_foot = y_offset;
       z_right_foot = 0;
       z_left_foot = 0;
   end
   
   x_right_list(iteration_index) = x_right;
   x_left_list(iteration_index) = x_left;
   y_right_list(iteration_index) = y_right;
   y_left_list(iteration_index) = y_left;
   z_right_list(iteration_index) = z_right;
   z_left_list(iteration_index) = z_left;
   time_list(iteration_index) = time;
   
   x_r_list(iteration_index) = x_right_foot;
   x_l_list(iteration_index) = x_left_foot;
   
   if iteration_index == 1
       x_right_foot_list(iteration_index) = x_right_foot;
       x_left_foot_list(iteration_index) = x_left_foot;
   else
       x_right_foot_list(iteration_index) = x_right_foot_list(iteration_index - 1)...
           + abs(x_r_list(iteration_index) - x_r_list(iteration_index - 1));
       x_left_foot_list(iteration_index) = x_left_foot_list(iteration_index - 1)...
           + abs(x_l_list(iteration_index) - x_l_list(iteration_index - 1));
   end
   
%    x_right_foot_list(iteration_index) = x_right_foot;
%    x_left_foot_list(iteration_index) = x_left_foot;
   y_right_foot_list(iteration_index) = y_right_foot;
   y_left_foot_list(iteration_index) = y_left_foot;
   z_right_foot_list(iteration_index) = z_right_foot;
   z_left_foot_list(iteration_index) = z_left_foot;
   
end

figure %1
plot(time_list, x_right_list, 'r')
ylim([-0.12 0.12])
hold
plot(time_list, x_left_list, 'b')
xlabel('Time [s]')
ylabel('x references [m]')
grid

figure %2
plot(time_list, y_right_list, 'r')
ylim([-0.5 0.5])
hold
plot(time_list, y_left_list, 'b')
xlabel('Time [s]')
ylabel('y references [m]')
grid

figure %3
plot(time_list, z_right_list, 'r')
ylim([-Body_height -Body_height+4/3*(Step_height)]) 
hold
plot(time_list, z_left_list, 'b')
xlabel('Time [s]')
ylabel('z references [m]')
grid

figure %4
subplot(3,1,1)
plot(time_list, x_right_list, 'r')
hold
plot(time_list, x_left_list, 'b')
xlabel('Time [s]')
ylabel('x references [m]')
grid

subplot(3,1,2)
plot(time_list, y_right_list, 'r')
hold
plot(time_list, y_left_list, 'b')
xlabel('Time [s]')
ylabel('y references [m]')
grid

subplot(3,1,3)
plot(time_list, z_right_list, 'r')
hold
plot(time_list, z_left_list, 'b')
xlabel('Time [s]')
ylabel('z references [m]')
grid

figure %5
plot(time_list, x_right_foot_list, 'r')
hold
plot(time_list, x_left_foot_list, 'b')
xlabel('Time [s]')
ylabel('x references [m]')
grid

figure %5
plot(time_list, y_right_foot_list, 'r')
hold
plot(time_list, y_left_foot_list, 'b')
xlabel('Time [s]')
ylabel('y references [m]')
grid

figure %6
plot(time_list, z_right_foot_list, 'r')
%ylim([-Body_height -Body_height+4/3*(Step_height)]) 
hold
plot(time_list, z_left_foot_list, 'b')
xlabel('Time [s]')
ylabel('z references [m]')
grid

figure %7
subplot(3,1,1)
plot(time_list, x_right_foot_list, 'r')
hold
plot(time_list, x_left_foot_list, 'b')
xlabel('Time [s]')
ylabel('x references [m]')
grid

subplot(3,1,2)
plot(time_list, y_right_foot_list, 'r')
hold
plot(time_list, y_left_foot_list, 'b')
xlabel('Time [s]')
ylabel('y references [m]')
grid

subplot(3,1,3)
plot(time_list, z_right_foot_list, 'r')
hold
plot(time_list, z_left_foot_list, 'b')
xlabel('Time [s]')
ylabel('z references [m]')
grid