function dxdt = linear_system_ramp(t, x, K, T, ramp_input)
    y = x(1);
    y_dot = x(2);
    
    % Δυναμική συστήματος
    r = ramp_input(t);
    dydt = y_dot;
    dy_dot_dt = -(1/T) * y_dot - (K/T) * y + (K/T) * r;
    
    dxdt = [dydt; dy_dot_dt];
end