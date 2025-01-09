% Sliding mode control law
function [u, s] = sliding_control(q, q_dot, qd, q_dot_d, lambda_gain, m1, m2, ml, lc1, lc2, l1, l2, I1, I2, g)
    e = q - qd;
    e_dot = q_dot - q_dot_d;
    s = e_dot + lambda_gain * e;
    
    H = compute_H(q, m1, m2, ml, lc1, lc2, l1, l2, I1, I2);
    C = compute_C(q, q_dot, m2, ml, lc2, l1, l2);
    g_term = compute_g(q, m1, m2, ml, lc1, lc2, l1, l2, g);

    % Equivalent control
    u_eq = -H \ (C * q_dot + g_term + lambda_gain * q_dot);

    % Sliding control gain
    rho = 10;  
    u = u_eq - rho * sign(s);
end