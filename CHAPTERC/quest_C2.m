close all;

save_path = 'C:\Users\chatz\ControlSystemsProject\CHAPTERC\figures15.01';
if ~exist(save_path, 'dir')
    mkdir(save_path);
end

options = odeset('Refine', 1, 'RelTol', 1e-7, 'AbsTol', 1e-8, 'MaxStep', 0.1);
tspan = [0 1];
x0 = [pi/3; pi/3; 0; 0]; % Αρχικές συνθήκες: q1, q2, dq1, dq2

% Εκτέλεση της ODE
[t, states] = ode15s(@robot_dynamics_b, tspan, x0, options);

% Επιθυμητές τιμές
q1_desired = pi/4 + pi/6*sin(0.2*t*pi); % q1 επιθυμητή
q2_desired = -pi/3 + pi/3*cos(0.2*pi*t); % q2 επιθυμητή
q1dot_desired = pi^2/30*cos(0.2*pi*t); % dq1 επιθυμητή
q2dot_desired = -pi^2/15*sin(0.2*pi*t); % dq2 επιθυμητή

% Υπολογισμός επιφάνειας ολίσθησης
lambda = 10; % Παράμετρος ολίσθησης
e = [states(:, 1) - q1_desired, states(:, 2) - q2_desired]; % Σφάλμα θέσης
edot = [states(:, 3) - q1dot_desired, states(:, 4)-q2dot_desired]; % Σφάλμα ταχύτητας
s = edot + lambda * e; % Επιφάνεια ολίσθησης

% Ονομασίες διαγραμμάτων
plot_titles = {
    'Φασικό Πορτραίτο (e_1, de_1)', ...
    'Φασικό Πορτραίτο (e_2, de_2)', ...
    'Απόκριση Θέσης στον Χρόνο', ...
    'Απόκριση Ταχύτητας στον Χρόνο', ...
    'Σφάλμα Θέσης στον Χρόνο',...
    'Σφάλμα Ταχύτητας στον Χρόνο'};

plot_labels = {
    {'q_1', 'dq_1'}, ...
    {'q_2', 'dq_2'}, ...
    {'t(s)', 'Θέση (rad)'}, ...
    {'t(s)', 'Ταχύτητα (rad/s)'}, ...
    {'t(s)', 'Σφάλμα Θέσης'},...
    {'t(s)', 'Σφάλμα Ταχύτητας'}};

% Δεδομένα για διαγράμματα
plots_data = {
    {e(:, 1), edot(:, 1)}, ... % e1, edot1
    {e(:, 2), edot(:, 2)}, ... % e2, edot2
    {t, [states(:, 1), states(:, 2), q1_desired, q2_desired]}, ... % q1, q2, q1_desired, q2_desired
    {t, [states(:, 3), states(:, 4), q1dot_desired, q2dot_desired]}, ... % dq1, dq2
    {t, [states(:, 1) - q1_desired, states(:, 2) - q2_desired]} ... % Σφάλματα θέσης
    {t, [states(:, 3) - q1dot_desired, states(:, 4) - q2dot_desired]} ... % Σφάλματα ταχύτητας
};

colors = ['r', 'g', 'b', 'm'];
line_styles = {'b-', 'b--', 'm-', 'm--'};
error_styles = {'r-', 'r--', 'g-', 'g--'};

for i = 1:length(plot_titles)
    figure();
    hold on;
    data = plots_data{i};
    if i <= 2 % Φασικά Πορτραίτα
        plot(data{1}, data{2}, error_styles{1}, 'LineWidth', 2);
    elseif i == 3 % Θέσεις
        for j = 1:size(data{2}, 2)
            plot(data{1}, data{2}(:, j), line_styles{j}, 'LineWidth', 2);
        end
    elseif i == 4 % Ταχύτητες
        for j = 1:size(data{2}, 2)
            plot(data{1}, data{2}(:, j), line_styles{j}, 'LineWidth', 2);
        end
    else % Σφάλματα Θέσης
        for j = 1:size(data{2}, 2)
            plot(data{1}, data{2}(:, j), error_styles{j}, 'LineWidth', 2);
        end
    end
    hold off;

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

    plot_filename = sprintf('%s3_time_%d.jpg', save_path, i);
    saveas(gcf, plot_filename, 'jpg');
end

% Δημιουργία διαγράμματος e, edot, και s
figure();
hold on;

% Φασικό πορτραίτο (e έναντι edot για κάθε q)
plot(e(:, 1), edot(:, 1), 'b-', 'LineWidth', 1.5); % q1: e1 vs edot1
plot(e(:, 2), edot(:, 2), 'r-', 'LineWidth', 1.5); % q2: e2 vs edot2
scatter(s(:, 1), s(:, 2), 'k', 'filled'); % Δείκτες για την επιφάνεια ολίσθησης

hold off;

% Ρυθμίσεις διαγράμματος
title('Σφάλμα Θέσης και Ταχύτητας, Επιφάνεια Ολίσθησης (s)', 'FontSize', 14);
xlabel('Σφάλμα Θέσης', 'FontSize', 12);
ylabel('Σφάλμα Ταχύτητας', 'FontSize', 12);
legend({'q_1: e vs dot(e)', 'q_2: e vs dot(e)', 's: Επιφάνεια Ολίσθησης'}, 'FontSize', 10, 'Location', 'best');
grid on;
