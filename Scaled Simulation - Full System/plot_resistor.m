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
set(res_graph,'position',[100,100,650,1000]);
res_graph_tiles=tiledlayout(5,1);
res_graph_tiles.TileSpacing = 'compact';
res_graph_tiles.Padding = 'compact';
xlabel(res_graph_tiles,"Χρόνος (s)",fontsize=15,FontName='Verdana');
title(res_graph_tiles,"Προσομοίωση μέσου αποθήκευσης ενέργειας",fontsize=17,FontName='Verdana')
subtitle(res_graph_tiles,'Σταθερό ρεύμα εισόδου = 25A',fontsize=14,FontName='Verdana');

tl2=nexttile([2 1]);
plot(time,v_stair,LineWidth=3,color="#0072BD");
hold on;
plot(time,v_stair,LineWidth=3,color="#0072BD");
title(tl2,'Τάση Αντίστασης R_S_I_M',fontsize=15,FontName='Verdana');
axis(tl2,[0 0.9 12.5 42.5]);
grid on;
ylabel("Τάση (V)",fontsize=14,FontName='Verdana');
plot(tl2,time,v_in2,LineWidth=3,LineStyle="--",color="#D95319");
plot(tl2,time,v_in3,LineWidth=3,LineStyle="--",color="#EDB120");
lgnd2=legend('DC Τροφοδοσία','0.32Ω','0.65Ω','1.15Ω',fontsize=12,location='southeast',fontsize=15,FontName='Verdana');
title(lgnd2,'Αντίσταση',fontsize=12,FontName='Verdana');

tl1=nexttile([3 1]);
plot(time,i_sup1,LineWidth=3);
hold on;
grid on;
plot(time,i_sup2,LineWidth=3);
plot(time,i_sup3,LineWidth=3);
plot(time-5e-4,i_sup4,LineWidth=4.5,LineStyle="--",color='#77AC30');
title(tl1,'Ρεύμα Αντίστασης R_S_I_M',fontsize=15,FontName='Verdana');
lgnd1=legend('0.32Ω','0.65Ω','1.15Ω','Συνδυασμός',fontsize=12,location='northwest',FontName='Verdana');

axis(tl1,[0 0.9 0 102.5]);
title(lgnd1,'Αντίσταση',fontsize=12,FontName='Verdana');
ylabel('Ρεύμα (A)',fontsize=14,FontName='Verdana');
yticks(tl1,0:10:110);

saveas(res_graph,'res_graph.svg');

