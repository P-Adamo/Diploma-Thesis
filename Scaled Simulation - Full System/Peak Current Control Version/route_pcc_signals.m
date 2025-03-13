function [m1_p,m2_p,m3_p,m4_p] = route_pcc_signals(pcc_1,pcc_2,mode,enable_synch_mode)

if mode==0
    m1_p=0;
    m2_p=0;
    m3_p=0;
    m4_p=0;
elseif mode==1
    m1_p=pcc_1;
    m2_p=(1-pcc_1)*(enable_synch_mode-1);
    m3_p=pcc_2;
    m4_p=(1-pcc_2)*(enable_synch_mode-1);
else
    m1_p=0;
    m2_p=pcc_1;
    m3_p=0;
    m4_p=pcc_2;
end