function C = compute_C(q, q_dot, m2, ml, lc2, l1, l2)
    q1 = q(1);
    q2 = q(2);
    q1_dot = q_dot(1);
    q2_dot = q_dot(2);
    c11 = -l1 * (m2 * lc2 + ml * l2) * sin(q2) * q2_dot;
    c12 = -l1 * (m2 * lc2 + ml * l2) * sin(q2) * (q1_dot + q2_dot);
    c21 = l1 * (m2 * lc2 + ml * l2) * sin(q2) * q1_dot;
    c22 = 0;
    C = [c11, c12; c21, c22];
end