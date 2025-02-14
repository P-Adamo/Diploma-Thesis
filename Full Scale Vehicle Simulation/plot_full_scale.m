%% Clear stuff
clear variables; clc;

%% import stuff
load("full_scale.mat");
time=fs_ans(1,:)-9;
%% Pop negative values
for i=(size(time,2)):-1:1
    if (time(i)<0) 
        fs_ans(:,i)=0;
    end
end

%% Load vars
time=fs_ans(1,:)-9;
car_speed=fs_ans(2,:);
rotor_rpm=fs_ans(3,:);
i_arm=fs_ans(4,:);
i_dclink=fs_ans(5,:);
i_conv=fs_ans(6,:);
i_bat=fs_ans(7,:);
i_sc=fs_ans(8,:);
v_sc=fs_ans(9,:);
v_arm=fs_ans(10,:);
v_dclink=fs_ans(11,:);
t_elmag=fs_ans(12,:);
t_axle=fs_ans(13,:);

%% Vehicle Plot 
car_graph=figure();
set(car_graph,'position',[100,100,700,900]);
car_graph_tiles=tiledlayout(2,1);
car_graph_tiles.TileSpacing = 'compact';
car_graph_tiles.Padding = 'compact';
xlabel(car_graph_tiles,"Time (s)",fontsize=17);
title(car_graph_tiles,"Full Scale Motor System During Deceleration",fontsize=17);

tl1=nexttile;
yyaxis left;
plot(tl1,[1 1 ],[-1000 3000],LineWidth=1,color='black');
hold on;
plot(tl1,time,car_speed,LineWidth=3,LineStyle="-");
axis(tl1,[0 9 0 110]);
yticks(0:10:110);
ylabel("Linear Speed (km/h)",fontsize=14);
yyaxis right;
plot(tl1,time,rotor_rpm,LineWidth=3);
grid on;
axis(tl1,[0 9 0 2200]);
ylabel("Rotational Speed (RPM)",fontsize=14);
yticks(0:200:2200);
plot(tl1,[6 6],[-1000 3000],LineWidth=1,color='black',linestyle='-');
legend(tl1,'','Vehicle','Machine Rotor','',fontsize=14);
title(tl1,'Speed',fontsize=17);

tl2=nexttile;
plot(tl2,[1 1 ],[-1000 3000],LineWidth=1,color='black');
hold on;
plot(tl2,time,t_axle/1000,LineWidth=3,color="#0072BD");
plot(tl2,time,t_elmag/1000,LineWidth=3,color='#D95319',LineStyle='--');
grid on;
ylabel('Torque (kN*m)',fontsize=14);
axis(tl2,[0 9 -2.5 0.500]);
plot(tl2,[6 6],[-1000 3000],LineWidth=1,color='black');
legend(tl2,'','Axle','Electromagnetic','',fontsize=14,location='north');
title(tl2,'Torque',fontsize=17);

saveas(car_graph,'car_graph.svg');
%% Current/Voltage Plot
cur_vol_graph=figure();
set(cur_vol_graph,'position',[0,-100,750,1400]);
cur_vol_graph_tiles=tiledlayout(3,1);
cur_vol_graph_tiles.TileSpacing = 'compact';
cur_vol_graph_tiles.Padding = 'compact';
xlabel(cur_vol_graph_tiles,"Time (s)",fontsize=17);
title(cur_vol_graph_tiles,"Full Scale Motor System During Deceleration",fontsize=17);

tl1=nexttile;
plot(tl1,[1 1],[-1000 3000],LineWidth=1,color='black');
hold on;
plot(tl1,time,v_dclink,LineWidth=3,LineStyle="-",color="#0072BD");
axis(tl1,[0 9 0 525]);
yticks(0:50:550);
ylabel("Voltage (V)",fontsize=14);
plot(tl1,time,v_arm,LineWidth=3,color='#D95319');
plot(tl1,time,v_sc,LineWidth=3,color="#7E2F8E",Linestyle='--');
grid on;
plot(tl1,[6 6],[-1000 3000],LineWidth=1,color='black');
legend(tl1,'','DC Link','Motor Armature','Supercapacitor','',fontsize=14,location='northeast');

title(tl1,'Voltage',fontsize=17);


tl2=nexttile(2,[2 1]);
plot(tl2,[1 1],[-10000 3000],LineWidth=1,color='black');
hold on;
plot(tl2,time,i_dclink,LineWidth=3,Linestyle='-',color="#0072BD");
plot(tl2,time,i_sc,LineWidth=3,Linestyle='--',color='#7E2F8E');
plot(tl2,time,i_bat,LineWidth=3,LineStyle="--",color="#77AC30");
plot(tl2,time,i_conv,LineWidth=3,Linestyle='-',color="#4DBEEE");
grid on;
ylabel('Current (A)',fontsize=14);
axis(tl2,[0 9 -850 50]);
yticks(-1200:50:50);
plot(tl2,[6 6],[-1000 3000],LineWidth=1,color='black');
legend(tl2,'','DC Link','Supercapacitor','Battery','Converter','',fontsize=14,location='southeast');
title(tl2,'Current',fontsize=17);

saveas(cur_vol_graph,'cur_vol_graph.svg');


