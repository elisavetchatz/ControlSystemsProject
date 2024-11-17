% Τιμές Παραμέτρων
K = 5; % Κέρδος
T = 0.2; % Χρονική σταθερά
time_span = [0 3]; % Διάστημα χρόνου προσομοίωσης

% Αρχικές συνθήκες
initial_conditions = [-2, 0; 1, 0; 0, 0.5; 2, 2; 2.5, -1; 1.1, 2];

% Βήμα εισόδου
step_input = 0.5;

% Δημιουργία του figure για τα subplots
figure;
num_conditions = size(initial_conditions, 1);

for i = 1:num_conditions
    % Προσομοίωση με ode45
    [t, states] = ode45(@(t, x) linear_system(t, x, K, T, step_input), time_span, initial_conditions(i, :));
    
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

% Προσαρμογή της διάταξης για καλύτερη εμφάνιση
sgtitle('Αποκρίσεις Συστήματος για Διάφορες Αρχικές Συνθήκες'); % Συνολικός τίτλος

% Ράμπα εισόδου
ramp_input = @(t) 1.2 * t;

% Δημιουργία του figure για τα subplots
figure;
num_conditions = size(initial_conditions, 1);

for i = 1:num_conditions
    % Προσομοίωση με ode45
    [t, states] = ode45(@(t, x) linear_system_ramp(t, x, K, T, ramp_input), time_span, initial_conditions(i, :));
    
    % Δημιουργία υποδιαγράμματος
    subplot(ceil(num_conditions / 2), 2, i); % Οργάνωση subplots σε δύο στήλες
    plot(t, states(:, 1), 'LineWidth', 1.5); % Απόκριση y
    hold on;
    plot(t, ramp_input(t), '--', 'LineWidth', 1.2); % Αναφορά
    xlabel('Χρόνος (s)');
    ylabel('Απόκριση');
    legend('y(t)', 'r(t)', 'Location', 'best');
    title(['Αρχ. Συνθ.: y(0) = ', num2str(initial_conditions(i, 1)), ', y''(0) = ', num2str(initial_conditions(i, 2))]);
    grid on;
end

% Προσαρμογή της διάταξης για καλύτερη εμφάνιση
sgtitle('Αποκρίσεις Συστήματος για Ράμπα Εισόδου'); % Συνολικός τίτλος

