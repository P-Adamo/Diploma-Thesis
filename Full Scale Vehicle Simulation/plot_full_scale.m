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
set(car_graph,'position',[100,100,640,700]);
car_graph_tiles=tiledlayout(2,1);
car_graph_tiles.TileSpacing = 'compact';
car_graph_tiles.Padding = 'compact';
xlabel(car_graph_tiles,"Χρόνος (s)",fontsize=14,FontName='Verdana');
%title(car_graph_tiles,"Κινητήριο σύστημα κατά την πέδηση/ανάκτηση",fontsize=15,FontName='Verdana');

tl1=nexttile;
yyaxis left;
plot(tl1,[1 1 ],[-1000 3000],LineWidth=1,color='black');
hold on;
plot(tl1,time,car_speed,LineWidth=3,LineStyle="-");
axis(tl1,[0 9 0 110]);
yticks(0:10:110);
ylabel("Ταχύτητα (km/h)",fontsize=14,FontName='Verdana');

yyaxis right;
plot(tl1,[1 1],[-1000 3000],LineWidth=1,color='black');
hold on;
axis(tl1,[0 9 100 275]);
yticks(0:25:550);
plot(tl1,time,v_sc,LineWidth=3,Linestyle='--');
grid on;
plot(tl1,[6 6],[-1000 3000],LineWidth=1,color='black',Linestyle='-');
legend(tl1,'','Όχημα','','Υπερπυκνωτές','',location='southeast',fontsize=12,FontName='Verdana');
title(tl1,'Ταχύτητα / Τάση (DC Ζυγός=500V)',fontsize=15,FontName='Verdana');

tl2=nexttile;
plot(tl2,[1 1 ],[-10000 30000],LineWidth=1,color='black');
hold on; 
plot(tl2,time,t_axle,LineWidth=3,color="#0072BD");
plot(tl2,time,t_elmag,LineWidth=3,color='#D95319',LineStyle='--');
grid on;
ylabel('Ροπή (Nm)',fontsize=14,FontName='Verdana');
axis(tl2,[0 9 -2300 250]);
plot(tl2,[6 6],[-10000 30000],LineWidth=1,color='black');
yticks(tl2,-2500:250:250);
legend(tl2,'','Άξονας','Δρομέας','',fontsize=12,location='southeast',FontName='Verdana');
title(tl2,'Ροπή',fontsize=15,FontName='Verdana');

saveas(car_graph,'car_graph.svg');
%% Current/Voltage Plot
cur_vol_graph=figure();
set(cur_vol_graph,'position',[0,-100,640,700]);
cur_vol_graph_tiles=tiledlayout(2,1);
cur_vol_graph_tiles.TileSpacing = 'compact';
cur_vol_graph_tiles.Padding = 'compact';
xlabel(cur_vol_graph_tiles,"Χρόνος (s)",fontsize=14,FontName='Verdana');
%title(cur_vol_graph_tiles,"Κινητήριο σύστημα κατά την πέδηση/ανάκτηση",fontsize=15,FontName='Verdana')

tl2=nexttile(1,[2 1]);
plot(tl2,[1 1],[-10000 3000],LineWidth=1,color='black');
hold on;
plot(tl2,time,i_dclink,LineWidth=3,Linestyle='-',color="#0072BD");
plot(tl2,time,i_sc/1.02,LineWidth=3,Linestyle='--',color='#7E2F8E');
plot(tl2,time,i_bat,LineWidth=3,LineStyle="--",color="#77AC30");
plot(tl2,time,i_conv,LineWidth=3,Linestyle='-',color="#4DBEEE");
grid on;
ylabel('Ρεύμα (A)',fontsize=14,FontName='Verdana');
axis(tl2,[0 9 -800 50]);
yticks(-1200:50:50);
plot(tl2,[6 6],[-1000 3000],LineWidth=1,color='black');
legend(tl2,'','DC Ζυγός','Υπερπυκνωτές','Μπαταρία','Μετατροπέας','',fontsize=12,location='southeast',FontName='Verdana');
title(tl2,'Ρεύμα',fontsize=15,FontName='Verdana');

saveas(cur_vol_graph,'cur_vol_graph.svg');


