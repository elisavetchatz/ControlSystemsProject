K = 5; 
T = 0.2;
B = 1.2; %B = 0 for the unit step response
time_span = [0 100]; 
initial_conditions = [-2, 0; 1, 0; 0, 0.5; 2, 2; 2.5, -1; 1.1, 2];

num_conditions = size(initial_conditions, 1);

%figure;

for i = 1:num_conditions
    % Προσομοίωση με ode45 
    % t = πίνακας με τιμές του χρόνου για τις οποίες υπολογίστηκαν οι λύσεις, 
    %states = αντίστοιχες τιμές των χ1 και χ2 για καθε στιγμη, πίνακας με δλυο στήλες για χ1 και χ2

    [t, states] = ode45(@(t, x) linear_system(t, x, T, K, B), time_span, initial_conditions(i, :));
    %disp(states);
    
    figure;
    subplot(1, 2, 1);
    plot(t, states(:, 1), 'Color', 'green', 'LineStyle', ':', 'LineWidth', 2);
    hold on;
    plot(t, states(:, 2), 'Color', 'blue', 'LineStyle', '--', 'LineWidth', 2); 
    hold off;
    xlabel('Χρόνος (s)');
    ylabel('Τιμές των x_1 και x_2');
    legend('x_1', 'x_2');
    title([' Απόκριση των καταστάσεων x_1 και x_2 | ',...
            'x_1(0) = ', num2str(initial_conditions(i, 1)), ', x_2(0) = ', num2str(initial_conditions(i, 2))]);
    
    subplot(1, 2, 2);
    plot(states(:, 1), states(:, 2), 'Color', 'red', 'LineWidth', 2);
    xlabel('x_1');
    ylabel('x_2');
    title(['Φασικό Πορτρέτο των καταστάσεων x_1 και x_2 | ',...
            'x_1(0) = ', num2str(initial_conditions(i, 1)), ', x_2(0) = ', num2str(initial_conditions(i, 2))]);
    grid on;


    %r, y plot
% for step response
%     subplot(3, 2, i);
%     yline(0.5, 'Color', 'black', 'LineStyle', ':', 'LineWidth', 2); %r
%     hold on;
%     y = 0.5 - states(:, 1);
%     plot(t, y, 'Color', [1, 0.647, 0], 'LineStyle', '-', 'LineWidth', 2);% y
%     hold off;
%     xlabel('Χρόνος (s)');
%     ylabel('r, y');
%     legend('r', 'y');
%     title(['x_1(0) = ', num2str(initial_conditions(i, 1)), ', x_2(0) = ', num2str(initial_conditions(i, 2))]);

    %for ramp response
%     subplot(3, 2, i);
%     plot(t, 1.2*t, 'Color', 'black', 'LineStyle', ':', 'LineWidth', 2); %r
%     hold on;
%     y = 1.2*t - states(:, 1);
%     plot(t, y, 'Color', [1, 0.647, 0], 'LineStyle', '-', 'LineWidth', 2);% y
%     hold off;
%     xlabel('Χρόνος (s)');
%     ylabel('r, y');
%     legend('r', 'y');
%     title(['x_1(0) = ', num2str(initial_conditions(i, 1)), ', x_2(0) = ', num2str(initial_conditions(i, 2))]);

end

% sgtitle(['Aπόκριση του συστήματος σε βηματική',... 
%             ' είσοδο r = 0.5 και έξοδο y = r - e']);

% sgtitle(['Aπόκριση του συστήματος σε είσοδο',... 
%             ' ράμπας r = 1.2t και έξοδο y = r - e']);




