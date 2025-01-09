
% System dynamics
function state_dot = robotic_arm_dynamics(t, state, qd, q_dot_d, lambda_gain, m1, m2, ml, lc1, lc2, l1, l2, I1, I2, g)
    q = state(1:2);
    q_dot = state(3:4);

    H = compute_H(q, m1, m2, ml, lc1, lc2, l1, l2, I1, I2);
    C = compute_C(q, q_dot, m2, ml, lc2, l1, l2);
    g_term = compute_g(q, m1, m2, ml, lc1, lc2, l1, l2, g);
    
    [u, ~] = sliding_control(q, q_dot, qd, q_dot_d, lambda_gain, m1, m2, ml, lc1, lc2, l1, l2, I1, I2, g);

    q_ddot = H \ (u - C * q_dot - g_term);
    state_dot = [q_dot; q_ddot];
end