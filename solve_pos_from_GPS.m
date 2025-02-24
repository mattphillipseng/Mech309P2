% This code solves for position given the GPS Satellite data, an
% initial guess for the receiver's position, and the time

function  [soln_matrix] = solve_pos_from_GPS(meas_data,init_guess_pos,current_time);
%% GPS Satellite Data Separation 
meas_data_size = size(meas_data);
N_meas = meas_data_size(1,1);

sat_num = 1;
while (sat_num <= N_meas)
    % Position Data
    a_sat = meas_data(sat_num,3); % a
    e_sat = meas_data(sat_num,4); % e
    Omega_sat = meas_data(sat_num,5); % Omega
    inc_sat = meas_data(sat_num,6); % inc
    omega_orbit_sat = meas_data(sat_num,7); % omega_orbit
    t0_sat =  meas_data(sat_num,8); % t0
    
    [sat_R,sat_V] = orbit_propagation(a_sat,e_sat,Omega_sat,inc_sat,omega_orbit_sat,t0_sat,current_time);
    GPS_sat_positions(sat_num,:) = sat_R';
    
    % Pseudorange Data
    pseudoranges(sat_num,:) = meas_data(sat_num,1);
    
    % Standard Deviation Data
    S_devs(sat_num,:) = meas_data(sat_num,2);
    
    % Bias Data
    GPS_biases(sat_num,:) = meas_data(sat_num,9);
    

    sat_num = sat_num + 1;
end

%% Getting ready for non-linear least squares
init_receiver_bias = 0; % set to 0, or whatever you want the initial guess to be

% append the receiver bias initial guess to the position initial guess
soln_matrix = [init_guess_pos;init_receiver_bias];

%Generate weight matrix for sat data at each time step
Weight_matrix = Weight_matrix_gen(S_devs);

%% Non-Lin Least Squares Iteration
iters = 1;
err = 100; % just to enter the while loop

% Will stop when norm of error is within 0.1m, or at 100 iterations
while (err>0.1) && (iters<=50)
    soln_pos = soln_matrix(1:3); % Only positions of the receiver, excludes the receiver bias. 
    
    A_matrix = A_matrix_gen(GPS_sat_positions, soln_pos);
    b_matrix = b_matrix_gen(GPS_sat_positions, soln_matrix, pseudoranges, GPS_biases); % is actually b-f(X)    
    
    delta = inv(A_matrix'*A_matrix)*A_matrix'*Weight_matrix*b_matrix;
    soln_matrix = soln_matrix + delta;

    % Needs to be double-checked
    %error_matrix = b_matrix - (A_matrix*delta);
    %err = norm(error_matrix);
    
    err = norm(delta);
    
    iters = iters +1;
end
iters;
soln_matrix;
