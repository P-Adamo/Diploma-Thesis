%% clear vars
clear variables; clc;
%% set vars
runtime=4;
curr_step=2.5;
curr_range=7.5:curr_step:60;
V_low_range=10:2:40;
timestep=runtime/size(curr_range,2);

%% Run Simulink
for i=1:size(V_low_range,2)
    simIn(i) = Simulink.SimulationInput('topology_comparison_eff');
    simIn(i) = simIn(i).setVariable('V_low',V_low_range(i));
    simIn(i) = setModelParameter(simIn(i), "StopTime",string(runtime));
    simIn(i) = simIn(i).setVariable('curr_range',curr_range);
    simIn(i) = simIn(i).setVariable('timestep',timestep);
    simIn(i) = simIn(i).setVariable('runtime',runtime);

end
sim_res = parsim(simIn,"ShowProgress","on","TransferBaseWorkspaceVariables","on");

%% Extact Sim Data 
f1res=[];
f2res=[];
f3res=[];
cres=[];
vres=[];

for i=1:size(V_low_range,2)
    data=sim_res(i);
    data=data.simout;
    c_data=(data(:,1));
    f1_data=(data(:,2));
    f2_data=(data(:,3));
    f3_data=(data(:,4));

    v_data=repmat(V_low_range(i),size(c_data,1),1);
    f1res=vertcat(f1res,f1_data);
    f2res=vertcat(f2res,f2_data);
    f3res=vertcat(f3res,f3_data);
    cres=vertcat(cres,c_data);
    vres=vertcat(vres,v_data);
end

%% Save Data
save('sim_save',"f1res","f2res","f3res","cres","vres", '-v7.3');

%% Chop Measurements To Reduce Size
f1_plot=f1res;
f2_plot=f2res;
f3_plot=f3res;
c_plot=cres;
v_plot=vres;

for i=1:1:9
    f1_plot(2:2:end) = []; f2_plot(2:2:end) = []; f3_plot(2:2:end) = [];
    c_plot(2:2:end) = []; 
    v_plot(2:2:end) = []; 
end

%% Pop Empty Values
for i=(size(f1_plot,1)):-1:1
    if (f1_plot(i)==0 || f2_plot(i)==0 || f3_plot(i)==0) 
        f1_plot(i)=[];
        f2_plot(i)=[];
        f3_plot(i)=[];
        c_plot(i)=[];
        v_plot(i)=[];
    end
end

%% Pop Wrong Values
for i=(size(f1_plot,1)):-1:1
    if (f1_plot(i)>1 || f2_plot(i)>1 || f3_plot(i)>1) 
        f1_plot(i)=[];
        f2_plot(i)=[];
        f3_plot(i)=[];
        c_plot(i)=[];
        v_plot(i)=[];
    end
end

%% clear duplicate measurements
volt_buff=v_plot((size(f1_plot,1)));
curr_buff=c_plot((size(f1_plot,1)));

for i=(size(f1_plot,1))-1:-1:1
    if (volt_buff==v_plot(i) && curr_buff==c_plot(i))
        v_plot(i)=[];
        c_plot(i)=[];
        f1_plot(i)=[];
        f2_plot(i)=[];
        f3_plot(i)=[];
    else
        volt_buff=v_plot(i);
        curr_buff=c_plot(i);
    end
end

%% Scatter Plots
figure();
set(gcf,'position',[100 100 700 1000]);
ax=axes;
% Interpolate Scatter Plots and Plot Surfaces
[V,C]=meshgrid(v_plot,c_plot);
F1 = griddata(v_plot, c_plot, f1_plot, V, C,'natural');
F2 = griddata(v_plot, c_plot, f2_plot, V, C, 'natural');
F3 = griddata(v_plot, c_plot, f3_plot, V, C, 'natural');
surf(V,C,F1*100,'FaceAlpha',0.7,'FaceColor','blue');
hold on;
grid on;
surf(V,C,F2*100,'FaceAlpha',0.7,'FaceColor','red');
surf(V,C,F3*100,'FaceAlpha',0.7,'FaceColor',[255 128 0]/256);
axis([10 40 10 60 82.2 100]);

legend("1 κλάδου","2 κλάδων","3 κλάδων",'','','',fontsize=12,FontName='Verdana');
xlabel('Τάση Υπερπυκνωτών (V)',fontsize=14,FontName='Verdana');
ylabel('Ρεύμα Υπερπυκνωτών (A)',fontsize=14,FontName='Verdana');
zlabel('Απόδοση Μετατροπέα (%)',fontsize=14,FontName='Verdana');
ztickformat("percentage");
xticks(10:5:40);
yticks(10:5:60);
zticks(80:1:100);
title({"Σύγκριση Απόδοσης Μετατροπέων Πολλαπλών Κλάδων","Σύγχρονοι: 1 & 2, Ασύγχρονος: 3"}, FontSize=14,FontName='Verdana');

%%
[az, el] = view;
ax.XLabel.Rotation = 34;  
ax.YLabel.Rotation = -22;       
%%
ax.XLabel.Position = ax.XLabel.Position + [0, -0.2, 0.1]; 
%%
ax.YLabel.Position = ax.YLabel.Position + [0, 0, 0.2];

%%
saveas(gcf,"three_topology_eff_comp.svg");
%% Plot Relative Efficiency
figure();
ax=axes;
set(gcf,'position',[100 100 700 1000]);

surf(V,C,(F2./F1)*100-100,'FaceAlpha',0.7,'FaceColor','blue');
hold on;
surf(V,C,(F2./F3)*100-100,'FaceAlpha',0.7,'FaceColor',[255 128 0]/256);

title({"Συγκριτική Απόδοση Μετατροπέων Ενός και Τριών Κλάδων","σε σχέση με Δύο Κλάδων"}, FontSize=14,FontName='Verdana');
saveas(gcf,"three_topology_eff_comp.svg");
legend('1 Κλάδος','3 Κλάδοι','Location','best',fontsize=12,FontName='Verdana');
axis([10 40 10 60 0 10.5]);

xticks(10:5:40);
yticks(10:5:60);
zticks(0:0.5:10.5);
xlabel('Τάση Υπερπυκνωτών (V)',fontsize=14,FontName='Verdana');
ylabel('Ρεύμα Υπερπυκνωτών (A)',fontsize=14,FontName='Verdana');
zlabel('Ποσοστό Μείωσης Απόδοσης (%)',fontsize=14,FontName='Verdana');
ztickformat("percentage");

%%
[az, el] = view;
ax.XLabel.Rotation = 32;  
ax.YLabel.Rotation = -18;       
%%
ax.XLabel.Position = ax.XLabel.Position + [0, 0, 0.1]; 
%%
ax.YLabel.Position = ax.YLabel.Position + [0, -0.2, 0];

%%
saveas(gcf,"three_topology_eff_rel.svg");

