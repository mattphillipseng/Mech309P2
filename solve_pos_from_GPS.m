% This code solves for position given the GPS Satellite data, and an
% initial guess for the receiver's position

function  [soln_matrix] = solve_pos_from_GPS(meas_data,init_guess_pos);
%% GPS Satellite Data Separation 
sat_data_size = size(sat_data);
N_meas = sat_data_size(1,1);

sat_num = 1;
while (sat_num <= N_meas)
    % Position Data
    a_sat = meas_data(sat_num,3); % a
    e_sat = meas_data(sat_num,4); % e
    Omega_sat = meas_data(sat_num,5); % Omega
    inc_sat = meas_data(sat_num,6); % inc
    omega_orbit_sat = meas_data(sat_num,7); % omega_orbit
    t0_sat =  meas_data(sat_num,8); % t0

    GPS_sat_positions(sat_num,:) = orbit_propagation(a_sat,e_sat,Omega_sat,inc_sat,omega_orbit_sat,t0_sat,t(lv1));
    
    % Pseudorange Data
    pseudoranges(sat_num,:) = meas_data(sat_num,1);
    
    % Standard Deviation Data
    S_devs(sat_num,:) = meas_data(sat_num,2);
    
    % Bias Data
    GPS_bias(sat_num,:) = meas_data(sat_num,9);
    

    sat_num = sat_num + 1;
end


%% Getting ready for non-linear least squares
A_matrix = A_matrix_gen(GPS_sat_positions, init_guess_pos);

init_receiver_bias = 0; % set to 0, or whatever you want the initial guess to be

% append the receiver bias initial guess to the position initial guess
soln_matrix = [init_guess_pos;init_receiver_bias]; 

b_matrix - 













soln_matrix = init_guess_pos*1.5; %for now, delete later