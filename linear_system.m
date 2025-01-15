% Συνάρτηση Δυναμικής Συμπεριφοράς
function [xdot] = linear_system(t, x, K, T, input_type)

    % Δυναμική του Συστήματος
    % x: Διάνυσμα καταστάσεων (x(1) = y, x(2) = y_dot)
    % r: Είσοδος αναφοράς (σταθερή ή συνάρτηση του χρόνου)
    % input_type: Τύπος εισόδου ('step' ή 'ramp')

    %Επιστρέφει τις παραγώγους των καταστάσεων

    x1 = x(1);
    x2 = x(2);

    if strcmp(input_type, 'ramp')
        rdot = 1.2;
    elseif strcmp(input_type, 'step')
        rdot = 0;
    end

    rddot = 0;

    x1dot = x2;
    x2dot = -(1/T) * x2 - (K/T) * x1 + (1/T) * rdot + rddot ;
    
    xdot = [x1dot; x2dot];

end
