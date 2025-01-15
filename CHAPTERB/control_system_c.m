function dxdt = control_system_c(t, x)

    theta0 = x(3);
    theta_tilde  = 0.5 - theta0;
    x1dot = -x(1) + x(2);
    x2dot = -x(1) + theta_tilde*x(2)^2;
    theta_tilde_dot = +5*x(2)^3 - 2*x(2)^2*x(1);

    dxdt = [x1dot; x2dot; theta_tilde_dot];

end