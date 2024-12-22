function xdot = control_system(t, x, K, theta_hat)

    x1dot = -x(1) + x(2);
    x2dot  = -x(1) - K * x + (1/2 - theta_hat)*x(2)^2;
    
   xdot = [x1dot; x2dot];
end