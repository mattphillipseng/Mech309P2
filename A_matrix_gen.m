function  [A_matrix] = A_matrix_gen(GPS_sat_positions, receiver_pos);

% GPS_sat_positions is a 6x3 matrix
sat_data_size = size(GPS_sat_positions)
sat_num = sat_data_size(1,1); % should be 6 for the given test data

A_matrix = ones(sat_num,4);

lv_row = 1;
lv_col = 1;
while (lv_row <= sat_num)
    X_diff = receiver_pos(1) - GPS_sat_positions(lv_row,1);
    Y_diff = receiver_pos(2) - GPS_sat_positions(lv_row,2);
    Z_diff = receiver_pos(3) - GPS_sat_positions(lv_row,3);    
    
    dist = sqrt((X_diff)^2 + (Y_diff)^2 + (Z_diff)^2);
    
    lv_col = 1;
    while(lv_col <= 3) % only go to 3rd col, last col should be 1's, and was already allocated
        numerator = receiver_pos(lv_col) - GPS_sat_positions(lv_row,lv_col);
       
        A_matrix(lv_row,lv_col) = -(numerator/dist); % Writes to A matrix
       
        lv_col = lv_col+1;
   end
   lv_row = lv_row+1;
end
