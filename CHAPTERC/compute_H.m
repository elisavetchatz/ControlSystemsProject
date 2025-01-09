% Functions for dynamic terms of the robotic arm
function H = compute_H(q, m1, m2, ml, lc1, lc2, l1, l2, I1, I2)
    q1 = q(1);
    q2 = q(2);
    h11 = m1 * lc1^2 + m2 * (lc2^2 + l1^2 + 2 * l1 * lc2 * cos(q2)) + ml * (l2^2 + l1^2 + 2 * l1 * l2 * cos(q2)) + I1 + I2;
    h12 = m2 * lc2 * (lc2 + l1 * cos(q2)) + ml * l2 * (l2 + l1 * cos(q2)) + I2;
    h22 = m2 * lc2^2 + ml * l2^2 + I2;
    H = [h11, h12; h12, h22];
end