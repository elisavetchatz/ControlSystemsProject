% Συνάρτηση Δυναμικής Ρομποτικού Βραχίονα
function dX = robot_dynamics(t, X, qd, qdd, lambda, k, m1, m2, l1, l2, lc1, lc2, g, I1, I2, ml)
     % Θέσεις και ταχύτητες
     q = X(1:2);       % Θέσεις
     q_dot = X(3:4);   % Ταχύτητες
 
     % Πίνακες H, C, G (πραγματικοί)
     H = [m1*lc1^2 + m2*(lc2^2 + l1^2 + 2*l1*lc2*cos(q(2))) + ml*(l2^2 + l1^2 + 2*l1*l2*cos(q(2))) + I1 + I2, ...
          m2*lc2^2 + m2*l1*lc2*cos(q(2)) + ml*l2^2 + ml*l1*l2*cos(q(2)) + I2;
          m2*lc2^2 + m2*l1*lc2*cos(q(2)) + ml*l2^2 + ml*l1*l2*cos(q(2)) + I2, ...
          m2*lc2^2 + ml*l2^2 + I2];
     
     C = [-l1*(m2*lc2 + ml*l2)*sin(q(2))*q_dot(2), -l1*(m2*lc2 + ml*l2)*sin(q(2))*(q_dot(1) + q_dot(2));
           l1*(m2*lc2 + ml*l2)*sin(q(2))*q_dot(1), 0];
       
     G = [(m2*lc2 + ml*l2)*g*cos(q(1) + q(2)) + (m2*l1 + ml*l1 + m1*lc1)*g*cos(q(1));
          (m2*lc2 + ml*l2)*g*cos(q(1) + q(2))];
 
     % Πίνακες H, C, G (εκτιμήσεις)
     lc1_est = 0.25; lc2_est = 0.175; I1_est = 0.26; I2_est = 0.08; ml_est = 1; % Εκτιμήσεις
     H_est = [m1*lc1_est^2 + m2*(lc2_est^2 + l1^2 + 2*l1*lc2_est*cos(q(2))) + ml_est*(l2^2 + l1^2 + 2*l1*l2*cos(q(2))) + I1_est + I2_est, ...
              m2*lc2_est^2 + m2*l1*lc2_est*cos(q(2)) + ml_est*l2^2 + ml_est*l1*l2*cos(q(2)) + I2_est;
              m2*lc2_est^2 + m2*l1*lc2_est*cos(q(2)) + ml_est*l2^2 + ml_est*l1*l2*cos(q(2)) + I2_est, ...
              m2*lc2_est^2 + ml_est*l2^2 + I2_est];
 
     C_est = [-l1*(m2*lc2_est + ml_est*l2)*sin(q(2))*q_dot(2), -l1*(m2*lc2_est + ml_est*l2)*sin(q(2))*(q_dot(1) + q_dot(2));
               l1*(m2*lc2_est + ml_est*l2)*sin(q(2))*q_dot(1), 0];
       
     G_est = [(m2*lc2_est + ml_est*l2)*g*cos(q(1) + q(2)) + (m2*l1 + ml_est*l1 + m1*lc1_est)*g*cos(q(1));
              (m2*lc2_est + ml_est*l2)*g*cos(q(1) + q(2))];
 
     % Επιφάνεια ολίσθησης
     e = q - qd;            % Σφάλμα θέσης
     s = q_dot + lambda * e; % Επιφάνεια ολίσθησης
 
     % Έλεγχος
     u = H_est * (-lambda * q_dot - k * sat(s)) + C_est * q_dot + G_est; % Νόμος ελέγχου με εκτιμήσεις
 
     % Εξισώσεις κίνησης
     q_ddot = H \ (u - C * q_dot - G); % Χρήση πραγματικών τιμών για τη δυναμική
     dX = [q_dot; q_ddot];
 end
 
 % Συνάρτηση κορεσμού
 function y = sat(x)
     % Συνάρτηση κορεσμού που περιορίζει τις τιμές σε [-1, 1]
     y = min(max(x, -1), 1);
 end
 