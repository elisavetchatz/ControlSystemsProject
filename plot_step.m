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


    y_t = states(:, 1); % Απόκριση y στο πεδίο του χρόνου 
    
    % FFT για την απόκριση
    N = length(t); % Αριθμός σημείων
    dt = mean(diff(t)); % Βήμα χρόνου
    f = (0:N-1) / (N * dt); % Διανύσματα συχνοτήτων
    Y_f = abs(fft(y_t)); % Μέτρο του FFT

    % Δημιουργία υποδιαγράμματος για το πεδίο της συχνότητας
    subplot(num_conditions, 2, 2*i);
    plot(f, Y_f, 'LineWidth', 1.5); % FFT μέτρο
    xlabel('Συχνότητα (Hz)');
    ylabel('|FFT(y)|');
    title(['FFT: y(0) = ', num2str(initial_conditions(i, 1)), ', y''(0) = ', num2str(initial_conditions(i, 2))]);
    grid on;

end

% Προσαρμογή της διάταξης για καλύτερη εμφάνιση
sgtitle('Αποκρίσεις Συστήματος για Διάφορες Αρχικές Συνθήκες'); % Συνολικός τίτλος



