function dxdt = nonlinear_system(t, x, K, T, e0, alpha, input_func)
    y = x(1);
    y_dot = x(2);
    r = input_func(t);
    e = r - y;

    % Συνάρτηση κέρδους N(s)
    if abs(e) <= e0
        N = alpha;
    else
        N = 1;
    end

    % Δυναμική συστήματος
    dydt = y_dot;
    dy_dot_dt = -(1/T) * y_dot - (N * K / T) * y + (N * K / T) * r;
    
    dxdt = [dydt; dy_dot_dt];
end
