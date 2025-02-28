%% Clear Stuff
clearvars;clc;

%% Load Vars
I_high_3A5_buck=3.5;
V_high_3A5_buck=80;
V_low_3A5_buck=[15 20 25 30 35 40];
I_low_bat_3A5_buck=[12.2 10.1 8.2 7.3 6.2 5.6];
I_high_bat_3A5_buck=[0.79 0.64 0.55 0.52 0.6 0.52];
I_high_conv_3A5_buck=I_high_3A5_buck-I_high_bat_3A5_buck;
Iratio_3A5_buck=I_high_conv_3A5_buck/I_high_3A5_buck;
Ieff_3A5_buck=(V_low_3A5_buck.*I_low_bat_3A5_buck)./(V_high_3A5_buck*I_high_conv_3A5_buck);

I_high_5A5_buck=5.5;
V_high_5A5_buck=80;
V_low_5A5_buck=[15 20 25 30 35 40];
I_low_bat_5A5_buck=[18.9 15 11.9 10.5 9.2 8.1];
I_high_bat_5A5_buck=[1.24 1.21 1.3 1.16 1.14 1.16];
I_high_conv_5A5_buck=I_high_5A5_buck-I_high_bat_5A5_buck;
Iratio_5A5_buck=I_high_conv_5A5_buck/I_high_5A5_buck;
Ieff_5A5_buck=(V_low_5A5_buck.*I_low_bat_5A5_buck)./(V_high_5A5_buck*I_high_conv_5A5_buck);

I_high_7A5_buck=7.5;
V_high_7A5_buck=80;
V_low_7A5_buck=[15 20 25 30 35 40];
I_low_bat_7A5_buck=[24.6 18.8 15.8 13.8 12 10.8];
I_high_bat_7A5_buck=[1.74 1.83 1.85 1.74 1.72 1.68];
I_high_conv_7A5_buck=I_high_7A5_buck-I_high_bat_7A5_buck;
Iratio_7A5_buck=I_high_conv_7A5_buck/I_high_7A5_buck;
Ieff_7A5_buck=(V_low_7A5_buck.*I_low_bat_7A5_buck)./(V_high_7A5_buck*I_high_conv_7A5_buck);

I_high_9A5_buck=9.5;
V_high_9A5_buck=80;
V_low_9A5_buck=[15 20 25 30 35 40];
I_low_bat_9A5_buck=[30.2 23.8 20 16.9 14.8 13.3];
I_high_bat_9A5_buck=[2.34 2.16 2.16 2.28 2.28 2.32];
I_high_conv_9A5_buck=I_high_9A5_buck-I_high_bat_9A5_buck;
Iratio_9A5_buck=I_high_conv_9A5_buck/I_high_9A5_buck;
Ieff_9A5_buck=(V_low_9A5_buck.*I_low_bat_9A5_buck)./(V_high_9A5_buck*I_high_conv_9A5_buck);

%%
buck_v_a_and_curr_ratio=figure();
set(buck_v_a_and_curr_ratio,'position',[100,100,700,1100]);
buck_v_a_and_curr_ratio_tiles=tiledlayout(4,1);
buck_v_a_and_curr_ratio_tiles.TileSpacing = 'compact';
buck_v_a_and_curr_ratio_tiles.Padding = 'compact';
xlabel(buck_v_a_and_curr_ratio_tiles,"Τάση Χαμηλής Πλευράς (V)",fontsize=15,FontName='Verdana');
title(buck_v_a_and_curr_ratio_tiles,"Πειραματικές Μετρήσεις: Λειτουργία Υποβάθμισης",fontsize=16,FontName='Verdana');

tl1=nexttile([2 1]);
hold on;
grid on;
s1=scatter(tl1,V_low_3A5_buck,I_low_bat_3A5_buck,LineWidth=2,MarkerEdgeColor="#0072BD");
s2=scatter(tl1,V_low_5A5_buck,I_low_bat_5A5_buck,LineWidth=2,MarkerEdgeColor="#D95319");
s3=scatter(tl1,V_low_7A5_buck,I_low_bat_7A5_buck,LineWidth=2,MarkerEdgeColor="#EDB120");
s4=scatter(tl1,V_low_9A5_buck,I_low_bat_9A5_buck,LineWidth=2,MarkerEdgeColor="#7E2F8E");
    
p1=plot(tl1,V_low_3A5_buck,I_low_bat_3A5_buck,LineWidth=3,color="#0072BD");
p2=plot(tl1,V_low_5A5_buck,I_low_bat_5A5_buck,LineWidth=3,color="#D95319");
p3=plot(tl1,V_low_7A5_buck,I_low_bat_7A5_buck,LineWidth=3,color="#EDB120");
p4=plot(tl1,V_low_9A5_buck,I_low_bat_9A5_buck,LineWidth=3,color="#7E2F8E");

lgnd1=legend(tl1,[p1,p2,p3,p4],'3.5A','5.5A','7.5A','9.5A',fontsize=13,location='northeast',FontName='Verdana');
title(lgnd1,'Φορτίο DC Ζυγού',fontsize=11,FontName='Verdana');
axis([14 41 0 31]);
yticks(0:2:30);
xticks(0:2.5:40);
title(tl1,'Ρεύμα Χαμηλής Πλευράς',fontsize=15,FontName='Verdana');
ylabel(tl1,'Ρεύμα (A)',fontsize=14,FontName='Verdana');

%%
tl2=nexttile;
hold on;
grid on;

sr1=scatter(tl2,V_low_3A5_buck,100*Iratio_3A5_buck,LineWidth=2,MarkerEdgeColor="#0072BD");
sr2=scatter(tl2,V_low_5A5_buck,100*Iratio_5A5_buck,LineWidth=2,MarkerEdgeColor="#D95319");
sr3=scatter(tl2,V_low_7A5_buck,100*Iratio_7A5_buck,LineWidth=2,MarkerEdgeColor="#EDB120");
sr4=scatter(tl2,V_low_9A5_buck,100*Iratio_9A5_buck,LineWidth=2,MarkerEdgeColor="#7E2F8E");

pr1=plot(tl2,V_low_3A5_buck,100*Iratio_3A5_buck,LineWidth=3,color="#0072BD");
pr2=plot(tl2,V_low_5A5_buck,100*Iratio_5A5_buck,LineWidth=3,color="#D95319");
pr3=plot(tl2,V_low_7A5_buck,100*Iratio_7A5_buck,LineWidth=3,color="#EDB120");
pr4=plot(tl2,V_low_9A5_buck,100*Iratio_9A5_buck,LineWidth=3,color="#7E2F8E",LineStyle="-");

title(tl2,'Αναλογία καταμερισμού ρεύματος',fontsize=15,FontName='Verdana');
ytickformat(tl2,"percentage");
axis(tl2,[14 41 70 100]);
yticks(0:5:100);
xticks(0:2.5:40);

%%
tl3=nexttile;
hold on;
grid on;
se1=scatter(tl3,V_low_3A5_buck,100*Ieff_3A5_buck,LineWidth=2,MarkerEdgeColor="#0072BD");
se2=scatter(tl3,V_low_5A5_buck,100*Ieff_5A5_buck,LineWidth=2,MarkerEdgeColor="#D95319");
se3=scatter(tl3,V_low_7A5_buck,100*Ieff_7A5_buck,LineWidth=2,MarkerEdgeColor="#EDB120");
se4=scatter(tl3,V_low_9A5_buck,100*Ieff_9A5_buck,LineWidth=2,MarkerEdgeColor="#7E2F8E");

pe1=plot(tl3,V_low_3A5_buck,100*Ieff_3A5_buck,LineWidth=3,color="#0072BD");
pe2=plot(tl3,V_low_5A5_buck,100*Ieff_5A5_buck,LineWidth=3,color="#D95319");
pe3=plot(tl3,V_low_7A5_buck,100*Ieff_7A5_buck,LineWidth=3,color="#EDB120");
pe4=plot(tl3,V_low_9A5_buck,100*Ieff_9A5_buck,LineWidth=3,color="#7E2F8E",LineStyle="-");

title(tl3,'Απόδοση Μετατροπέα',fontsize=15,FontName='Verdana');
ytickformat(tl3,"percentage");
axis(tl3,[14 41 77.5 100]);
yticks(0:5:100);
xticks(0:2.5:40);

saveas(buck_v_a_and_curr_ratio,'buck_v_a_and_curr_ratio.svg');