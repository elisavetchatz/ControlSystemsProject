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

for i = 1:size(initial_conditions, 1)
    figure;
    hold on;
    [t, x] = ode45(@system, tspan, initial_conditions(i, :));
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
[x1_values, x2_values] = meshgrid(-1.5:0.1:1.5, -1.5:0.1:1.5); 

% Υπολογισμός πεδίου έλξης
x1dot = zeros(size(x1_values));
x2dot = zeros(size(x2_values));
for i = 1:numel(x1_values)
    xdot = system(0, [x1_values(i); x2_values(i)]);
    x1dot(i) = xdot(1);
    x2dot(i) = xdot(2);
end

% Εκτίμηση του ΠΔ
c = 0.01;  
V = 0.2*x1_values.^2 - 0.2*x1_values.*x2_values + 0.3*x2_values.^2 - c;

for i = 1:size(initial_conditions, 1)
    figure;
    hold on;

    contour(x1_values, x2_values, V, [0 0], 'k', 'LineWidth', 1.5, 'DisplayName', 'V(x_1, x_2) = 0');
    quiver(x1_values, x2_values, x1dot, x2dot, 'Color', [0.5, 0.5, 0.5], 'LineWidth', 1.5, 'DisplayName', 'Attraction Field');

    [t, x] = ode45(@system, tspan, initial_conditions(i, :)); 
    plot(x(:, 1), x(:, 2), 'DisplayName', ['x_0 = [' num2str(initial_conditions(i, :)) ']'], 'Color', colors(i), 'LineWidth', 1.5);
    xlabel('x_1');
    ylabel('x_2');
    legend;
    title('Φασικό Επίπεδο Καταστάσεων και Πεδίο Έλξης');
    grid on;
    hold off;
end

