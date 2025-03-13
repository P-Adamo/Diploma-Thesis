function [mode,stop_all]=conv_mode_curr_limiter(dc_link_curr,conv_curr,conv_buck_min,conv_boost_min,main_bat_max_curr,total_curr_max,low_bat_status)
bat_curr=abs(dc_link_curr)-abs(conv_curr);

if (dc_link_curr>=total_curr_max)||(bat_curr>=main_bat_max_curr) %main checker
    mode=0;
    stop_all=1;


elseif dc_link_curr<0 && abs(dc_link_curr)>conv_buck_min %begin regen checks
        if low_bat_status<2 && bat_curr<=main_bat_max_curr%if low side battery not full, begin charging
            mode=1;
            stop_all=0;
        elseif low_bat_status==2 && bat_curr<=main_bat_max_curr
            mode=0;
            stop_all=0;
        else
            mode=0;
            stop_all=1;
        end

elseif dc_link_curr>0 && abs(dc_link_curr)>conv_boost_min%begin discharge checks
    if low_bat_status>0 %if low side battery is full, begin discharging
        mode=2;
        stop_all=0;
    else %if low side battery is empty, do nothing
        mode=0;
        stop_all=0;
    end
     

else %current is too little, do nothing
    mode=0;
    stop_all=0;
end

