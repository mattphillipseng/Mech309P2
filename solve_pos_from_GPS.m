% This code solves for position given the GPS Satellite data, and an
% initial guess

function  [receiver_pos] = solve_pos_from_GPS(GPS_sat_positions,initial_pos_guess);

% sat_data_size = size(sat_data);
% N_meas = sat_data_size(1,1);

receiver_pos = initial_pos_guess;
A_matrix = A_matrix_gen(GPS_sat_positions, receiver_pos);












receiver_pos = initial_pos_guess*1.5; %for now, delete later