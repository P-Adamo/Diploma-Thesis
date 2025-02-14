function [duty1,stop_all,mode,i_ind_ref]=central_cntrl(i_dc_link,v_dc_link,v_sc,i_ind_1,i_ind_2,clock,kp, ki)
%% Set Variables

buck_min_curr_ind=0;
buck_max_curr_ind=25;

boost_min_curr_ind=0;
boost_max_curr_ind=20;

main_bat_max_curr=30;

total_curr_max=50;

buck_curr_ratio=80;
boost_curr=4;

% kp=0.02;
% ki=2.8;

%% Select Converter Mode and check for overcurrents
conv_curr_high_side=((i_ind_1+i_ind_2)*v_sc/v_dc_link);
conv_buck_min=buck_min_curr_ind*v_sc/v_dc_link;
conv_boost_min=boost_min_curr_ind*v_sc/v_dc_link;

[mode,stop_all]=conv_mode_curr_limiter(i_dc_link,conv_curr_high_side,conv_buck_min,conv_boost_min,main_bat_max_curr,total_curr_max);

%% Calculate Inductor Reference Currents
i_ind_ref = calc_ind_ref(i_dc_link,v_dc_link,v_sc,buck_max_curr_ind,buck_min_curr_ind,boost_max_curr_ind,boost_min_curr_ind,buck_curr_ratio,boost_curr,mode);

%% PCC Pulse Creation
duty1=pi_control_1((abs(i_ind_1)+abs(i_ind_2))/2, i_ind_ref, kp, ki,clock);
