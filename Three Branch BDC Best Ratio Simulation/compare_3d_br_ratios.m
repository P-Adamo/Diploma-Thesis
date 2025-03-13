%% clear vars
clear variables; clc;
%% set vars
runtime=1.5;
curr_step=5; 
curr_range=30:curr_step:60;
V_low_range=10:5:40;
min_ratio=0.3;
max_ratio=0.5;
ratio_range=min_ratio:0.025:max_ratio;

timestep=runtime/size(curr_range,2);
current_stair=curr_range;

for i=1:1:(length(V_low_range)-1)/2
    current_stair=horzcat(current_stair,max(curr_range)+min(curr_range)-curr_range);
    current_stair=horzcat(current_stair,curr_range);
end

time_range=0:timestep:runtime-timestep;
cur_stair_time=time_range;
for i=1:1:(length(V_low_range)-1)
    cur_stair_time=horzcat(cur_stair_time,max(cur_stair_time)+time_range+timestep);
    
end

%% Run Simulink
for i=1:size(ratio_range,2)
    simIn(i) = Simulink.SimulationInput('Async_3br_conv_eff');
    simIn(i) = simIn(i).setVariable('ratio',ratio_range(i));
    simIn(i) = setModelParameter(simIn(i), "StopTime",string(runtime*length(V_low_range)));
    simIn(i) = simIn(i).setVariable('current_stair',current_stair);
    simIn(i) = simIn(i).setVariable('cur_stair_time',cur_stair_time);
    simIn(i) = simIn(i).setVariable('timestep',timestep);

end
sim_res = parsim(simIn,"ShowProgress","on","TransferBaseWorkspaceVariables","on");

%% Extact Sim Data and pop zero vals

for i=1:size(ratio_range,2)
    temp=sim_res(i);
    temp=temp.simout;
    data(i).eff=temp(:,3);
    data(i).curr=temp(:,1);
    data(i).volt=temp(:,2);
    data(i)=struct('eff',temp(:,3), 'curr', temp(:,1), 'volt', temp(:,2));

end

%% Chop Measurements To Reduce Size

for j=1:1:10
    for i=1:size(ratio_range,2)
        data(i).eff(2:2:end)=[];
        data(i).curr(2:2:end)=[];
        data(i).volt(2:2:end)=[];
    end
end

%% pop zero data
for i=1:size(ratio_range,2)
    for j=(size(data(i).eff,1)):-1:1
        if (data(i).eff(j)<=0.1)
            data(i).eff(j)=[];
            data(i).curr(j)=[];
            data(i).volt(j)=[];    
        end
    end
end

%% Save Data
save('sim_save_3br_eff',"data");

%% Scatter Plots
figure();
ax=axes;
set(gcf,'position',[100,100,700,600]);
i=5;
s=scatter3(data(i).volt,data(i).curr,data(i).eff*100,'Marker','o','MarkerEdgeColor','none','MarkerFaceColor','flat');
s.SizeData=120;
hold on;

for i=6:1:(size(ratio_range,2)-3)
    s=scatter3(data(i).volt,data(i).curr,data(i).eff*100,'Marker','o','MarkerEdgeColor','none','MarkerFaceColor','flat');
    s.SizeData=120;
end

for i=(size(ratio_range,2)-2):1:size(ratio_range,2)-1
    hold on;
    s=scatter3(data(i).volt,data(i).curr,data(i).eff*100,'Marker','diamond','MarkerEdgeColor','none','MarkerFaceColor','flat');
    s.SizeData=120;
end

xlabel('Τάση Υπερπυκνωτών (V)',fontsize=14,FontName='Verdana');
ylabel('Ρεύμα Υπερπυκνωτών (A)',fontsize=14,FontName='Verdana');
zlabel('Απόδοση Μετατροπέα (%)',fontsize=14,FontName='Verdana');
ztickformat("percentage");
grid on;
lgnd_txt=[];
for i=5:1:size(ratio_range,2)-1
    lgnd_txt=[lgnd_txt; join([num2str(ratio_range(i)*100,'%.1f'),'%'])];
end

leg=legend(lgnd_txt,FontSize=11,FontName='Verdana');
title(leg,{'Αναλογία','Κλάδου 1'},FontSize=11,FontName='Verdana');
xticks(10:5:40);
yticks(30:5:60);
zticks(79:1:99);
axis([7.5 42.5 27.5 62.5 88.4 98.2]);
title({"Ασυμμετρικός Δικατευθυντήριος Μετατροπέας 3 Κλάδων", "Απόδοση Καταμερισμού Ρεύματος"},FontSize=14,FontName='Verdana');

%%

[az, el] = view;
ax.XLabel.Rotation = 16.5;  
ax.YLabel.Rotation = -12;       
%%
ax.XLabel.Position = ax.XLabel.Position + [0, 0, +0.1]; 
%%
ax.YLabel.Position = ax.YLabel.Position + [0, 0, 0.1];

%% Save svg corner
saveas(gcf,'3br_ratio_comp_corner.svg');

%% Save svg top
saveas(gcf,'3br_ratio_comp_top.svg');