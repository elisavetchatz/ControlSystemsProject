K = 5;
T = 0.2;
B = 0.5;
e0 = 0.2;
alpha = 0.05;
time_span = [0 3];
initial_conditions = [-2, 0; 1, 0; 0, 0.5; 2, 2; 2.5, -1; 1.1, 2];

num_conditions = size(initial_conditions, 1);

% figure;
for i = 1:num_conditions
    [t, states] = ode45(@(t, x) nonlinear_system(t, x, K, T, B, e0, alpha), time_span, initial_conditions(i, :));
    
    figure;
    subplot(1, 2, 1);
    plot(t, states(:, 1), 'Color', 'green', 'LineStyle', ':', 'LineWidth', 2);
    hold on;
    plot(t, states(:, 2), 'Color', 'blue', 'LineStyle', '--', 'LineWidth', 2); 
    hold off;
    xlabel('Χρόνος (s)');
    ylabel('Τιμές των x_1 και x_2');
    legend('x_1', 'x_2');
    title([' Απόκριση των καταστάσεων x_1 και x_2 για r = 1.2t | ',...
            'x_1(0) = ', num2str(initial_conditions(i, 1)), ', x_2(0) = ', num2str(initial_conditions(i, 2))]);
    
    subplot(1, 2, 2);
    plot(states(:, 1), states(:, 2), 'Color', 'red', 'LineWidth', 2);
    xlabel('x_1');
    ylabel('x_2');
    title(['Φασικό Πορτρέτο των καταστάσεων x_1 και x_2  για r = 0.5t | ',...
            'x_1(0) = ', num2str(initial_conditions(i, 1)), ', x_2(0) = ', num2str(initial_conditions(i, 2))]);
    grid on;

    %r, y plot

    %unit
    % subplot(3, 2, i);
    % yline(0.5, 'Color', 'black', 'LineStyle', ':', 'LineWidth', 2); %r
    % hold on;
    % y = 0.5 - states(:, 1); 
    % plot(t, y, 'Color', [1, 0.647, 0], 'LineStyle', '-', 'LineWidth', 2);% y
    % hold off;
    % xlabel('Χρόνος (s)');
    % ylabel('r, y');
    % legend('r', 'y');
    % title(['x_1(0) = ', num2str(initial_conditions(i, 1)), ', x_2(0) = ', num2str(initial_conditions(i, 2))]);

    % %ramp
    % subplot(3, 2, i);
    % plot(t, B*t, 'Color', 'black', 'LineStyle', ':', 'LineWidth', 2); %r
    % hold on;
    % y = B*t - states(:, 1);
    % plot(t, y, 'Color', [1, 0.647, 0], 'LineStyle', '-', 'LineWidth', 2);% y
    % hold off;
    % xlabel('Χρόνος (s)');
    % ylabel('r, y');
    % legend('r', 'y');
    % title(['x_1(0) = ', num2str(initial_conditions(i, 1)), ', x_2(0) = ', num2str(initial_conditions(i, 2))]);


end

%unit
% sgtitle(['Aπόκριση του συστήματος σε βηματική',... 
%          ' είσοδο r = 0.5 και έξοδο y = r - e']);

% %ramp
% sgtitle(['Aπόκριση του συστήματος σε ράμπα',... 
%          ' είσοδο r = 0.5t και έξοδο y = r - e']);