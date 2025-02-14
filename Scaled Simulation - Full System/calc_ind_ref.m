function i_ind_ref = calc_ind_ref(i_dc_link,v_dc_link,v_sc,i_buck_max_high,i_buck_min_high,i_boost_ind_max,i_boost__ind_min,buck_curr_ratio,boost_curr,mode)
i_dc_link=abs(i_dc_link);

if mode==1
    i_ind_ref=0.9425*((i_dc_link*buck_curr_ratio/(100*2))*(v_dc_link/v_sc));
    i_ind_ref=i_ind_ref*(1+(v_sc-27.5)*0.0028);%compensate for non linearity
    if i_ind_ref>=i_buck_max_high
        i_ind_ref=i_buck_max_high;
    elseif i_ind_ref<i_buck_min_high
            i_ind_ref=i_buck_min_high;
    else 
    end
    
elseif mode==2
    i_ind_ref=(0.5*boost_curr*(v_dc_link/v_sc));
    if i_ind_ref>=i_boost_ind_max
        i_ind_ref=i_boost_ind_max;
    elseif i_ind_ref<i_boost__ind_min
            i_ind_ref=i_boost__ind_min;
    else 

    end
else
    i_ind_ref=0;
end