%% Clear stuff
clear variables;clc;

%% Buck Normalised Input/Output Current
buck_fig=figure();
set(buck_fig,'position',[100,100,700,600]);
buck_tiles=tiledlayout(2,1);
buck_tiles.TileSpacing = 'compact';
buck_tiles.Padding = 'compact';
xlabel(buck_tiles,'Λόγος Κατάτμησης (%)',fontsize=15,FontName='Verdana');
ylabel(buck_tiles,"Κανονικοποιμένο Ρεύμα_R_M_S",fontsize=14,FontName='Verdana');
title(buck_tiles,"Κανονικοποιμένο Ρεύμα Μετατροπέα Buck Πολλαπλών Κλάδων",fontsize=15,FontName='Verdana');

%Buck Input Current Ripple 
tl1=nexttile;
D=0:0.0005:1;
n=1;
m=floor(D*n);
plot(tl1, D*100, sqrt( (D-m/n).*(((1+m)/n)-D) ) ,LineWidth=3);
hold on;
grid on;

for n=2:1:4
    m=floor(D*n);
    plot(tl1, D*100, sqrt( (D-m/n).*(((1+m)/n)-D) ) ,LineWidth=3);
end

lgnd1=legend(tl1,'1','2','3','4',FontName='Verdana');
title(lgnd1,"N",FontName='Verdana');
xtickformat(tl1,"percentage");
title(tl1,'Ρεύμα Εισόδου',fontsize=14,FontName='Verdana');
axis(tl1,[0 100 0 0.51]);

%Buck Output Current Ripple 
tl2=nexttile;
D=0:0.001:1;
n=1;
m=floor(D*n);
plot(tl2, D*100, (n./ (D.*(1-D))) .* (D-m/n) .* ( (1+m)/n -D) ,LineWidth=3);
hold on;
grid on;

for n=2:1:4
    m=floor(D*n);
    plot(tl2, D*100, (n./(D.*(1-D))) .* (D-m/n) .* ( (1+m)/n -D) ,LineWidth=3);
end

lgnd1=legend(tl2,'1','2','3','4',Location="southeast",FontName='Verdana');
title(lgnd1,"N",FontName='Verdana');
xtickformat(tl2,"percentage");
title(tl2,'Ρεύμα Εξόδου',fontsize=14,FontName='Verdana');
axis(tl2,[0 100 0 1.01]);

saveas(buck_fig,'inter_buck_ripple.svg');

%% boost Normalised Input/Output Current
boost_fig=figure();
set(boost_fig,'position',[100,100,700,600]);
boost_tiles=tiledlayout(2,1);
boost_tiles.TileSpacing = 'compact';
boost_tiles.Padding = 'compact';
xlabel(boost_tiles,'Λόγος Κατάτμησης (%)',fontsize=15,FontName='Verdana');
ylabel(boost_tiles,"Κανονικοποιμένο Ρεύμα_R_M_S",fontsize=14,FontName='Verdana');
title(boost_tiles,"Κανονικοποιμένο Ρεύμα Μετατροπέα Boost Πολλαπλών Κλάδων",fontsize=15,FontName='Verdana');

%boost Output Current Ripple 
tl1=nexttile;
D=0:0.001:1;
n=1;
m=floor(D*n);
plot(tl1, D*100, (n./ (D.*(1-D))) .* (D-m/n) .* ( (1+m)/n -D) ,LineWidth=3);
hold on;
grid on;

for n=2:1:4
    m=floor(D*n);
    plot(tl1, D*100, (n./(D.*(1-D))) .* (D-m/n) .* ( (1+m)/n -D) ,LineWidth=3);
end

lgnd1=legend(tl1,'1','2','3','4',Location="southeast",FontName='Verdana');
title(lgnd1,"N",FontName='Verdana');
xtickformat(tl1,"percentage");
title(tl1,'Ρεύμα Εισόδου',fontsize=14,FontName='Verdana');
axis(tl1,[0 100 0 1.01]);

%boost Input Current Ripple 
tl2=nexttile;
D=0:0.0005:1;
n=1;
m=floor(D*n);
plot(tl2, D*100, sqrt( (D-m/n).*(((1+m)/n)-D) ) ,LineWidth=3);
hold on;
grid on;

for n=2:1:4
    m=floor(D*n);
    plot(tl2, D*100, sqrt( (D-m/n).*(((1+m)/n)-D) ) ,LineWidth=3);
end

lgnd1=legend(tl2,'1','2','3','4',FontName='Verdana');
title(lgnd1,"N",FontName='Verdana');
xtickformat(tl2,"percentage");
title(tl2,'Ρεύμα Εξόδου',fontsize=14,FontName='Verdana');
axis(tl2,[0 100 0 0.51]);

saveas(boost_fig,'inter_boost_ripple.svg');