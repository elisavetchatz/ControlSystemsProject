initial_conditions = [0.8, 0.8; -0.4, 1]; 
tspan = [0 10];
options = odeset('Refine', 10);
colors = ['b', 'm']; 

for i=1:size(initial_conditions, 1)
    figure;
    hold on;
    [t, x] = ode45(@(t, x)system_d(t, x), tspan, initial_conditions(i, :), options);
    plot(t, x(:, 1), 'DisplayName',  sprintf('x1(%d)', i), 'Color', colors(i), 'LineWidth', 2);
    plot(t, x(:, 2), '--', 'DisplayName', sprintf('x2(%d)', i), 'Color', colors(i), 'LineWidth', 2);
    title('Απόκριση του Συστήματος στο Χρόνο');
    xlabel('Χρόνος (t)');
    ylabel('Τιμές x1 και x2');
    legend;
    grid on;
    hold off;

end 

for i=1:size(initial_conditions, 1)
    figure;
    hold on;

    [t, x] = ode45(@(t, x)system_d(t, x), tspan, initial_conditions(i, :), options); 
    plot(x(:, 1), x(:, 2), 'DisplayName', ['x_0 = [' num2str(initial_conditions(i, :)) ']'], 'Color', colors(i), 'LineWidth', 1.5);
    
    xlabel('x_1');
    ylabel('x_2');
    legend;
    title('Φασικό Επίπεδο Καταστάσεων και Πεδίο Έλξης');
    grid on;
    hold off;
end