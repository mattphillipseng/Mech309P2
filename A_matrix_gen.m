function  [A_matrix] = A_matrix_gen(GPS_sat_positions, receiver_pos);

sat_data_size = size(GPS_sat_positions);
N_meas = sat_data_size(1,1);

A_matrix = ones(N_meas,4);

lv_row = 1;
lv_col = 1;
while (lv_row <= N_meas)
    X_diff = receiver_pos(1) - GPS_sat_positions(lv_row,1);
    Y_diff = receiver_pos(2) - GPS_sat_positions(lv_row,2);
    Z_diff = receiver_pos(3) - GPS_sat_positions(lv_row,3);    
    
    dist = sqrt((X_diff)^2 + (Y_diff)^2 + (Z_diff)^2);
    
    lv_col = 1;
    while(lv_col <= 3) % only go to 3rd col, last col should be 1's, and was already allocated
        numerator = receiver_pos(lv_col) - GPS_sat_positions(lv_row,lv_col);
       
        A_matrix(lv_row,lv_col) = -(numerator/dist);
       
        lv_col = lv_col+1;
   end
   lv_row = lv_row+1;
end