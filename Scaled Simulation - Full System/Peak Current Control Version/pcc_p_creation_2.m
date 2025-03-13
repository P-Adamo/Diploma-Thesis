function Q = pcc_p_creation_2(set_sig,conv_i_out,conv_i_ref)
    persistent Q_feed;
    persistent enable_out;
    if isempty(Q_feed)
        Q_feed=0;
    end
    if isempty(enable_out)
        enable_out=0;
    end

    conv_i_ref=abs(conv_i_ref);
    conv_i_out=abs(conv_i_out);
    if conv_i_out>=conv_i_ref
        res_sig=1;
    else
        res_sig=0;
    end
    
    if set_sig==0 && res_sig==0 && enable_out==0
        Q=Q_feed;
    elseif set_sig==0 && res_sig==0 && enable_out==1
        Q=1;
    elseif set_sig==0 && res_sig==1
        Q=0;
        enable_out=0;
    elseif set_sig==1 && res_sig==0
        Q=0;
        enable_out=1;
    else 
        Q=0;
    end
    Q_feed=Q;
    

