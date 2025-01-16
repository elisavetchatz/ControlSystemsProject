initial_conditions = [11, 1, 1]; 
tspan = [0 10];
options = odeset('Refine', 1);

[t, x] = ode45(@(t, x)control_system_c(t, x), tspan, initial_conditions, options);

% [t, x] = ode45(@control_system_c, tspan, initial_conditions, options);

x1 = x(:, 1);
x2 = x(:, 2);
theta_hat = x(:, 3);

figure;
hold on;
plot(t, x1, 'b', 'LineWidth', 1.5, 'DisplayName', 'x_1');
plot(t, x2, 'b--', 'LineWidth', 1.5, 'DisplayName', 'x_2');
plot(t, theta_hat, 'm', 'LineWidth', 1.5, 'DisplayName', 'observation');
yline(0.5, 'k', 'DisplayName', 'actual theta', 'LineWidth', 1.5); 

title('Χρονική Απόκριση των Καταστάσεων και της Εκτίμησης \theta');
xlabel('Χρόνος (t)');
ylabel('Τιμές');
legend;
grid on;
hold off;

