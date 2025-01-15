%rr(t) = 1.2t
close all;

K  = 5;
T = 0.2;
B = 1.2;
time_span = [0 3]; 
initial_conditions = [-2, 0; 1, 0; 0, 0.5; 2, 2; 2.5, -1; 1.1, 2]; %y, y'
colors = ['r', 'g', 'b', 'm', 'c', 'y'];
num_conditions = size(initial_conditions, 1);

for i = 1:num_conditions
    
    x1 = - initial_conditions(i, 1);
    x2 = B - initial_conditions(i, 2);

    [t, states] = ode45(@(t, x) linear_system_r(t, x, K, T, B), time_span, [x1, x2]);
    %disp(states);
    
    %Καταστάσεις συναρτήσει χρόνου
    figure;
    plot(t, states(:, 1), 'Color', colors(i), 'LineWidth', 2);
    hold on;
    plot(t, states(:, 2), '--', 'Color', colors(i), 'LineWidth', 2); 

    plot(t, 1.2*t, 'Color', 'black', 'LineStyle', ':', 'LineWidth', 2); %r

    y = 1.2*t - states(:, 1);
    plot(t, y, 'Color', [1, 0.647, 0], 'LineStyle', '-', 'LineWidth', 2);% y

    hold off;
    xlabel('Χρόνος (s)');
    ylabel('Τιμές των x_1 και x_2, y, r');
    legend('x_1', 'x_2', 'r', 'y');
    title([' Απόκριση των καταστάσεων x_1 και x_2 | ',...
            'x_1(0) = ',  num2str(x1), ', x_2(0) = ', num2str(x2)]);
    
    %φασικό πορτρέτο
    figure;
    plot(states(:, 1), states(:, 2), 'Color', colors(i), 'LineWidth', 2);
    xlabel('x_1');
    ylabel('x_2');
    title(['Φασικό Πορτρέτο των καταστάσεων x_1 και x_2 | ',...
            'x_1(0) = ', num2str(x1), ', x_2(0) = ', num2str(x2)]);
    grid on;

end
