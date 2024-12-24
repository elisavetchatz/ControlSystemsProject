function xdot = linear_system(t, x, K, T, B)
    
    x1 = 1.2 *t - x(1);
    x2 = 1.2 - x(2);

    x1dot = x2;
    x2dot  = (1/T) * B - (1/T) * x2 - (K/T) * x1;
    
   xdot = [x1dot; x2dot];
end