function output=pi_control_2(input, reference, kp, ki,clock)
    persistent last_time;
    persistent error_sum;

    if isempty(last_time)
        last_time=0;
    end
    if isempty(error_sum)
        error_sum=0;
    end

    now=clock;
    time_change=now-last_time;
    error=reference-input;
    error_sum=error_sum+(error*time_change);

    output=kp*error+ki*error_sum;
    output=min(max(output,0.2),0.8);
    last_time=now;
    
end
