K = [3, 5];

initial_conditions = [9, 11; 11, 1; 0.5, 0.5];
tspan = [0 10];
theta = 1;

colors = ['b', 'm', 'g']; 

options = odeset('Refine', 10); % Αυξάνει τον αριθμό των σημείων που επιστρέφονται


figure;
hold on;
for i = 1:size(initial_conditions, 1)
    [t, x] = ode45(@(t, x)control_system(t, x, K, theta), tspan, initial_conditions(i, :), options);
    plot(t, x(:, 1), ':', 'DisplayName', sprintf('x1(%d)', i), 'Color', colors(i), 'LineWidth', 2);
    plot(t, x(:, 2), '--', 'DisplayName', sprintf('x2(%d)', i), 'Color', colors(i), 'LineWidth', 2);
end
title('Απόκριση του Συστήματος στο Χρόνο');
xlabel('Χρόνος (t)');
ylabel('Τιμές x1 και x2');
legend;
grid on;
hold off;

% Φασικό επίπεδο καταστάσεων και πεδίο έλξης
[x1_values, x2_values] = meshgrid(-12:0.1:12, -12:0.1:12);  
x1dot = -x1_values + x2_values;
x2dot = -x1_values - K(1)*x1_values - K(2)*x2_values + (0.5-theta) * x2_values.^2;

figure; 
hold on;

quiver(x1_values, x2_values, x1dot, x2dot, 'Color', [0.5, 0.5, 0.5], 'LineWidth', 1.5, 'DisplayName', 'Attraction Field');

for i = 1:size(initial_conditions, 1)
    [t, x] = ode45(@(t, x)control_system(t, x, K, theta), tspan, initial_conditions(i, :), options); 
    plot(x(:, 1), ':', 'DisplayName', ['x_0 = [' num2str(initial_conditions(i, :)) ']'], 'Color', colors(i), 'LineWidth', 1.5);
    hold on;
    plot(x(:, 2) , '--', 'DisplayName', ['x_0 = [' num2str(initial_conditions(i, :)) ']'], 'Color', colors(i), 'LineWidth', 1.5);
end

xlabel('x_1');
ylabel('x_2');
legend;
title('Φασικό Επίπεδο Καταστάσεων και Πεδίο Έλξης');
grid on;
hold off;




