clear all
close all

% Sampling parameters
delta_t = 0.001;

% Plant parameters
r = 0.1;
l = 0.6;

% Noise parameters
Q = [0.0001 0  0; 0 0.0001 0; 0 0 0.0001];
R = [0.015 0 0; 0 0.01 0; 0 0 0.01];

% Control parameters
u1_amplitude = 0.1;
u1_frequency = 0.1;
u1_offset = 0;
u2_amplitude = 0.12; 
u2_frequency = 0.02;
u2_offset = 0;

% Initial values
P_k_minus_1 = [2 0 0; 0 2 0; 0 0 2];
x_initial = [1; 3; pi/6]; % Contains x, y, and theta
x = x_initial;
x_i_1 = x_initial(1);
x_i_2 = x_initial(2);
x_i_3 = x_initial(3);
delf_delx_initial = [1 0 0;
                     0 1 0;
                     0 0 1];
A = delf_delx_initial;
delh_delx_initial = [x_i_1/sqrt(x_i_1^2 + x_i_2^2) x_i_2/sqrt(x_i_1^2 + x_i_2^2) 0;
                     -x_i_2/(x_i_1^2 + x_i_2^2)    x_i_1/(x_i_1^2 + x_i_2^2)     0;
                     0                             0                             1];
H = delh_delx_initial;

x_hat_k_minus_1 = x_initial; % A 3x1 vector containing x, y, and theta.
K_k = P_k_minus_1*H'*inv(H*P_k_minus_1*H' + R);

% Record Arrays
y_list = [];
y_hat_list = [];
u_list = [];
K_k_list = [];
P_k_list = [];

for k = 1:1000
    % Control input (not a feedback control input)
    u_k = [u1_offset + u1_amplitude * sin(2 * pi * u1_frequency * k * delta_t);
           u2_offset + u2_amplitude * sin(2 * pi * u2_frequency * k * delta_t)];
    
    % Prediction Update
    x_hat_minus_k = x_hat_k_minus_1 + [delta_t * 0.5 * r * (u_k(1) + u_k(2)) * cos(x_hat_k_minus_1(3));
                                       delta_t * 0.5 * r * (u_k(1) + u_k(2)) * sin(x_hat_k_minus_1(3));
                                       delta_t * 0.5 * (r/l) * (u_k(1) - u_k(2))];
    delf_delx = [1 0 -delta_t*0.5*r*(u_k(1) + u_k(2))*sin(x_hat_k_minus_1(3));
                 0 1  delta_t*0.5*r*(u_k(1) + u_k(2))*cos(x_hat_k_minus_1(3));
                 0 0  1];
    
    A = delf_delx;
    P_minus_k = A * P_k_minus_1 * A' + Q;
    
    % Measurement Update
        % Plant Simulation Equation
        x = x + [delta_t * 0.5 * r * (u_k(1) + u_k(2)) * cos(x(3));
                 delta_t * 0.5 * r * (u_k(1) + u_k(2)) * sin(x(3));
                 delta_t * 0.5 * (r/l) * (u_k(1) - u_k(2))] ...
              + [sqrt(Q(1,1))*randn; sqrt(Q(2,2))*randn; sqrt(Q(3,3))*randn];
          % Measurement Simulation Equation
          d = sqrt(x(1)^2 + x(2)^2);
          alpha = atan2(x(2),x(1));
          theta = x(3);
          d_noisy = d + sqrt(R(1,1)) * randn;
          alpha_noisy = alpha + sqrt(R(2,2)) * randn;
          theta_noisy = theta + sqrt(R(3,3)) * randn;
          z_k = [d_noisy;
                 alpha_noisy;
                 theta_noisy];
            
          % Computation of K
          delh_delx = [x_hat_k_minus_1(1)/sqrt(x_hat_k_minus_1(1)^2+x_hat_k_minus_1(2)^2) ...
                       x_hat_k_minus_1(2)/sqrt(x_hat_k_minus_1(1)^2+x_hat_k_minus_1(2)^2) ...
                       0;
                      -x_hat_k_minus_1(2)/(x_hat_k_minus_1(1)^2+x_hat_k_minus_1(2)^2) ...
                       x_hat_k_minus_1(1)/(x_hat_k_minus_1(1)^2+x_hat_k_minus_1(2)^2) ...
                       0;
                       0 0 1];
          H = delh_delx;
          K_k = P_minus_k*H'*inv(H*P_minus_k*H' + R);
          % State Estimate Correction
          x_hat_k = x_hat_minus_k ...
                  + K_k * (z_k - [sqrt(x_hat_minus_k(1)^2 + x_hat_minus_k(2)^2);
                                  atan2(x_hat_minus_k(2), x_hat_minus_k(1));
                                  x_hat_minus_k(3)] ...
                           );
          % Error Covariance Update
          P_k = (eye(3) - K_k*H) * P_minus_k;
          
    % Variables for the next cycle
    P_k_minus_1 = P_k;
    x_hat_k_minus_1 = x_hat_k;
    
    % Array Recording
    y_list = [y_list; x'];
    y_hat_list = [y_hat_list; x_hat_k'];
    u_list = [u_list; u_k'];
    K_k_list = [K_k_list; K_k(1,1)];
    % P_k_list = [P_k_list; P_k];      
end

figure %1
subplot(2,1,1)
plot(u_list(:,1))
xlabel('Time Index')
ylabel('Control 1')
subplot(2,1,2)
plot(u_list(:,2))
xlabel('Time Index')
ylabel('Control 2')

figure %2
subplot(2,1,1)
plot(y_list(:,1), 'r')
xlabel('Time Index')
ylabel('Position 1')
subplot(2,1,2)
plot(y_hat_list(:,1), 'k')
xlabel('Time Index')
ylabel('Estimate 1')

figure %3
subplot(2,1,1)
plot(y_list(:,2), 'r')
xlabel('Time Index')
ylabel('Position 2')
subplot(2,1,2)
plot(y_hat_list(:,2), 'k')
xlabel('Time Index')
ylabel('Estimate 2')

figure %4
subplot(2,1,1)
plot(y_list(:,3), 'r')
xlabel('Time Index')
ylabel('Position 3')
subplot(2,1,2)
plot(y_hat_list(:,3), 'k')
xlabel('Time Index')
ylabel('Estimate 3')

figure %5
plot(y_list(:,1), 'r')
hold
plot(y_hat_list(:,1), 'k')
xlabel('Time Index')
ylabel('Position 1')

figure %6
plot(y_list(:,2), 'r')
hold
plot(y_hat_list(:,2), 'k')
xlabel('Time Index')
ylabel('Position 2')

figure %7
plot(y_list(:,3), 'r')
hold
plot(y_hat_list(:,3), 'k')
xlabel('Time Index')
ylabel('Position 3')

figure %8
plot(K_k_list(:,1), 'b')
xlabel('Time Index')
ylabel('Gain')
