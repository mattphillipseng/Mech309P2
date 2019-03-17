%% This is actually the delta b matrix

function  [b_matrix] = b_matrix_gen(GPS_sat_positions, soln_matrix, pseudoranges, GPS_biases);

%% Prep work
% Figure out how many satellites we have
pseudoranges_size = size(pseudoranges);
num_sats = pseudoranges_size(1,1);

% Pre-allocale size of b_matrix
b_matrix = ones(num_sats,1);

%% Build matrix
lv1 = 1;
while (lv1 <= num_sats)
    X_diff = GPS_sat_positions(lv1,1) - soln_matrix(1);
    Y_diff = GPS_sat_positions(lv1,2) - soln_matrix(2);
    Z_diff = GPS_sat_positions(lv1,3) - soln_matrix(3);
    
    dist = sqrt((X_diff)^2 + (Y_diff)^2 + (Z_diff)^2);
    pseudo = pseudoranges(lv1);
    GPS_bias = GPS_biases(lv1);
    
    b_matrix(lv1,1) = pseudo - dist + GPS_bias;
    
    lv1 = lv1 +1;
           
end