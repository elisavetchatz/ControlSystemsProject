function xdot = nonlinear_system_r(t, x, K, T, B, e0, alpha)
   
    if abs(x(1))<e0
        a = alpha;
    else
        a = 1;
    end

    x1dot = x(2);
    x2dot  = - (1/T) * x(2) - a*(K/T) * x(1) + (1/T) * B ;
    
    xdot = [x1dot; x2dot];
end