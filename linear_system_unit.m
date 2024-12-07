function xdot = linear_system_unit(t, x, T, K)

    x1dot = x(2);
    x2dot = -(1/T) * x(2) - (K/T) * x(1);
    
    xdot = [x1dot; x2dot];
end