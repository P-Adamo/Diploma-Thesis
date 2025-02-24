%% Clear Stuff
clearvars;clc;

%% Load Vars
I_high_2A_boost=2;
V_high_2A_boost=80;
V_low_2A_boost=[20 25 30 35 40];
I_low_bat_2A_boost=[9.84 7.78 5.81 5.05 4.28];
I_high_bat_2A_boost=[2.13 2.14 2.01 2.02 1.99];
Ieff_2A_boost=(V_high_2A_boost*I_high_bat_2A_boost)./(V_low_2A_boost.*I_low_bat_2A_boost);

I_high_4A_boost=4;
V_high_4A_boost=80;
V_low_4A_boost=[20 25 30 35 40];
I_low_bat_4A_boost=[18.74 14.38 12.31 10.15 8.68];
I_high_bat_4A_boost=[3.94 3.98 3.99 4 3.99];
Ieff_4A_boost=(V_high_4A_boost*I_high_bat_4A_boost)./(V_low_4A_boost.*I_low_bat_4A_boost);

%%
boost_v_a_and_curr_ratio=figure();
set(boost_v_a_and_curr_ratio,'position',[100,100,700,1000]);
boost_v_a_and_curr_ratio_tiles=tiledlayout(4,1);
boost_v_a_and_curr_ratio_tiles.TileSpacing = 'compact';
boost_v_a_and_curr_ratio_tiles.Padding = 'compact';
xlabel(boost_v_a_and_curr_ratio_tiles,"Low Side Voltage (V)",fontsize=15);
title(boost_v_a_and_curr_ratio_tiles,"Experiment Measurements: Boost Mode",fontsize=16);
subtitle(boost_v_a_and_curr_ratio_tiles,'High Side: 80V / Negative Load - Low Side: Increasing Voltage',fontsize=15);

tl1=nexttile([2 1]);
hold on;
grid on;
s1=scatter(tl1,V_low_2A_boost,I_low_bat_2A_boost,LineWidth=2,MarkerEdgeColor="#0072BD");
s2=scatter(tl1,V_low_4A_boost,I_low_bat_4A_boost,LineWidth=2,MarkerEdgeColor="#D95319");
    
p1=plot(tl1,V_low_2A_boost,I_low_bat_2A_boost,LineWidth=3,color="#0072BD");
p2=plot(tl1,V_low_4A_boost,I_low_bat_4A_boost,LineWidth=3,color="#D95319");

lgnd1=legend(tl1,[p1,p2],'2A','4A',fontsize=13,location='southeast');
title(lgnd1,{'High Side', 'Reference'},fontsize=12);
axis(tl1,[19 41 0 19]);
yticks(0:1:30);
xticks(0:2.5:40);
title(tl1,'Low Side Current',fontsize=14);
ylabel(tl1,'Current (A)',fontsize=14);
set(tl1, 'XDir','reverse');

%%
tl2=nexttile;
hold on;
grid on;

sr1=scatter(tl2,V_low_2A_boost,I_high_bat_2A_boost,LineWidth=2,MarkerEdgeColor="#0072BD");
sr2=scatter(tl2,V_low_4A_boost,I_high_bat_4A_boost,LineWidth=2,MarkerEdgeColor="#D95319");

pr1=plot(tl2,V_low_2A_boost,I_high_bat_2A_boost,LineWidth=3,color="#0072BD");
pr2=plot(tl2,V_low_4A_boost,I_high_bat_4A_boost,LineWidth=3,color="#D95319");

title(tl2,'High Side Current',fontsize=14);
axis(tl2,[19 41 0 4.5]);
yticks(0:0.5:5);
xticks(0:2.5:40);
set(tl2, 'XDir','reverse');

%%
tl3=nexttile;
hold on;
grid on;
se1=scatter(tl3,V_low_2A_boost,100*Ieff_2A_boost,LineWidth=2,MarkerEdgeColor="#0072BD");
se2=scatter(tl3,V_low_4A_boost,100*Ieff_4A_boost,LineWidth=2,MarkerEdgeColor="#D95319");

pe1=plot(tl3,V_low_2A_boost,100*Ieff_2A_boost,LineWidth=3,color="#0072BD");
pe2=plot(tl3,V_low_4A_boost,100*Ieff_4A_boost,LineWidth=3,color="#D95319");

title(tl3,'Converter Efficiency',fontsize=14);
ytickformat(tl3,"percentage");
axis(tl3,[19 41 82.5 100]);
yticks(0:2.5:100);
xticks(0:2.5:40);
set(tl3, 'XDir','reverse');

saveas(boost_v_a_and_curr_ratio,'boost_v_a_and_curr_ratio.svg');