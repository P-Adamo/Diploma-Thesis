%% clear vars
clear variables; clc;
%% set vars
runtime=0.2;
mode=0;
i_low_ref=0.25;

%% Extact buck ccm Data 
load("buck_ccm.mat");
ccm_dcm_time=((ans(1,:)-0.1)*1e6)-1;
buck_ccm_i_high=ans(2,:);
buck_ccm_i_low=ans(3,:);
buck_ccm_v_lf=ans(4,:);
buck_ccm_p_high=ans(5,:);

%% Plot Buck CCM
buck_ccm_fig=figure();
set(buck_ccm_fig,'position',[100,100,700,580]);
buck_ccm_tiles=tiledlayout(3,1);
buck_ccm_tiles.TileSpacing = 'compact';
buck_ccm_tiles.Padding = 'compact';
xlabel(buck_ccm_tiles,"Χρόνος",fontsize=15,FontName='Verdana');
title(buck_ccm_tiles,"Μετατροπέας Buck σε λειτουργία συνεχούς αγωγής",fontsize=17,FontName='Verdana');

tl1=nexttile;
plot(tl1,ccm_dcm_time,buck_ccm_i_high/4,LineWidth=3);
hold on;
grid on;
plot(tl1,ccm_dcm_time,buck_ccm_i_low/4,LineWidth=4,LineStyle=':');
title(tl1,'Ρεύμα',FontSize=16,FontName='Verdana');
yticks(tl1,0);
xticks(tl1,0);
legend(tl1,'Είσοδος', 'Πηνίο',location='southeast',FontSize=12,FontName='Verdana');
tl1.YColor=[0 0 0];
tl1.XColor=[0 0 0];

tl2=nexttile;
plot(tl2,ccm_dcm_time,buck_ccm_v_lf,LineWidth=3);
hold on;
grid on;
plot(tl2,[min(ccm_dcm_time) max(ccm_dcm_time)],[0 0],'black',LineWidth=1);
title(tl2,'Τάση Πηνίου Εξομάλυνσης',FontSize=16,FontName='Verdana');
yticks(tl2,0);
xticks(tl2,0);

tl3=nexttile;
plot(tl3,ccm_dcm_time,buck_ccm_p_high,LineWidth=3);
grid on;
title(tl3,'Παλμοί Διακόπτη',FontSize=16,FontName='Verdana');
yticks(tl3,0);
xticks(tl3,0);

axis(tl1,[0 80 0 3.2]);
axis(tl2,[0 80 -50 50]);
axis(tl3,[0 80 0 1.2]);

saveas(buck_ccm_fig,'Buck_ccm.svg');

%% Extact boost ccm Data 
load("boost_ccm.mat");
boost_ccm_i_high=ans(2,:);
boost_ccm_i_low=ans(3,:);
boost_ccm_v_lf=ans(4,:);
boost_ccm_p_low=ans(5,:);

%% Plot boost CCM
boost_ccm_fig=figure();
set(boost_ccm_fig,'position',[100,100,700,580]);
boost_ccm_tiles=tiledlayout(3,1);
boost_ccm_tiles.TileSpacing = 'compact';
boost_ccm_tiles.Padding = 'compact';
xlabel(boost_ccm_tiles,"Χρόνος",fontsize=15,FontName='Verdana');
title(boost_ccm_tiles,"Μετατροπέας Boost σε λειτουργία συνεχούς αγωγής",fontsize=17,FontName='Verdana');

tl1=nexttile;
plot(tl1,ccm_dcm_time,boost_ccm_i_high/4,LineWidth=3);
hold on;
grid on;
plot(tl1,ccm_dcm_time,boost_ccm_i_low/4,LineWidth=4,LineStyle=':');
title(tl1,'Ρεύμα',FontSize=16,FontName='Verdana');
yticks(tl1,0);
xticks(tl1,0);
legend(tl1,'Είσοδος', 'Πηνίο',location='southeast',FontSize=12,FontName='Verdana');
tl1.YColor=[0 0 0];
tl1.XColor=[0 0 0];

tl2=nexttile;
plot(tl2,ccm_dcm_time,-boost_ccm_v_lf,LineWidth=3);
hold on;
grid on;
plot(tl2,[min(ccm_dcm_time) max(ccm_dcm_time)],[0 0],'black',LineWidth=1);
title(tl2,'Τάση Πηνίου Εξομάλυνσης',FontSize=16,FontName='Verdana');
yticks(tl2,0);
xticks(tl2,0);

tl3=nexttile;
plot(tl3,ccm_dcm_time,boost_ccm_p_low,LineWidth=3);
grid on;
title(tl3,'Παλμοί Διακόπτη',FontSize=16,FontName='Verdana');
yticks(tl3,0);
xticks(tl3,0);

axis(tl1,[0 80 0 3.2]);
axis(tl2,[0 80 -50 50]);
axis(tl3,[0 80 0 1.2]);

saveas(boost_ccm_fig,'boost_ccm.svg');

%% Extact buck dcm Data 
load("buck_dcm.mat");
buck_dcm_i_high=ans(2,:);
buck_dcm_i_low=ans(3,:);
buck_dcm_v_lf=ans(4,:);
buck_dcm_p_high=ans(5,:);

%% Plot Buck DCM
buck_dcm_fig=figure();
set(buck_dcm_fig,'position',[100,100,700,580]);
buck_dcm_tiles=tiledlayout(3,1);
buck_dcm_tiles.TileSpacing = 'compact';
buck_dcm_tiles.Padding = 'compact';
xlabel(buck_dcm_tiles,"Χρόνος",fontsize=15,FontName='Verdana');
title(buck_dcm_tiles,"Μετατροπέας Buck σε λειτουργία ασυνεχούς αγωγής",fontsize=17,FontName='Verdana');

tl1=nexttile;
plot(tl1,ccm_dcm_time,buck_dcm_i_high/9,LineWidth=3);
hold on;
grid on;
plot(tl1,ccm_dcm_time,buck_dcm_i_low/9,LineWidth=3,LineStyle=':');
title(tl1,'Ρεύμα',FontSize=16,FontName='Verdana');
yticks(tl1,0);
xticks(tl1,0);
legend(tl1,'Είσοδος', 'Πηνίο',location='northeast',FontSize=12,FontName='Verdana');


for i=length(buck_dcm_v_lf):-1:1
    if buck_dcm_v_lf(i)>0 && buck_dcm_v_lf(i)<30
        buck_dcm_v_lf(i)=0;
    end
end

tl2=nexttile;
plot(tl2,ccm_dcm_time,buck_dcm_v_lf,LineWidth=3);
hold on;
grid on;
plot(tl2,[min(ccm_dcm_time) max(ccm_dcm_time)],[0 0],'black',LineWidth=1);
title(tl2,'Τάση Πηνίου Εξομάλυνσης',FontSize=16,FontName='Verdana');
yticks(tl2,0);
xticks(tl2,0);

tl3=nexttile;
plot(tl3,ccm_dcm_time,buck_dcm_p_high,LineWidth=3);
grid on;
title(tl3,'Παλμοί Διακόπτη',FontSize=16,FontName='Verdana');
yticks(tl3,0);
xticks(tl3,0);

axis(tl1,[0 80 0 3.2]);
axis(tl2,[0 80 -50 50]);
axis(tl3,[0 80 0 1.2]);

saveas(buck_dcm_fig,'Buck_dcm.svg');

%% Extact boost dcm Data 
load("boost_dcm.mat");
boost_dcm_i_high=ans(2,:);
boost_dcm_i_low=ans(3,:);
boost_dcm_v_lf=ans(4,:);
boost_dcm_p_low=ans(5,:);

%% Plot boost DCM
boost_dcm_fig=figure();
set(boost_dcm_fig,'position',[100,100,700,580]);
boost_dcm_tiles=tiledlayout(3,1);
boost_dcm_tiles.TileSpacing = 'compact';
boost_dcm_tiles.Padding = 'compact';
xlabel(boost_dcm_tiles,"Χρόνος",fontsize=15,FontName='Verdana');
title(boost_dcm_tiles,"Μετατροπέας Boost σε λειτουργία ασυνεχούς αγωγής",fontsize=17,FontName='Verdana');

tl1=nexttile;
plot(tl1,ccm_dcm_time,boost_dcm_i_high/9,LineWidth=3);
hold on;
grid on;
plot(tl1,ccm_dcm_time,boost_dcm_i_low/9,LineWidth=3,LineStyle=':');
title(tl1,'Ρεύμα',FontSize=16,FontName='Verdana');
yticks(tl1,0);
xticks(tl1,0);
legend(tl1,'Είσοδος', 'Πηνίο',location='northeast',FontSize=12,FontName='Verdana' );

for i=length(boost_dcm_v_lf):-1:1
    if boost_dcm_v_lf(i)<0 && boost_dcm_v_lf(i)>-37
        boost_dcm_v_lf(i)=0;
    end
end

tl2=nexttile;
plot(tl2,ccm_dcm_time,-boost_dcm_v_lf,LineWidth=3);
hold on;
grid on;
plot(tl2,[min(ccm_dcm_time) max(ccm_dcm_time)],[0 0],'black',LineWidth=1);
title(tl2,'Τάση Πηνίου Εξομάλυνσης',FontSize=16,FontName='Verdana');
yticks(tl2,0);
xticks(tl2,0);

tl3=nexttile;
plot(tl3,ccm_dcm_time,boost_dcm_p_low,LineWidth=3);
grid on;
title(tl3,'Παλμοί Διακόπτη',FontSize=16,FontName='Verdana');
yticks(tl3,0);
xticks(tl3,0);

axis(tl1,[0 80 0 3.2]);
axis(tl2,[0 80 -50 50]);
axis(tl3,[0 80 0 1.5]);

saveas(boost_dcm_fig,'boost_dcm.svg');

%% Extact 2 Branch Buck Data 
load("two_br_buck.mat");
interl_buck_time=((ans(1,:)-0.1)*1e6)-7-9;
tw_br_bk_i_high=ans(2,:)-(max(ans(3,:))/2.2);tw_br_bk_i_high(tw_br_bk_i_high<0) = 0;
tw_br_bk_i_low=ans(3,:)-(max(ans(3,:))/1.107);tw_br_bk_i_low(tw_br_bk_i_low<0) = 0;
tw_br_bk_i_lf1=ans(4,:)-(max(ans(3,:))/2.2);tw_br_bk_i_lf1(tw_br_bk_i_lf1<0) = 0;
tw_br_bk_i_lf2=ans(5,:)-(max(ans(3,:))/2.2);tw_br_bk_i_lf2(tw_br_bk_i_lf2<0) = 0;

tw_br_bk_p_h_1=ans(6,:);
tw_br_bk_p_l_1=ans(7,:);
tw_br_bk_p_h_2=ans(8,:);
tw_br_bk_p_l_2=ans(9,:);

%% Plot 2 Branch Buck Data 

% Plot boost DCM
tw_br_bk_fig=figure();
set(tw_br_bk_fig,'position',[100,100,640,700]);
tw_br_bk_tiles=tiledlayout(7,1);
tw_br_bk_tiles.TileSpacing = 'compact';
tw_br_bk_tiles.Padding = 'compact';
xlabel(tw_br_bk_tiles,"Χρόνος",fontsize=15,FontName='Verdana');
%title(tw_br_bk_tiles,"Δικατευθυντήριος Μετατροπέας 2 Κλάδων: Λειτουργία Buck",fontsize=15,FontName='Verdana');

%tile1 = current
tl1=nexttile(1,[5 1]);

plot(tl1,interl_buck_time,tw_br_bk_i_high/4,LineWidth=4,color='#77AC30');
hold on;
grid on;
plot(tl1,interl_buck_time,tw_br_bk_i_low/4,LineWidth=3,color="#7E2F8E");
plot(tl1,interl_buck_time,tw_br_bk_i_lf1/4,LineWidth=4,LineStyle=':',color='#0072BD');
plot(tl1,interl_buck_time,tw_br_bk_i_lf2/4,LineWidth=4,LineStyle=':',color='#D95319');
title(tl1,'Ρεύματα (Buck)',FontSize=16,FontName='Verdana');
yticks(tl1,0);
xticks(tl1,0);
legend(tl1,'Είσοδος','Έξοδος', 'Πηνίο 1', 'Πηνίο 2',location='northeast',FontSize=13,FontName='Verdana');

%tile2 = high pulses 
tl2=nexttile(6,[2 1]);

plot(tl2,interl_buck_time,tw_br_bk_p_h_1,LineWidth=4,color="#0072BD");
hold on;
grid on;
plot(tl2,interl_buck_time,tw_br_bk_p_h_2,LineWidth=4,color='#D95319');

title(tl2,'Παλμοί Διακόπτη',FontSize=16,FontName='Verdana');
yticks(tl2,0);
xticks(tl2,0);
lgnd=legend(tl2,'1','2',location='southeast',FontSize=12,FontName='Verdana');
title(lgnd,'Κλάδος',FontName='Verdana')

axis(tl1,[0 30 0 0.375]);
axis(tl2,[0 30 0 1.2]);

saveas(tw_br_bk_fig,'tw_br_bk.svg');

%% Extact 3 Branch Buck Data 
load("three_br_buck.mat");
interl_buck_time=((ans(1,:)-0.1)*1e6)-522-11;
tr_br_bk_i_high=ans(2,:)-(max(ans(3,:))/3.4);tr_br_bk_i_high(tr_br_bk_i_high<0) = 0;
tr_br_bk_i_low=ans(3,:)-(max(ans(3,:))/1.09);tr_br_bk_i_low(tr_br_bk_i_low<0) = 0;
tr_br_bk_i_lf1=ans(4,:)-(max(ans(3,:))/3.4);tr_br_bk_i_lf1(tr_br_bk_i_lf1<0) = 0;
tr_br_bk_i_lf2=ans(5,:)-(max(ans(3,:))/3.4);tr_br_bk_i_lf2(tr_br_bk_i_lf2<0) = 0;
tr_br_bk_i_lf3=ans(6,:)-(max(ans(3,:))/3.4);tr_br_bk_i_lf2(tr_br_bk_i_lf2<0) = 0;

tr_br_bk_p_h_1=ans(7,:);
tr_br_bk_p_h_2=ans(8,:);
tr_br_bk_p_h_3=ans(9,:);
tr_br_bk_p_l_1=ans(10,:);

%% Plot 3 Branch Buck Data 

% Plot boost DCM
tr_br_bk_fig=figure();
set(tr_br_bk_fig,'position',[100,100,700,600]);
tr_br_bk_tiles=tiledlayout(7,1);
tr_br_bk_tiles.TileSpacing = 'compact';
tr_br_bk_tiles.Padding = 'compact';
xlabel(tr_br_bk_tiles,"Χρόνος",fontsize=15,FontName='Verdana');
title(tr_br_bk_tiles,"Δικατευθυντήριος Μετατροπέας 3 Κλάδων: Λειτουργία Buck",fontsize=16,FontName='Verdana');

%tile1 = current
tl1=nexttile(1,[5 1]);
plot(tl1,interl_buck_time,tr_br_bk_i_high,LineWidth=4,color="#77AC30");
hold on;
grid on;
plot(tl1,interl_buck_time,tr_br_bk_i_low,LineWidth=3,color="#7E2F8E");

plot(tl1,interl_buck_time,tr_br_bk_i_lf1,LineWidth=4,LineStyle=':',color="#0072BD");
plot(tl1,interl_buck_time,tr_br_bk_i_lf2,LineWidth=4,LineStyle=':',color="#D95319");
plot(tl1,interl_buck_time,tr_br_bk_i_lf3,LineWidth=4,LineStyle=':',color="#EDB120");

title(tl1,'Ρεύμα',FontSize=16,FontName='Verdana');
yticks(tl1,0);
xticks(tl1,0);
legend(tl1,'Είσοδος','Έξοδος', 'Πηνίο 1', 'Πηνίο 2','Πηνίο 3',location='northeast',FontSize=12,FontName='Verdana');

%tile2 = high pulses 
tl2=nexttile(6,[2 1]);

plot(tl2,interl_buck_time,tr_br_bk_p_h_1,LineWidth=3);
hold on;
grid on;
plot(tl2,interl_buck_time,tr_br_bk_p_h_2,LineWidth=3);
plot(tl2,interl_buck_time,tr_br_bk_p_h_3,LineWidth=3);

title(tl2,'Παλμοί Διακόπτη',FontSize=16,FontName='Verdana');
yticks(tl2,0);
xticks(tl2,0);
lgnd=legend(tl2,'1','2','3',location='east',FontSize=12,FontName='Verdana');
title(lgnd,'Κλάδος',FontName='Verdana');

axis(tl1,[0 33.45 0 inf]);
axis(tl2,[0 33.45 0 1.2]);

saveas(tr_br_bk_fig,'tr_br_bk.svg');

%////////////////////////////////////////////////
%% Extact 2 Branch Boost Data 
load("two_br_boost.mat");
interl_boost_time=((ans(1,:)-0.1)*1e6)-7-9;
tw_br_bs_i_high=ans(2,:)-(max(ans(2,:))/4.5);tw_br_bs_i_high(tw_br_bs_i_high<0) = 0;
tw_br_bs_i_low=ans(3,:)-(max(ans(2,:))/4.5);tw_br_bs_i_low(tw_br_bs_i_low<0) = 0;
tw_br_bs_i_lf1=ans(4,:)-(max(ans(2,:))/4.5);tw_br_bs_i_lf1(tw_br_bs_i_lf1<0) = 0;
tw_br_bs_i_lf2=ans(5,:)-(max(ans(2,:))/4.5);tw_br_bs_i_lf2(tw_br_bs_i_lf2<0) = 0;

tw_br_bs_p_h_1=ans(6,:);
tw_br_bs_p_l_1=ans(7,:);
tw_br_bs_p_h_2=ans(8,:);
tw_br_bs_p_l_2=ans(9,:);

%% Plot 2 Branch Boost Data 

% Plot boost DCM
tw_br_bs_fig=figure();
set(tw_br_bs_fig,'position',[100,100,640,700]);
tw_br_bs_tiles=tiledlayout(7,1);
tw_br_bs_tiles.TileSpacing = 'compact';
tw_br_bs_tiles.Padding = 'compact';
xlabel(tw_br_bs_tiles,"Χρόνος",fontsize=15,FontName='Verdana');
%title(tw_br_bs_tiles,"Δικατευθυντήριος Μετατροπέας 2 Κλάδων: Λειτουργία Boost",fontsize=15,FontName='Verdana');

%tile1 = current
tl1=nexttile(1,[5 1]);

plot(tl1,interl_boost_time,tw_br_bs_i_high,LineWidth=4,color='#77AC30');
hold on;
grid on;
plot(tl1,interl_boost_time,tw_br_bs_i_low,LineWidth=3.5,LineStyle=':',color="#7E2F8E");
plot(tl1,interl_boost_time,tw_br_bs_i_lf1,LineWidth=4,LineStyle=':',color='#0072BD');
plot(tl1,interl_boost_time,tw_br_bs_i_lf2,LineWidth=4,LineStyle=':',color='#D95319');
title(tl1,'Ρεύματα (Boost)',FontSize=16,FontName='Verdana');
yticks(tl1,0);
xticks(tl1,0);
legend(tl1,'Έξοδος','Είσοδος','Πηνίο 1', 'Πηνίο 2',location='northeast',FontSize=13,FontName='Verdana');

%tile2 = high pulses 
tl2=nexttile(6,[2 1]);

plot(tl2,interl_boost_time,tw_br_bs_p_l_1,LineWidth=4,color="#0072BD");
hold on;
grid on;
plot(tl2,interl_boost_time,tw_br_bs_p_l_2,LineWidth=4,color='#D95319');

title(tl2,'Παλμοί Διακόπτη',FontSize=16,FontName='Verdana');
yticks(tl2,0);
xticks(tl2,0);
lgnd=legend(tl2,'1','2',location='southeast',FontSize=12,FontName='Verdana');
title(lgnd,'Κλάδος',FontName='Verdana')

axis(tl1,[0 30 0 0.91]);
axis(tl2,[0 30 0 1.2]);

saveas(tw_br_bs_fig,'tw_br_bs.svg');

%% Extact 3 Branch Boost Data 
load("three_br_boost.mat");
interl_boost_time=((ans(1,:)-0.1)*1e6)-532;
tr_br_bs_i_high=ans(2,:)-(max(ans(3,:))/1.5);tr_br_bs_i_high(tr_br_bs_i_high<0) = 0;
tr_br_bs_i_low=ans(3,:)-(max(ans(3,:))/1.5);tr_br_bs_i_low(tr_br_bs_i_low<0) = 0;
tr_br_bs_i_lf1=ans(4,:)-(max(ans(3,:))/1.5);tr_br_bs_i_lf1(tr_br_bs_i_lf1<0) = 0;
tr_br_bs_i_lf2=ans(5,:)-(max(ans(3,:))/1.5);tr_br_bs_i_lf2(tr_br_bs_i_lf2<0) = 0;
tr_br_bs_i_lf3=ans(6,:)-(max(ans(3,:))/1.5);tr_br_bs_i_lf2(tr_br_bs_i_lf2<0) = 0;

tr_br_bs_p_h_1=ans(7,:);
tr_br_bs_p_h_2=ans(8,:);
tr_br_bs_p_h_3=ans(9,:);
tr_br_bs_p_l_1=ans(10,:);

%% Plot 3 Branch Boost Data 

% Plot boost DCM
tr_br_bs_fig=figure();
set(tr_br_bs_fig,'position',[100,100,700,600]);
tr_br_bs_tiles=tiledlayout(7,1);
tr_br_bs_tiles.TileSpacing = 'compact';
tr_br_bs_tiles.Padding = 'compact';
xlabel(tr_br_bs_tiles,"Χρόνος",fontsize=15,FontName='Verdana');
title(tr_br_bs_tiles,"Δικατευθυντήριος Μετατροπέας 3 Κλάδων: Λειτουργία Boost",fontsize=16,FontName='Verdana');

%tile1 = current
tl1=nexttile(1,[5 1]);
plot(tl1,interl_boost_time,tr_br_bs_i_high,LineWidth=4,color="#77AC30");
hold on;
grid on;
plot(tl1,interl_boost_time,tr_br_bs_i_low,LineWidth=4,color="#7E2F8E",LineStyle=":");

title(tl1,'Ρεύμα',FontSize=16,FontName='Verdana');
yticks(tl1,0);
xticks(tl1,0);
legend(tl1,'Έξοδος','Eίσοδος/Πηνίο 1',location='northeast',FontSize=12,FontName='Verdana');

%tile2 = high pulses 
tl2=nexttile(6,[2 1]);

plot(tl2,interl_boost_time,tr_br_bs_p_l_1,LineWidth=3);

title(tl2,'Παλμοί Διακόπτη',FontSize=16,FontName='Verdana');
yticks(tl2,0);
xticks(tl2,0);
lgnd=legend(tl2,'1',location='southeast',FontSize=12,FontName='Verdana');
title(lgnd,'Κλάδος',FontName='Verdana')

axis(tl1,[0 33.9 0 0.08]);
axis(tl2,[0 33.9 0 1.1]);

saveas(tr_br_bs_fig,'tr_br_bs.svg');
