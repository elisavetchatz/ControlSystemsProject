function xdot = control_system_a(t, x, K)

    x1dot = -x(1) + x(2);
    x2dot  = (-1-K(1))*x(1) - K(2)*x(2);
    
   xdot = [x1dot; x2dot];
end