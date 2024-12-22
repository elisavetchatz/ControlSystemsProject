tspan = [0 10];

% Αρχικές συνθήκες
initial_conditions = [
    0.1, 0.1;    % x1(0) = 0.1, x2(0) = 0.1
    0.4, 0.4;   
    0.8, 0.8;    
   -0.4, 1       
];

colors = ['r', 'g', 'b', 'm'];

% Λύση του συστήματος για κάθε αρχική συνθήκη
figure;
hold on;
for i = 1:size(initial_conditions, 1)
    [t, x] = ode45(@system, tspan, initial_conditions(i, :));
    plot(t, x(:, 1), 'DisplayName', sprintf('x1(%d)', i), 'Color', colors(i), 'LineWidth', 2);
    plot(t, x(:, 2), '--', 'DisplayName', sprintf('x2(%d)', i), 'Color', colors(i), 'LineWidth', 2);
end
title('Απόκριση του Συστήματος στο Χρόνο');
xlabel('Χρόνος (t)');
ylabel('Τιμές x1 και x2');
legend;
grid on;
hold off;

% Φασικό επίπεδο καταστάσεων και πεδίο έλξης
[x1_values, x2_values] = meshgrid(-2:0.1:2, -2:0.1:2);  
x1dot = -x1_values + x2_values;
x2dot = -x1_values; % + x1_values .* x2_values + 0.5 * x2_values.^2;

figure;
hold on;

quiver(x1_values, x2_values, x1dot, x2dot, 'Color', [0.5, 0.5, 0.5], 'LineWidth', 1.5, 'DisplayName', 'Attraction Field');

for i = 1:size(initial_conditions, 1)
    [t, x] = ode45(@system, tspan, initial_conditions(i, :)); 
    plot(x(:, 1), x(:, 2), 'DisplayName', ['x_0 = [' num2str(initial_conditions(i, :)) ']'], 'Color', colors(i), 'LineWidth', 1.5);
end

xlabel('x_1');
ylabel('x_2');
legend;
title('Φασικό Επίπεδο Καταστάσεων και Πεδίο Έλξης');
grid on;
hold off;
