function g_term = compute_g(q, m1, m2, ml, lc1, lc2, l1, l2, g)
    q1 = q(1);
    q2 = q(2);
    g1 = (m2 * lc2 + ml * l2) * g * cos(q1 + q2) + (m2 * l1 + ml * l1 + m1 * lc1) * g * cos(q1);
    g2 = (m2 * lc2 + ml * l2) * g * cos(q1 + q2);
    g_term = [g1; g2];
end