function xdot = system(t, x)
    
    x1dot = -x(1) + x(2);
    x2dot  = -x(1); % + x(1)*x(2) + 0.5*x(2)^2;
    
   xdot = [x1dot; x2dot];
end