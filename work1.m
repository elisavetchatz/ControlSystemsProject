K = 5; 
T = 0.2; 
time_span = [0 3]; 

initial_conditions = [-2, 0; 1, 0; 0, 0.5; 2, 2; 2.5, -1; 1.1, 2];

input_types = {'step', 'ramp'};

% Βήμα εισόδου
step_input = 0.5;
ramp_input = @(t) 1.2 * t;

num_conditions = size(initial_conditions, 1);

figure;

for j = 1:length(input_types)
    for i = 1:size(initial_conditions, 1)
   
        % Προσομοίωση με ode45
        [t, states] = ode45(@(t, x) linear_system(t, x, K, T, input_types{j}), time_span, initial_conditions(i, :));

        % Δημιουργία υποδιαγράμματος
        subplot(ceil(num_conditions / 2), 2, i); % Οργάνωση subplots σε δύο στήλες
        plot(t, states(:, 1), 'LineWidth', 1.5); % Απόκριση y
        hold on;
        plot(t, step_input * ones(size(t)), '--', 'LineWidth', 1.2); % Αναφορά
        xlabel('Χρόνος (s)');
        ylabel('Απόκριση');
        legend('y(t)', 'r(t)', 'Location', 'best');
        title(['Αρχ. Συνθ.: y(0) = ', num2str(initial_conditions(i, 1)), ', y''(0) = ', num2str(initial_conditions(i, 2))]);
        grid on;
    end 
    sgtitle(['Αποκρίσεις Συστήματος για Διάφορες Αρχικές Συνθήκες', ...
             ' Για εισοδο ', string(input_types{j})]);
end


















%     [t, states] = ode45(@(t, x) linear_system(t, x, K, T, step_input, input_types(1)), time_span, initial_conditions(i, :));

%     subplot(ceil(num_conditions / 2), 2, i); % δύο στήλες
%     plot(t, states(:, 1), 'LineWidth', 1.5); % Απόκριση y
%     hold on;
%     plot(t, step_input * ones(size(t)), '--', 'LineWidth', 1.2); % Αναφορά
%     xlabel('Χρόνος (s)');
%     ylabel('Απόκριση');
%     legend('y(t)', 'r(t)', 'Location', 'best');
%     title(['Αρχ. Συνθ.: y(0) = ', num2str(initial_conditions(i, 1)), ', y''(0) = ', num2str(initial_conditions(i, 2))]);
%     grid on;
% end

% sgtitle('Αποκρίσεις Συστήματος για Διάφορες Αρχικές Συνθήκες'); 









% % Ράμπα εισόδου

% ramp_input = @(t) 1.2 * t;

% figure;
% num_conditions = size(initial_conditions, 1);

% for i = 1:num_conditions
%     % Προσομοίωση με ode45
%     [t, states] = ode45(@(t, x) linear_system(t, x, K, T, ramp_input, 'ramp'), time_span, initial_conditions(i, :));
    
%     subplot(ceil(num_conditions / 2), 2, i); % Οργάνωση subplots σε δύο στήλες
%     plot(t, states(:, 1), 'LineWidth', 1.5); % Απόκριση y
%     hold on;
%     plot(t, ramp_input(t), '--', 'LineWidth', 1.2); % Αναφορά
%     xlabel('Χρόνος (s)');
%     ylabel('Απόκριση');
%     legend('y(t)', 'r(t)', 'Location', 'best');
%     title(['Αρχ. Συνθ.: y(0) = ', num2str(initial_conditions(i, 1)), ', y''(0) = ', num2str(initial_conditions(i, 2))]);
%     grid on;
% end

% sgtitle('Αποκρίσεις Συστήματος για Ράμπα Εισόδου'); 


