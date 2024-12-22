K = [3, 5];

initial_conditions = [9, 11; 11, 1];
tspan = [0 10];
theta = 0.5;

colors = ['b', 'm']; 

figure;
hold on;
for i = 1:size(initial_conditions, 1)
    [t, x] = ode45(@(t, x)control_system(t, x, K, theta), tspan, initial_conditions(i, :));
    plot(t, x(:, 1), 'DisplayName', sprintf('x1(%d)', i), 'Color', colors(i), 'LineWidth', 2);
    plot(t, x(:, 2), '--', 'DisplayName', sprintf('x2(%d)', i), 'Color', colors(i), 'LineWidth', 2);
end
title('Απόκριση του Συστήματος στο Χρόνο');
xlabel('Χρόνος (t)');
ylabel('Τιμές x1 και x2');
legend;
grid on;
hold off;




