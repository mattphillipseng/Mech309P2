function  [Weight_matrix] = Weight_matrix_gen(S_devs);

% GPS_sat_positions is a 6x3 matrix
S_devs_size = size(S_devs);
num_sats = S_devs_size(1,1); % should be 6 for the given test data

lv1 = 1;
sum = 0;
while (lv1<=num_sats)
   sum = sum + S_devs(lv1);
   
   lv1 = lv1 +1;
end
sum

% Pre-allocate
Weight_matrix = zeros(num_sats,num_sats);

lv2 = 1;
while (lv2<=num_sats)
    weight = abs(sum - S_devs(lv2))/sum; %normalized
    Weight_matrix(lv2,lv2) = weight;
    
    lv2 = lv2 +1;
end
Weight_matrix