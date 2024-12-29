close all;

K  = 5;
T = 0.2;
B = [1.2, 0.04, 0.5];
e0 = 0.1;
alpha = 0.5;
time_span = [0 3]; 
initial_conditions = [-2, 0; 1, 0; 0, 0.5; 2, 2; 2.5, -1; 1.1, 2]; %y, y'
colors = ['r', 'g', 'b', 'm', 'c', 'y'];
num_conditions = size(initial_conditions, 1);

for i = 1:num_conditions
    for j = 1:length(B)
    
        x1 = - initial_conditions(i, 1);
        x2 = B(j) - initial_conditions(i, 2);

        [t, states] = ode45(@(t, x) nonlinear_system_r(t, x, K, T, B(j), e0, alpha), time_span, [x1, x2]);
    
        % Καταστάσεις συναρτήσει χρόνου
        figure;
        plot(t, states(:, 1), 'Color', colors(i), 'LineWidth', 2);
        hold on;
        plot(t, states(:, 2), '--', 'Color', colors(i), 'LineWidth', 2); 

        plot(t, B(j)*t, 'Color', 'black', 'LineStyle', ':', 'LineWidth', 2); % r

        y = B(j)*t - states(:, 1);
        plot(t, y, 'Color', [1, 0.647, 0], 'LineStyle', '-', 'LineWidth', 2); % y

        hold off;
        xlabel('Χρόνος (s)');
        ylabel('Τιμές των x_1 και x_2, y, r');
        legend('x_1', 'x_2', 'r', 'y');
        title([' Απόκριση καταστάσεων με r= ', num2str(B(j)), 't', ...
                'x_1(0) = ', num2str(x1), ', x_2(0) = ', num2str(x2)]);

        % save
        plot_filename = sprintf('response_x1_x2_%d_%d.jpg', i, j);
        saveas(gcf, plot_filename, 'jpg');
    
        % Φασικό πορτρέτο
        figure;
        plot(states(:, 1), states(:, 2), 'Color', colors(i), 'LineWidth', 2);
        xlabel('x_1');
        ylabel('x_2');
        title(['Φασικό Πορτρέτο καταστάσεων με r= ', num2str(B(j)), 't', ...
                'x_1(0) = ', num2str(x1), ', x_2(0) = ', num2str(x2)]);
        grid on;

        % Αποθήκευση του φασικού πορτρέτου σε αρχείο JPG
        phase_plot_filename = sprintf('phase_plot_x1_x2_%d_%d.jpg', i, j);
        saveas(gcf, phase_plot_filename, 'jpg');
    end
end
