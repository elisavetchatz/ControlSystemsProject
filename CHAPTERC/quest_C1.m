% Παράμετροι
m1 = 6; m2 = 4; l1 = 0.5; l2 = 0.4; g = 9.81;
lc1 = 0.2; lc2 = 0.1; I1 = 0.43; I2 = 0.05; ml = 0.5;

% Αρχικές συνθήκες
q0 = [pi/3; pi/3];    % Αρχική θέση
qd = [pi/2; -pi/3];   % Επιθυμητή θέση
qdd = [0; 0];         % Επιθυμητή επιτάχυνση
q_dot0 = [0; 0];      % Αρχική ταχύτητα

% Παράμετροι ελέγχου
lambda = 10;          % Κέρδος επιφάνειας ολίσθησης
k = 10         % Κέρδος ελέγχου

% Χρόνος προσομοίωσης
T = 5;             % Διάρκεια (s)

% Συνάρτηση προσομοίωσης
[t, X] = ode15s(@(t, X) robot_dynamics(t, X, qd, qdd, lambda, k, m1, m2, l1, l2, lc1, lc2, g, I1, I2, ml), [0 T], [q0; q_dot0]);

% Διάγραμμα Θέσεων
figure;
plot(t, X(:,1), 'b', t, X(:,2), 'r', 'LineWidth', 1.5); hold on;
yline(qd(1), '--b', 'LineWidth', 1); % Επιθυμητή q1
yline(qd(2), '--r', 'LineWidth', 1); % Επιθυμητή q2
grid on;
title('Θέσεις q');
xlabel('Χρόνος (s)');
ylabel('Θέση (rad)');
legend('q1', 'q2', 'q1_{desired}', 'q2_{desired}');
hold off;

% Διάγραμμα Ταχυτήτων
figure;
plot(t, X(:,3), 'b', t, X(:,4), 'r', 'LineWidth', 1.5); hold on;
grid on;
title('Ταχύτητες \dot{q}');
xlabel('Χρόνος (s)');
ylabel('Ταχύτητα (rad/s)');
legend('\dot{q1}', '\dot{q2}');
hold off;

% Φασικό Πορτραίτο για q1
figure;
plot(X(:,1), X(:,3), 'b', 'LineWidth', 1.5); hold on;
grid on;
title('Φασικό Πορτραίτο (q1, \dot{q1})');
xlabel('Θέση q1 (rad)');
ylabel('Ταχύτητα \dot{q1} (rad/s)');
legend('(q1, \dot{q1})');
hold off;

% Φασικό Πορτραίτο για q2
figure;
plot(X(:,2), X(:,4), 'r', 'LineWidth', 1.5); hold on;
grid on;
title('Φασικό Πορτραίτο (q2, \dot{q2})');
xlabel('Θέση q2 (rad)');
ylabel('Ταχύτητα \dot{q2} (rad/s)');
legend('(q2, \dot{q2})');
hold off;


