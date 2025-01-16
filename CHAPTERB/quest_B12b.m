K = [3, 5];
initial_conditions = [9, 11; 11, 1; 0.5, 0.5];
tspan = [0 10];
colors = ['b', 'm', 'g']; 
options = odeset('Refine', 10); % Αυξάνει τον αριθμό των σημείων που επιστρέφονται

warning('off', 'MATLAB:ode45:IntegrationTolNotMet'); 

for i = 1:size(initial_conditions, 1)
    figure;
    hold on;
    [t, x] = ode45(@(t, x)control_system_b(t, x, K), tspan, initial_conditions(i, :), options);
    plot(t, x(:, 1), 'DisplayName', sprintf('x1(%d)', i), 'Color', colors(i), 'LineWidth', 2);
    plot(t, x(:, 2), '--', 'DisplayName', sprintf('x2(%d)', i), 'Color', colors(i), 'LineWidth', 2);
    title('Απόκριση του Συστήματος στο Χρόνο');
    xlabel('Χρόνος (t)');
    ylabel('Τιμές x1 και x2');
    legend;
    grid on;
    hold off;
end

% Φασικό επίπεδο καταστάσεων και πεδίο έλξης
[x1_values, x2_values] = meshgrid(-12:0.1:12, -12:0.1:12); 

% Υπολογισμός πεδίου έλξης
x1dot = zeros(size(x1_values));
x2dot = zeros(size(x2_values));
for i = 1:numel(x1_values)
    xdot = control_system_b(0, [x1_values(i); x2_values(i)], K);
    x1dot(i) = xdot(1);
    x2dot(i) = xdot(2);
end

% Εκτίμηση του ΠΔ
c = 10;
V = 2*x1_values.^2 + 0.5*x2_values.^2 - c;

for i = 1:size(initial_conditions, 1)
    figure;
    hold on;

    contour(x1_values, x2_values, V, [0 0], 'k', 'LineWidth', 1.5, 'DisplayName', 'V(x_1, x_2) = 0');
    quiver(x1_values, x2_values, x1dot, x2dot, 'Color', [0.5, 0.5, 0.5], 'LineWidth', 1.5, 'DisplayName', 'Attraction Field');
    
    [t, x] = ode45(@(t, x)control_system_b(t, x, K), tspan, initial_conditions(i, :), options); 
    plot(x(:, 1), x(:, 2), 'DisplayName', ['x_0 = [' num2str(initial_conditions(i, :)) ']'], 'Color', colors(i), 'LineWidth', 1.5);
    
    xlabel('x_1');
    ylabel('x_2');
    legend;
    title('Φασικό Επίπεδο Καταστάσεων και Πεδίο Έλξης');
    grid on;
    hold off;
end