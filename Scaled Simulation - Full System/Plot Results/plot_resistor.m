%% Clear stuff
clear variables; clc;

%% import stuff
load("sup_res.mat");

%% Load vars
time=ans(1,:);
i_conv=ans(2,:);
v_stair=ans(3,:);
i_sup1=ans(4,:);
i_sup2=ans(5,:);
i_sup3=ans(6,:);
i_sup4=ans(7,:);
v_in2=ans(8,:);
v_in3=ans(9,:);

res_graph=figure();
set(res_graph,'position',[100,100,700,1100]);
res_graph_tiles=tiledlayout(3,1);
res_graph_tiles.TileSpacing = 'compact';
res_graph_tiles.Padding = 'compact';
xlabel(res_graph_tiles,"Time (s)",fontsize=17);
title(res_graph_tiles,"Simulation Of Energy Storage",fontsize=19);
subtitle(res_graph_tiles,'Constant Input Current = 25A',fontsize=14);

tl1=nexttile([2 1]);
plot(time,i_sup1,LineWidth=3);
hold on;
grid on;
plot(time,i_sup2,LineWidth=3);
plot(time,i_sup3,LineWidth=3);
plot(time-5e-4,i_sup4,LineWidth=4,LineStyle="--",color='#77AC30');
title(tl1,"Load Resistor Current",fontsize=15);
lgnd1=legend('0.32Ω','0.65Ω','1.15Ω','Combo',fontsize=15,location='northwest');

axis(tl1,[0 0.9 0 102.5]);
ylabel(tl1,'Current (Ampere)',fontsize=15);
title(lgnd1,'Resistor');
yticks(tl1,0:10:110);

tl2=nexttile;
plot(time,v_stair,LineWidth=3,color="#0072BD");
hold on;
plot(time,v_stair,LineWidth=3,color="#0072BD");
title(tl2,"Resistor Voltage",fontsize=15);
axis(tl2,[0 0.9 12.5 42.5]);
grid on;
ylabel(tl2,'Voltage (Volt)',fontsize=15);
plot(tl2,time,v_in2,LineWidth=3,LineStyle="--",color="#D95319");
plot(tl2,time,v_in3,LineWidth=3,LineStyle="--",color="#EDB120");
lgnd2=legend('DC Supply','0.32Ω','0.65Ω','1.15Ω',fontsize=15,location='southeast');
title(lgnd2,'Resistor');
saveas(res_graph,'res_graph.svg');
