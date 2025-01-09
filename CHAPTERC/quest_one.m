% MATLAB code for sliding mode control of a 2-DOF robotic arm

% Given parameters for the robotic arm
m1 = 6;      % kg, mass of the first link
m2 = 4;      % kg, mass of the second link
l1 = 0.5;    % m, length of the first link
l2 = 0.4;    % m, length of the second link
g = 9.81;    % m/s^2, gravitational acceleration
lc1 = 0.2;   % m, center of mass of the first link
lc2 = 0.1;   % m, center of mass of the second link
I1 = 0.43;   % kg*m^2, moment of inertia of the first link
I2 = 0.05;   % kg*m^2, moment of inertia of the second link
ml = 0.5;    % kg, mass of the payload

% Desired positions and velocities
qd = [pi/2; -pi/3];  % rad, desired angles
q_dot_d = [0; 0];    % rad/s, desired angular velocities

% Sliding surface gain
lambda_gain = 10;

% Initial conditions
q0 = [pi / 3; pi / 3];  % Initial angles (rad)
q_dot0 = [0; 0];        % Initial angular velocities (rad/s)
initial_state = [q0; q_dot0];

% Time span for simulation
time_span = [0, 10];  % seconds
time_eval = linspace(time_span(1), time_span(2), 1000);

% Solve the dynamics
[t, states] = ode15s(@(t, state) robotic_arm_dynamics(t, state, qd, q_dot_d, lambda_gain, m1, m2, ml, lc1, lc2, l1, l2, I1, I2, g), time_span, initial_state);

% Extract results
q1 = states(:, 1);
q2 = states(:, 2);
q1_dot = states(:, 3);
q2_dot = states(:, 4);

% Plot results
figure;
plot(t, q1, 'b', 'DisplayName', 'q1 (rad)');
hold on;
plot(t, q2, 'g', 'DisplayName', 'q2 (rad)');
yline(qd(1), 'r--', 'DisplayName', 'qd1 (desired)');
yline(qd(2), 'k--', 'DisplayName', 'qd2 (desired)');
xlabel('Time (s)');
ylabel('Angle (rad)');
legend;
title('Joint Angles');
grid on;

figure;
plot(t, q1_dot, 'b', 'DisplayName', 'q1_dot (rad/s)');
hold on;
plot(t, q2_dot, 'g', 'DisplayName', 'q2_dot (rad/s)');
xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
legend;
title('Joint Velocities');
grid on;
