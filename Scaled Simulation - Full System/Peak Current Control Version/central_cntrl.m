function [m1_p,m2_p,m3_p,m4_p,stop_all,pcc_1,pcc_2,mode,i_ind_ref]=central_cntrl(i_dc_link,v_dc_link,v_sc,i_ind_1,i_ind_2,pcc_1_clk,pcc_2_clk,low_bat_soc)
%% Set Variables

low_bat_max_soc=90;
low_bat_min_soc=35;

buck_min_curr_ind=8;
buck_max_curr_ind=25;

boost_min_curr_ind=7.5;
boost_max_curr_ind=15;

main_bat_max_curr=30;

total_curr_max=50;

buck_curr_ratio=80;
boost_curr_ratio=60;

enable_synch_mode=1;

%% Select Converter Mode and check for overcurrents
conv_curr_high_side=((i_ind_1+i_ind_2)*v_sc/v_dc_link);
conv_buck_min=buck_min_curr_ind*v_sc/v_dc_link;
conv_boost_min=boost_min_curr_ind*v_sc/v_dc_link;

if low_bat_soc<=low_bat_min_soc
    low_bat_status=0;%low side battery is empty and ready to charge
elseif low_bat_soc>=low_bat_max_soc
    low_bat_status=2;%low side battery is not empty or fully charged. Ready to charge/discharge
else
    low_bat_status=1;%low side battery is full. Ready to discharge
end

[mode,stop_all]=conv_mode_curr_limiter(i_dc_link,conv_curr_high_side,conv_buck_min,conv_boost_min,main_bat_max_curr,total_curr_max,low_bat_status);


%% Calculate Inductor Reference Currents
i_ind_ref = calc_ind_ref(i_dc_link,v_dc_link,v_sc,buck_max_curr_ind,buck_min_curr_ind,boost_max_curr_ind,boost_min_curr_ind,buck_curr_ratio,boost_curr_ratio,mode);

%% PCC Pulse Creation
pcc_1 = pcc_p_creation_1(pcc_1_clk,i_ind_1,i_ind_ref);
pcc_2 = pcc_p_creation_2(pcc_2_clk,i_ind_2,i_ind_ref);

%% Route PCC Signals
[m1_p,m2_p,m3_p,m4_p] = route_pcc_signals(pcc_1,pcc_2,mode,enable_synch_mode);