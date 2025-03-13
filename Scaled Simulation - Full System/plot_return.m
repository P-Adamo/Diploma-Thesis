%% Clear stuff
clear variables; clc;

%% import stuff
load("main_return_f.mat");
 
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
cur_ref_ind_return=figure();
set(cur_ref_ind_return,'position',[100,100,700,800]);
cur_ref_ind_return_tiles=tiledlayout(3,1);
cur_ref_ind_return_tiles.TileSpacing = 'compact';
cur_ref_ind_return_tiles.Padding = 'compact';
xlabel(cur_ref_ind_return_tiles,"Χρόνος (s)",fontsize=15,FontName='Verdana');
title(cur_ref_ind_return_tiles,"Έλεγχος ρεύματος πηνίων - Επιστροφή/Ανύψωση",fontsize=17,FontName='Verdana');
subtitle(cur_ref_ind_return_tiles,'Σταθερό ρεύμα DC ζυγού: -6A',fontsize=13,FontName='Verdana');

tl2=nexttile;
plot(tl2,time,v_low,LineWidth=3);
grid on;
title(tl2,'Τάση χαμηλής πλευράς',fontsize=15,FontName='Verdana');
axis(tl2,[0 0.9 12.5 42.5]); 
ylabel(tl2,'Τάση (V)',fontsize=15,FontName='Verdana');

tl1=nexttile([2 1]);
plot(tl1,time,i_ref+0.05,LineWidth=3.5);
hold on;
grid on
plot(tl1,time,-i_l1-0.1,LineWidth=3);
plot(tl1,time,-i_l2-0.15,LineWidth=3,LineStyle="--");
ylabel('Ρεύμα (A)',fontsize=15,FontName='Verdana');
axis(tl1,[0 0.9 0 11]); 
legend(tl1,'Αναφορά','Πηνίο 1','Πηνίο 2',fontsize=12,location='northwest',FontName='Verdana');
yticks(tl1,0:1:20);
title(tl1,'Ρεύμα χαμηλής πλευράς',fontsize=15,FontName='Verdana');

saveas(cur_ref_ind_return,'cur_ref_ind_return.svg');

%% Full System Current Plot
cur_flow_return=figure();
set(cur_flow_return,'position',[0,-100,640,700]);
cur_flow_return_tiles=tiledlayout(3,1);
cur_flow_return_tiles.TileSpacing = 'compact';
cur_flow_return_tiles.Padding = 'compact';
xlabel(cur_flow_return_tiles,"Χρόνος (s)",fontsize=14,FontName='Verdana');
title(cur_flow_return_tiles,"Ροή ρεύματος στο σύστημα - Επιστροφή/Ανύψωση",fontsize=15,FontName='Verdana');

tl2=nexttile;
plot(tl2,time,v_low,LineWidth=3);
title(tl2,'Τάση χαμηλής πλευράς',fontsize=14,FontName='Verdana');
axis(tl2,[0 0.9 12.5 42.5]); 
ylabel(tl2,'Τάση (V)',fontsize=15,FontName='Verdana');
grid on;

tl1=nexttile([2 1]);
plot(tl1,time,i_low_bat,LineWidth=3);
hold on;
plot(tl1,time,i_conv_high,LineWidth=3);
plot(tl1,time,i_high_bat,LineWidth=3);
axis(tl1,[0 0.9 0 22.5]);
yticks(tl1,-50:2:25);
ylabel("Ρεύμα (A)",fontsize=14,FontName='Verdana');
grid on;

legend(tl1,'Αποθήκευση_χ_α_μ_η_λ_ή','Μετατροπέας_υ_ψ_η_λ_ή','Αποθήκευση_υ_ψ_η_λ_ή',fontsize=12,location='northwest',FontName='Verdana');
title(tl1,'Ρεύματα (Ρεύμα Κατανάλωσης=-6A)',fontsize=14,FontName='Verdana');

saveas(cur_flow_return,'cur_flow_return.svg');

