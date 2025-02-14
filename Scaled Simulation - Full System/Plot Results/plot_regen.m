%% Clear stuff
clear variables; clc;

%% import stuff
load("main_regen_b.mat");

%% Load vars
time=ans(1,:);
i_l2=ans(2,:);
i_l1=ans(3,:);
i_ref=ans(4,:);
i_low_bat=ans(5,:);
i_dclink=ans(6,:);
i_conv_high=ans(7,:);
i_high_bat=ans(8,:);
v_high=ans(9,:);
v_low=ans(10,:);

%% Current Reference Plot
cur_ref_ind=figure();
set(cur_ref_ind,'position',[100,100,700,900]);
cur_ref_ind_tiles=tiledlayout(2,1);
cur_ref_ind_tiles.TileSpacing = 'compact';
cur_ref_ind_tiles.Padding = 'compact';
xlabel(cur_ref_ind_tiles,"Time (s)",fontsize=17);
title(cur_ref_ind_tiles,"PI Current Control Of Inductors - Buck/Regen. Mode",fontsize=17);

tl1=nexttile([1 1]);
plot(tl1,time,-i_ref,LineWidth=3.5);
hold on;
grid on
plot(tl1,time,-i_l1,LineWidth=3);
plot(tl1,time,-i_l2,LineWidth=3,LineStyle="--");
ylabel('Current (Ampere)',fontsize=15);
axis(tl1,[0 0.9 -20 -5]); 
legend(tl1,'Reference','Inductor 1','Inductor 2',fontsize=14,location='southeast');
yticks(tl1,-20:2.5:0);
title(tl1,'Low Side Current',fontsize=16);
subtitle(tl1,'Constant DC Link Current: 10A',fontsize=13);

tl2=nexttile;
plot(tl2,time,v_low,LineWidth=3);
grid on;
title(tl2,'Low Side Voltage',fontsize=16);
subtitle(tl2,'Constant DC Link Current: 10A',fontsize=13);
axis(tl2,[0 0.9 12.5 42.5]); 
ylabel(tl2,'Voltage (Volt)',fontsize=15);

saveas(cur_ref_ind,'cur_ref_ind.svg');

%% Full System Current Plot
cur_flow=figure();
set(cur_flow,'position',[0,-100,750,1000]);
cur_flow_tiles=tiledlayout(3,1);
cur_flow_tiles.TileSpacing = 'compact';
cur_flow_tiles.Padding = 'compact';
xlabel(cur_flow_tiles,"Time (s)",fontsize=17);
title(cur_flow_tiles,"Full System Current Flow - Buck/Regen. Mode",fontsize=17);

tl1=nexttile([2 1]);
plot(tl1,time,i_low_bat,LineWidth=3);
hold on;
plot(tl1,time,i_conv_high,LineWidth=3);
plot(tl1,time,-i_dclink,LineWidth=3);
plot(tl1,time,i_high_bat,LineWidth=3);
axis(tl1,[0 0.9 -40 11]);
yticks(tl1,-50:2.5:11);
ylabel("Current (Ampere)",fontsize=14);
grid on;
plot(tl1,[0 1],[0 0],color='black',LineWidth=1);
legend(tl1,'Low Side - Storage_l_o_w','High Side','DC Link','Storage_h_i_g_h','',fontsize=14,location='southeast');
title(tl1,'Current Flow',fontsize=17);
subtitle(tl1,'Constant DC Link Current: 10A',fontsize=13);


tl2=nexttile;

yyaxis right;
plot(tl2,time,abs(i_conv_high./i_dclink)*100,LineWidth=2.5,LineStyle="--");
ytickformat(tl2,"percentage");
axis(tl2,[0 0.9 0 100]);
yticks(tl2,0:10:100);
grid on;
yyaxis left;
plot(tl2,time,v_low,LineWidth=3);
title(tl2,'Low Side Voltage and Current Sharing Ratio',fontsize=16);
subtitle(tl2,'Constant DC Link Current: 10A',fontsize=13);
axis(tl2,[0 0.9 12.5 42.5]); 
ylabel(tl2,'Voltage (Volt)',fontsize=15);
legend(tl2,'Low Side Voltage','Converter Ratio',fontsize=14,location='southeast');

saveas(cur_flow,'cur_flow.svg');

