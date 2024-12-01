% Συνάρτηση Δυναμικής Συμπεριφοράς
function dxdt = linear_system(t, x, K, T, r, input_type)
    % Κατάσταση x = [y; y_dot]
    y = x(1);
    y_dot = x(2);

    if strcmp(input_type, 'ramp')
        r = input(t);
    end

    dydt = y_dot;
    dy_dot_dt = -(1/T) * y_dot - (K/T) * y + (K/T) * r;
    
    % Διανυσματική έξοδος
    dxdt = [dydt; dy_dot_dt];
end