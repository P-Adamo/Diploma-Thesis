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
set(cur_ref_ind,'position',[100,100,700,800]);
cur_ref_ind_tiles=tiledlayout(3,1);
cur_ref_ind_tiles.TileSpacing = 'compact';
cur_ref_ind_tiles.Padding = 'compact';
xlabel(cur_ref_ind_tiles,"Χρόνος (s)",fontsize=15,FontName='Verdana');
title(cur_ref_ind_tiles,"Έλεγχος ρεύματος πηνίων - Ανάκτηση/Υποβιβασμός",fontsize=17,FontName='Verdana');
subtitle(cur_ref_ind_tiles,'Σταθερό ρεύμα DC ζυγού: 10A',fontsize=13,FontName='Verdana');

tl2=nexttile;
plot(tl2,time,v_low,LineWidth=3);
grid on;
title(tl2,'Τάση χαμηλής πλευράς',fontsize=15,FontName='Verdana');
axis(tl2,[0 0.9 12.5 42.5]); 
ylabel(tl2,'Τάση (V)',fontsize=15,FontName='Verdana');

tl1=nexttile([2 1]);
plot(tl1,time,-i_ref,LineWidth=3.5);
hold on;
grid on
plot(tl1,time,-i_l1,LineWidth=3);
plot(tl1,time,-i_l2,LineWidth=3,LineStyle="--");
ylabel('Ρεύμα (A)',fontsize=15,FontName='Verdana');
axis(tl1,[0 0.9 -20 -5]); 
legend(tl1,'Αναφορά','Πηνίο 1','Πηνίο 2',fontsize=12,location='southeast',FontName='Verdana');
yticks(tl1,-20:1:0);
title(tl1,'Ρεύμα χαμηλής πλευράς',fontsize=15,FontName='Verdana');

saveas(cur_ref_ind,'cur_ref_ind.svg');

%% Full System Current Plot
cur_flow=figure();
set(cur_flow,'position',[0,-100,640,700]);
cur_flow_tiles=tiledlayout(3,1);
cur_flow_tiles.TileSpacing = 'compact';
cur_flow_tiles.Padding = 'compact';
xlabel(cur_flow_tiles,"Χρόνος (s)",fontsize=14,FontName='Verdana');
title(cur_flow_tiles,"Ροή ρεύματος στο σύστημα - Ανάκτηση/Υποβιβασμός",fontsize=15,FontName='Verdana');

tl2=nexttile;
yyaxis right;
plot(tl2,time,abs(i_conv_high./i_dclink)*100,LineWidth=2.5,LineStyle=":");
ytickformat(tl2,"percentage");
axis(tl2,[0 0.9 50 100]);
yticks(tl2,0:10:100);
grid on;
yyaxis left;
plot(tl2,time,v_low,LineWidth=3);
title(tl2,'Τάση χαμηλής πλευράς / ποσοστό καταμοιρασμού',fontsize=14,FontName='Verdana');
axis(tl2,[0 0.9 12.5 42.5]); 
ylabel(tl2,'Τάση (V)',fontsize=15,FontName='Verdana');
legend(tl2,'Τάση','Ποσοστό',fontsize=12,location='southeast',FontName='Verdana');

tl1=nexttile([2 1]);
plot(tl1,time,i_low_bat,LineWidth=3);
hold on;
plot(tl1,time,i_conv_high,LineWidth=3);
plot(tl1,time,i_high_bat,LineWidth=3);
axis(tl1,[0 0.9 -40 0]);
yticks(tl1,-50:2.5:11);
ylabel("Ρεύμα (A)",fontsize=14,FontName='Verdana');
grid on;
legend(tl1,'Αποθήκευση_χ_α_μ_η_λ_ή','Μετατροπέας_υ_ψ_η_λ_ή','Αποθήκευση_υ_ψ_η_λ_ή',fontsize=12,location='southeast',FontName='Verdana');
title(tl1,'Ρεύματα (Ρεύμα Ανάκτησης=10Α)',fontsize=14,FontName='Verdana');

saveas(cur_flow,'cur_flow.svg');

