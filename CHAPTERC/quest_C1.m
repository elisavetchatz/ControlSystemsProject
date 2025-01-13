% Ρυθμίσεις ODE
options = odeset('Refine', 1, 'RelTol', 1e-7, 'AbsTol', 1e-8, 'MaxStep', 0.1);
tspan = [0 1];
x0 = [pi/3; pi/3; 0; 0]; % Αρχικές συνθήκες: q1, q2, dq1, dq2

% Εκτέλεση της ODE
[t, states] = ode15s(@robot_dynamics, tspan, x0, options);

% Επιθυμητές τιμές
q1_desired = pi/2 * ones(length(t), 1); % q1 επιθυμητή
q2_desired = -pi/3 * ones(length(t), 1); % q2 επιθυμητή

% Ονομασίες διαγραμμάτων
plot_titles = {
    'Φασικό Πορτραίτο (q_1, dq_1)', ...
    'Φασικό Πορτραίτο (q_2, dq_2)', ...
    'Απόκριση Θέσης στον Χρόνο', ...
    'Απόκριση Ταχύτητας στον Χρόνο', ...
    'Σφάλμα Θέσης στον Χρόνο'};

plot_labels = {
    {'q_1', 'dq_1'}, ...
    {'q_2', 'dq_2'}, ...
    {'t(s)', 'Θέση (rad)'}, ...
    {'t(s)', 'Ταχύτητα (rad/s)'}, ...
    {'t(s)', 'Σφάλμα Θέσης'}};

% Δεδομένα για διαγράμματα
plots_data = {
    {states(:, 1), states(:, 3)}, ... % q1, dq1
    {states(:, 2), states(:, 4)}, ... % q2, dq2
    {t, [states(:, 1), states(:, 2), q1_desired, q2_desired]}, ... % q1, q2, q1_desired, q2_desired
    {t, [states(:, 3), states(:, 4)]}, ... % dq1, dq2
    {t, [states(:, 1) - q1_desired, states(:, 2) - q2_desired]} ... % Σφάλματα θέσης
};

colors = ['r', 'g', 'b', 'm'];
line_styles = {'b-', 'b--', 'm-', 'm--'};
error_styles = {'r-', 'r--'};

% Δημιουργία Διαγραμμάτων
for i = 1:length(plot_titles)
    figure();
    hold on;
    data = plots_data{i};
    if i <= 2 % Φασικά Πορτραίτα
        plot(data{1}, data{2}, 'LineWidth', 1.5);
        %scatter(data{1}, data{2}, 'filled');
    elseif i == 3 % Θέσεις
        for j = 1:size(data{2}, 2)
            plot(data{1}, data{2}(:, j), line_styles{j}, 'LineWidth', 1.5);
        end
    elseif i == 4 % Ταχύτητες
        for j = 1:size(data{2}, 2)
            plot(data{1}, data{2}(:, j), line_styles{j}, 'LineWidth', 1.5);
        end
    else % Σφάλματα Θέσης
        for j = 1:size(data{2}, 2)
            plot(data{1}, data{2}(:, j), error_styles{j}, 'LineWidth', 1.5);
        end
    end
    hold off;

    % Εμφάνιση Τίτλων και Υπομνημάτων
    title(plot_titles{i}, 'FontSize', 14);
    xlabel(plot_labels{i}{1}, 'FontSize', 12);
    ylabel(plot_labels{i}{2}, 'FontSize', 12);
    if i == 3
        legend({'q_1', 'q_2', 'q_{1d}', 'q_{2d}'}, 'FontSize', 10, 'Location', 'best');
    elseif i == 4
        legend({'dq_1', 'dq_2'}, 'FontSize', 10, 'Location', 'best');
    elseif i == 5
        legend({'e_1', 'e_2'}, 'FontSize', 10, 'Location', 'best');
    end
    grid on;
end
