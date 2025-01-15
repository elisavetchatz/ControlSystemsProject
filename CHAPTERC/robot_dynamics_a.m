function dxdt = robot_dynamics_a(t, x)

     xd = [pi/2; -pi/3]; % Επιθυμητές Θέσεις

     x11 = x(1); x12 = x(2); % Θέσεις
     x21 = x(3); x22 = x(4); % Ταχύτητες
     x1 = [x11; x12]; % Θέσεις
     x2 = [x21; x22]; % Ταχύτητες

     m1 = 6; m2 = 4; ml = 0.5;
     lc1 = 0.2; lc2 = 0.1;
     l1 = 0.5; l2 = 0.4;
     I1 = 0.43; I2 = 0.05;
     g = 9.81;
 
     H = [m1*lc1^2 + m2*(lc2^2 + l1^2 + 2*l1*lc2*cos(x(2))) + ml*(l2^2 + l1^2 + 2*l1*l2*cos(x(2))) + I1 + I2, m2*lc2*(lc2 + l1*cos(x(2))) + ml*l2*(l2 + l1*cos(x(2))) + I2;
          m2*lc2*(lc2 + l1*cos(x(2))) + ml*l2*(l2 + l1*cos(x(2))) + I2, lc2^2*m2 + l2^2*ml + I2];
 
     C = [-l1*(m2*lc2 + ml*l2)*sin(x(2))*x(4), -l1*(m2*lc2 + ml*l2)*sin(x(2))*(x(3) + x(4));
          l1*(m2*lc2 + ml*l2)*sin(x(2))*x(3), 0];
 
     g = [(m2*lc2 + ml*l2)*g*cos(x(1) + x(2)) + (m2*l1 + ml*l1 + m1*lc1)*g*cos(x(1));
          (m2*lc2 + ml*l2)*g*cos(x(1) + x(2))];
 
     % Estimation
     lc1_hat = 0.25; lc2_hat = 0.175; I1_hat = 0.26; I2_hat = 0.08; ml_hat = 1;

     H_est = [m1*lc1_hat^2 + m2*(lc2_hat^2 + l1^2 + 2*l1*lc2_hat*cos(x(2))) + ml_hat*(l2^2 + l1^2 + 2*l1*l2*cos(x(2))) + I1_hat + I2_hat, m2*lc2_hat*(lc2_hat + l1*cos(x(2))) + ml_hat*l2*(l2 + l1*cos(x(2))) + I2_hat;
               m2*lc2_hat*(lc2_hat + l1*cos(x(2))) + ml_hat*l2*(l2 + l1*cos(x(2))) + I2_hat, lc2_hat^2*m2 + l2^2*ml_hat + I2_hat];
 
     C_est = [-l1*(m2*lc2_hat + ml_hat*l2)*sin(x(2))*x(4), -l1*(m2*lc2_hat + ml_hat*l2)*sin(x(2))*(x(3) + x(4));
              l1*(m2*lc2_hat + ml_hat*l2)*sin(x(2))*x(3), 0];
     
     g_est = [(m2*lc2_hat + ml_hat*l2)*g*cos(x(1) + x(2))+(m2*l1 + ml_hat*l1 + m1*lc1_hat)*g*cos(x(1));(m2*lc2_hat + ml_hat*l2)*g*cos(x(1)+x(2))];
     g_est = g_est(1:2, :); 

     lc1_min = 0.1;
     lc1_max = 0.4;
     lc2_min = 0.05;
     lc2_max = 0.3;
     I1_min = 0.02;
     I1_max = 0.5;
     I2_min = 0.01; 
     I2_max = 0.15;
     ml_min = 0;
     ml_max = 2;

     Hmin = [m1*lc1_min^2 + m2*(lc2_min^2 + l1^2 + 2*l1*lc2_min*cos(x(2))) + ml_min*(l2^2 + l1^2 + 2*l1*l2*cos(x(2))) + I1_min + I2_min, m2*lc2_min*(lc2_min + l1*cos(x(2))) + ml_min*l2*(l2 + l1*cos(x(2))) + I2_min;
             m2*lc2_min*(lc2_min + l1*cos(x(2))) + ml_min*l2*(l2 + l1*cos(x(2))) + I2_min, lc2_min^2*m2 + l2^2*ml_min + I2_min];
     Cmax = [-l1*(m2*lc2_max + ml_max*l2)*sin(x(2))*x(4), -l1*(m2*lc2_max + ml_max*l2)*sin(x(2))*(x(3) + x(4));
             l1*(m2*lc2_max + ml_max*l2)*sin(x(2))*x(3), 0];
     gmax = [(m2*lc2_max + ml_max*l2)*g*cos(x(1) + x(2)) + (m2*l1 + ml_max*l1 + m1*lc1_max)*g*cos(x(1));
             (m2*lc2_max + ml_max*l2)*g*cos(x(1) + x(2))];
     gmax = gmax(1:2, :);

     lambda = 10;
     c = 0.1;
 
    rho = lambda * sqrt(x21^2 + x22^2) + norm(H_est - Hmin) + sqrt(x21^2 + x22^2) * norm(Cmax - C_est) + norm(gmax - g_est) + c;
    ueq = -(lambda * (H_est * x2)) + (C_est * x2) + g_est;

    step = 10000;
    u = ueq;
    e0 = 0.0001;

     for i = 1:2
        s = x(2+i) + lambda * (x(i) - xd(i));

         if s <= e0 || s >= -e0
             u(i) = ueq(i) - rho * step * s;
         elseif s > e0
             u(i) = ueq(i) - rho;
         else
             u(i) = ueq(i) + rho;
         end
     end

     dxdt = zeros(4, 1);
     dxdt(1:2) = x(3:4); 
     dxdt(3:4) = -H \ ((C * x(3:4)) + g - u);

 end
 
 