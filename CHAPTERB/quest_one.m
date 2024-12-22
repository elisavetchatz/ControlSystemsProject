tspan = [0 10];

% Αρχικές συνθήκες
initial_conditions = [
    0.1, 0.1;    % x1(0) = 0.1, x2(0) = 0.1
    0.4, 0.4;   
    0.8, 0.8;    
   -0.4, 1       
];

% Λύση του συστήματος για κάθε αρχική συνθήκη
figure;
hold on;
for i = 1:size(initial_conditions, 1)
    [t, x] = ode45(@system, tspan, initial_conditions(i, :));
    plot(t, x(:, 1), 'DisplayName', sprintf('x1(%d)', i));
    plot(t, x(:, 2), '--', 'DisplayName', sprintf('x2(%d)', i));
end
title('Απόκριση του Συστήματος στο Χρόνο');
xlabel('Χρόνος (t)');
ylabel('Μεγέθη x1 και x2');
legend;
grid on;
hold off;

% Απεικόνιση του πεδίου έλξης στο επίπεδο κατάστασης
[x1_values, x2_values] = meshgrid(-2:0.1:2, -2:0.1:2);  
x1dot = -x1_values + x2_values;
x2dot = -x1_values + x1_values .* x2_values + 0.5 * x2_values.^2;

figure;
quiver(x1_values, x2_values, x1dot, x2dot, 'r');
title('Πεδίο Έλξης του Συστήματος');
xlabel('x1');
ylabel('x2');
grid on;