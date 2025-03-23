close all;
save_path = 'C:\Users\chatz\ControlSystemsProject\CHAPTERB\figures';
if ~exist(save_path, 'dir')
    mkdir(save_path);
end

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

    plot_filename = sprintf('%sresponse_x1_x2_%d_%d.jpg', save_path, i);
        saveas(gcf, plot_filename, 'jpg');

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

    % phase_plot_filename = sprintf('%sphase_plot_x1_x2_%d_%d.jpg', save_path, i);
    %     saveas(gcf, phase_plot_filename, 'jpg');
end