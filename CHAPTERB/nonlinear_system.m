function xdot = nonlinear_system(t, x, K, T, B, e0, alpha)
   
    if e0 < 0.2
        a = alpha;
    else
        a = 1;
    end

    x1dot = x(2);
    x2dot  = (1/T) * B - (1/T) * x(2) - a*(K/T) * x(1);
    
    xdot = [x1dot; x2dot];
end
