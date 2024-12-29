% MATLAB Code for Robotic Arm Control - Sliding Mode Control

% Given Parameters
m1 = 6; m2 = 4; l1 = 0.5; l2 = 0.4; g = 9.81;
lc1 = 0.2; lc2 = 0.1; I1 = 0.43; I2 = 0.05; ml = 0.5;

% Desired position (static)
qd_static = [pi/2; -pi/3];

% Desired trajectory (dynamic)
T = 10; % Simulation time
syms t;
qd_dynamic = [(pi/4) + (pi/6)*sin(0.2*pi*t); (-pi/3) + (pi/3)*cos(0.2*pi*t)];

% Model Definitions
H = @(q) [m1*lc1^2 + m2*(lc2^2 + l1^2 + 2*l1*lc2*cos(q(2))) + ml*(l2^2 + l1^2 + 2*l1*l2*cos(q(2))) + I1 + I2, m2*lc2*(lc2 + l1*cos(q(2))) + ml*l2*(l2 + l1*cos(q(2))) + I2;
          m2*lc2*(lc2 + l1*cos(q(2))) + ml*l2*(l2 + l1*cos(q(2))) + I2, m2*lc2^2 + ml*l2^2 + I2];

C = @(q, dq) [-l1*(m2*lc2 + ml*l2)*sin(q(2))*dq(2), -l1*(m2*lc2 + ml*l2)*sin(q(2))*(dq(2) + dq(1));
               l1*(m2*lc2 + ml*l2)*sin(q(2))*dq(1), 0];

g_vec = @(q) [(m2*lc2 + ml*l2)*g*cos(q(1) + q(2)) + (m2*l1 + ml*l1 + m1*lc1)*g*cos(q(1));
              (m2*lc2 + ml*l2)*g*cos(q(1) + q(2))];

% Sliding Mode Control Parameters
lambda = [5, 5]; % Gain for sliding surface
eta = [10, 10]; % Switching gain

% Simulation Function
ts = 0:0.01:T;
[q, dq] = deal(zeros(2, length(ts)));
q(:,1) = [pi/3; pi/3]; dq(:,1) = [0; 0]; % Initial conditions

for i = 1:length(ts)-1
    % Error Calculation
    e = qd_static - q(:,i);
    de = -dq(:,i);

    % Sliding Surface
    s = lambda'.*e + de;

    % Control Input
    H_q = H(q(:,i));
    C_q = C(q(:,i), dq(:,i));
    G_q = g_vec(q(:,i));

    u = -H_q*(lambda'.*de + eta'.*sign(s)) + C_q*dq(:,i) + G_q;

    % Dynamics Update (Euler Integration)
    ddq = H_q \ (u - C_q*dq(:,i) - G_q);
    dq(:,i+1) = dq(:,i) + ddq*0.01;
    q(:,i+1) = q(:,i) + dq(:,i)*0.01;
end

% Plots
figure;
plot(ts, q(1,:), 'r', ts, q(2,:), 'b');
legend('q1', 'q2'); xlabel('Time (s)'); ylabel('Angles (rad)');
title('Joint Angles Over Time');

grid on;
