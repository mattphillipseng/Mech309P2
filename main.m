%% MECH 309 Mini-Project 2

% Modified by Matthew Phillips
% Student ID: 260689202

% Modified by Jarred Brown
% Student ID: 260688463

close all
clear all
clc

% Format of output
    % format short
    format long

%% orbital constants
orbital_constants

%% Load Data
load('MECH309_MP2_data.mat');

whos

%return % comment this out

%% Solve for velocity given two positions at two times
[rg1,vg1] = find_v_given_position_data(r_g_at_t1,r_g_at_t2,t1,t2);

%% Solve for orbital elements
% Note, this function ``orbital_elements" is NOT the same as in MP1; this
% one outputs Delta_t, and not t0.
[a,e,Omega,inc,omega_orbit,Delta_t0] = orbital_elements(rg1,vg1);
t0 = t(1) - Delta_t0;
orbs_theoretical = [a,e,Omega,inc,omega_orbit,t0]

% To find t0, need to subtract the time the first radar meas was taken from
% Delta_t0
t0 = Delta_t0 - t1;

% Period
T = 2*pi*sqrt(a^3/cst.mu1);

%% Solve for position given GPS measurments
lv1 = 1;
while(lv1 <= length(t)) % length(t)
    
    % Initial guess from orbit propagation
    [R_orbit,V_orbit] = orbit_propagation(a,e,Omega,inc,omega_orbit,t0,t(lv1));
    
    % Extract measurment data
    meas_data = measurements(:,:,lv1); % only take measurements for this time step
    
    %meas_data_size = size(meas_data);
    %N_meas = meas_data_size(1,1);
    
    % This matrix used for plotting
    SC_r_g_initial_hat(lv1,:) = R_orbit; % Initial estimate of the receiver position, from orbit propagation
    
    % Estimate of the receiver position, from GPS data
    solution = solve_pos_from_GPS(meas_data,R_orbit,t(lv1));
    
    SC_r_g_hat(lv1,:) = solution(1:3); %just the X,Y,Z positions
    bias_hat(lv1) = solution(4);
    
    b_error(lv1) = 1;
    
    % Update counters
    lv1 = lv1 + 1;
end

%% Find orbital elements from GPS position data
R1_gps = [SC_r_g_hat(1,1) ; SC_r_g_hat(1,2) ; SC_r_g_hat(1,3)];
R2_gps = [SC_r_g_hat(2,1) ; SC_r_g_hat(2,2) ; SC_r_g_hat(2,3)];

[R1_gps,V1_gps] = find_v_given_position_data(R1_gps,R2_gps,t(1),t(2));
[a_gps,e_gps,Omega_gps,inc_gps,omega_orbit_gps,Delta_t0_gps] = orbital_elements(R1_gps,V1_gps);
t0_gps = Delta_t0_gps - t(1);

orbs_gps = [a_gps,e_gps,Omega_gps,inc_gps,omega_orbit_gps,t0_gps]

%% Plot results
plot_script_v1;
