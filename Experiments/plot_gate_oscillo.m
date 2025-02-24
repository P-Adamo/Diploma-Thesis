%% ---------------------------- Clear Stuff ----------------------------
clearvars;clc;

plot_height=700;
plot_length=700;

%% Get Data NewFile1
NewFile1=readtable('C:\Users\adamo\Desktop\Workspace\Experiments\data_gate_oscillo\NewFile1.csv');

time_br1_high_low_z_out=NewFile1.X * NewFile1.Increment(1)*1e6;
time_br1_high_low_z_out=time_br1_high_low_z_out(2:end,1)-8.25;

v_high_1_z_out=NewFile1.CH1;
v_high_1_z_out=v_high_1_z_out(2:end,1);
v_low_1_z_out=NewFile1.CH2;
v_low_1_z_out=v_low_1_z_out(2:end,1);

%% Plot branch 1 - high low - zoomed out 

br1_high_low_z_out=figure();
set(br1_high_low_z_out,'position',[100,100,plot_length,plot_height]);
br1_high_low_dead_on_tiles=tiledlayout(2,1);
br1_high_low_dead_on_tiles.TileSpacing = 'compact';
br1_high_low_dead_on_tiles.Padding = 'compact';
xlabel(br1_high_low_dead_on_tiles,"Time (μs)",fontsize=15);
ylabel(br1_high_low_dead_on_tiles,"Voltage (V)",fontsize=15);
title(br1_high_low_dead_on_tiles,"Oscilloscope Graph: MOSFET Complementary PWM",fontsize=17);

tl1=nexttile;
plot(tl1,time_br1_high_low_z_out, v_high_1_z_out,LineWidth=3);
grid on;
title(tl1,"High MOSFET V_G_S",fontsize=16);
axis(tl1,[0 40 0 16]);
xticks(tl1,0:2:100);

tl2=nexttile;
plot(tl2,time_br1_high_low_z_out, v_low_1_z_out,LineWidth=3);
title(tl2,"Low MOSFET V_G_S",fontsize=16);
axis(tl2,[0 40 0 16]);
grid on;
xticks(tl2,0:2:100);

saveas(br1_high_low_z_out,'br1_high_low_z_out.svg');

%% ---------------------------- Clear Stuff ----------------------------
%clearvars;clc;

%% Get Data NewFile2
NewFile2=readtable('C:\Users\adamo\Desktop\Workspace\Experiments\data_gate_oscillo\NewFile2.csv');

time_br1_high_low_dead_on=NewFile2.X * NewFile2.Increment(1)*1e9;
time_br1_high_low_dead_on=time_br1_high_low_dead_on(2:end,1) - 12854 -136;

v_high_1_dead_on=NewFile2.CH1;
v_high_1_dead_on=v_high_1_dead_on(2:end,1);
v_low_1_dead_on=NewFile2.CH2;
v_low_1_dead_on=v_low_1_dead_on(2:end,1);

%% Plot branch 1 - high low - dead time - high turn on

br1_high_low_dead_on=figure();
set(br1_high_low_dead_on,'position',[100,100,plot_length,plot_height]);
br1_high_low_dead_on_tiles=tiledlayout(2,1);
br1_high_low_dead_on_tiles.TileSpacing = 'compact';
br1_high_low_dead_on_tiles.Padding = 'compact';
xlabel(br1_high_low_dead_on_tiles,"Time (ns)",fontsize=15);
ylabel(br1_high_low_dead_on_tiles,"Voltage (V)",fontsize=15);
title(br1_high_low_dead_on_tiles,"Oscilloscope Graph: High MOSFET Turn On Dead Time",fontsize=17);

tl1=nexttile;
plot(tl1,time_br1_high_low_dead_on, v_high_1_dead_on,LineWidth=3);
grid on;
title(tl1,"High MOSFET V_G_S",fontsize=16);
axis(tl1,[0 1000 0 16]);
xticks(tl1,0:100:1000);
hold on;
plot(tl1,[100 100], [-100 100],color='black',LineWidth=1);
plot(tl1,[300 300], [-100 100],color='black',LineWidth=1);

tl2=nexttile;
plot(tl2,time_br1_high_low_dead_on, v_low_1_dead_on,LineWidth=3);
title(tl2,"Low MOSFET V_G_S",fontsize=16);
axis(tl2,[0 1000 0 16]);
grid on;
hold on;
plot(tl2,[100 100], [-100 100],color='black',LineWidth=1);
plot(tl2,[300 300], [-100 100],color='black',LineWidth=1);

saveas(br1_high_low_dead_on,'br1_high_low_dead_on.svg');

%% ---------------------------- Clear Stuff ----------------------------
%clearvars;clc;

%% Get Data NewFile3
NewFile3=readtable('C:\Users\adamo\Desktop\Workspace\Experiments\data_gate_oscillo\NewFile3.csv');

time_br1_high_low_dead_off=NewFile3.X * NewFile3.Increment(1)*1e9;
time_br1_high_low_dead_off=time_br1_high_low_dead_off(2:end,1)-2700-252;

v_high_1_dead_off=NewFile3.CH1;
v_high_1_dead_off=v_high_1_dead_off(2:end,1);
v_low_1_dead_off=NewFile3.CH2;
v_low_1_dead_off=v_low_1_dead_off(2:end,1);

%% Plot branch 1 - high low - dead time high turn off

br1_high_low_dead_off=figure();
set(br1_high_low_dead_off,'position',[100,100,plot_length,plot_height]);
br1_high_low_dead_off_tiles=tiledlayout(2,1);
br1_high_low_dead_off_tiles.TileSpacing = 'compact';
br1_high_low_dead_off_tiles.Padding = 'compact';
xlabel(br1_high_low_dead_off_tiles,"Time (ns)",fontsize=15);
ylabel(br1_high_low_dead_off_tiles,"Voltage (V)",fontsize=15);
title(br1_high_low_dead_off_tiles,"Oscilloscope Graph: High MOSFET Turn Off Dead Time",fontsize=17);

tl1=nexttile;
plot(tl1,time_br1_high_low_dead_off, v_high_1_dead_off,LineWidth=3);
grid on;
title(tl1,"High MOSFET V_G_S",fontsize=16);
axis(tl1,[0 1000 0 16]);
xticks(tl1,0:100:1000);
hold on;
plot(tl1,[100 100], [-100 100],color='black',LineWidth=1);
plot(tl1,[300 300], [-100 100],color='black',LineWidth=1);

tl2=nexttile;
plot(tl2,time_br1_high_low_dead_off, v_low_1_dead_off,LineWidth=3);
title(tl2,"Low MOSFET V_G_S",fontsize=16);
axis(tl2,[0 1000 0 16]);
xticks(tl2,0:100:1000);
grid on;
hold on;
plot(tl2,[100 100], [-100 100],color='black',LineWidth=1);
plot(tl2,[300 300], [-100 100],color='black',LineWidth=1);

saveas(br1_high_low_dead_off,'br1_high_low_dead_off.svg');

%% ---------------------------- Clear Stuff ----------------------------
%clearvars;clc;

%% Get Data NewFile4
NewFile4=readtable('C:\Users\adamo\Desktop\Workspace\Experiments\data_gate_oscillo\NewFile4.csv');

time_br1_br2_high=NewFile4.X * NewFile4.Increment(1)*1e6;
time_br1_br2_high=time_br1_br2_high(2:end,1)-1.95;

v_high_1_br1_br2_high=NewFile4.CH1;
v_high_1_br1_br2_high=v_high_1_br1_br2_high(2:end,1);
v_high_2_br1_br2=NewFile4.CH2;
v_high_2_br1_br2=v_high_2_br1_br2(2:end,1);

%% Plot branch 1 - high low - zoomed out 

br1_br2_high=figure();
set(br1_br2_high,'position',[100,100,plot_length,plot_height]);
vbr1_br2_high_tiles=tiledlayout(2,1);
vbr1_br2_high_tiles.TileSpacing = 'compact';
vbr1_br2_high_tiles.Padding = 'compact';
xlabel(vbr1_br2_high_tiles,"Time (μs)",fontsize=15);
ylabel(vbr1_br2_high_tiles,"Voltage (V)",fontsize=15);
title(vbr1_br2_high_tiles,"Oscilloscope Graph: MOSFET Phase Shift",fontsize=17);

tl1=nexttile;
plot(tl1,time_br1_br2_high, v_high_1_br1_br2_high,LineWidth=3);
grid on;
title(tl1,"Branch 1 High MOSFET V_G_S",fontsize=16);
axis(tl1,[0 40 0 16]);
xticks(tl1,0:2:100);

tl2=nexttile;
plot(tl2,time_br1_br2_high, v_high_2_br1_br2,LineWidth=3.5);
title(tl2,"Branch 2 High MOSFET V_G_S",fontsize=16);
axis(tl2,[0 40 0 16]);
grid on;
xticks(tl2,0:2:100);

saveas(br1_br2_high,'br1_br2_high.svg');