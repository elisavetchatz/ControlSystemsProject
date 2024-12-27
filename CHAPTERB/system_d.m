function dxdt = system_d(t, x)

    P = [2, -1; -1, 3];
    B = [0; 1];
    x1dot = -x(1) + x(2);
    x2dot = -x(1) + x(1)*x(2) + 0.5*x(2)^2 -2 * sign(x' * P * B)*(x(1)^2 + x(2)^2);

    dxdt = [x1dot; x2dot];

end