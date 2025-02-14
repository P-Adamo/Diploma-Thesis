%% Clear stuff
clear variables; clc;

%% import stuff
load("full_scale_return.mat");
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

%% Current/Voltage Plot
cur_vol_graph=figure();
set(cur_vol_graph,'position',[0,-100,750,1400]);
cur_vol_graph_tiles=tiledlayout(3,1);
cur_vol_graph_tiles.TileSpacing = 'compact';
cur_vol_graph_tiles.Padding = 'compact';
xlabel(cur_vol_graph_tiles,"Time (s)",fontsize=17);
title(cur_vol_graph_tiles,"Full Scale Motor System During Energy Return",fontsize=17);

tl1=nexttile;
plot(tl1,[1 1],[-1000 3000],LineWidth=1,color='black');
yticks(0:50:550);
ylabel("Voltage (V)",fontsize=14);
plot(tl1, [-1 -1],[-1 -1],LineWidth=3,LineStyle="-");
hold on;
plot(tl1,time,v_sc,LineWidth=3.5,Linestyle='-');
grid on;
xticks(tl1,0:1:25);
axis(tl1,[0 12 0 170]);
title(tl1,'Supercapacitor Voltage','DC Link Voltage = 500V',fontsize=17);

%%
tl2=nexttile(2,[2 1]);
plot(tl2,[1 1],[-10000 3000],LineWidth=1,color='black');
hold on;
plot(tl2,time,i_dclink,LineWidth=3.5,Linestyle='--',color="#0072BD");
plot(tl2,time,i_sc,LineWidth=3,Linestyle='--',color='#7E2F8E');
plot(tl2,time,i_bat,LineWidth=3,LineStyle="-",color="#77AC30");
plot(tl2,time,i_conv,LineWidth=3,Linestyle='-',color="#4DBEEE");
grid on;
ylabel('Current (A)',fontsize=14);
axis(tl2,[0 12 0 155]);
yticks(0:10:200);
legend(tl2,'','DC Link','Supercapacitor','Battery','Converter',fontsize=14,location='northwest');
title(tl2,'Current',fontsize=17);
xticks(tl2,0:1:25);

saveas(cur_vol_graph,'cur_vol_graph_return.svg');