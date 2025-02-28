%% Clear Stuff
clearvars;clc;

%%
NewFile3=readtable('C:\Users\adamo\Desktop\Workspace\Experiments\data_experiments\Buck\NewFile3.csv');

%%
time=NewFile3.X * NewFile3.Increment(1);
time=time(2:end,1);

ch2=NewFile3.CH2;
ch2=ch2(2:end,1);

tiles=tiledlayout(2,1);
tl1=nexttile;
plot(time, ch2,LineWidth=2);
hold on
fs=1/NewFile3.Increment(1);
fpass=60e3;
ch2_filt=lowpass(ch2,fpass,fs);
plot(time, ch2_filt,LineWidth=4);
legend('meas','filt+meas');
grid on;
axis([0.1e-4 2.1e-4 13.7 19]);

tl2=nexttile;
ch2 = min(max(ch2,15.5),16.3);
%plot(time, ch2,LineWidth=2);
hold on
ch2_filt=lowpass(ch2,fpass,fs);
plot(time, ch2_filt,LineWidth=4);
axis([0.1e-4 2.1e-4 13.7 19]);
legend('meas+limited','filt+meas+lim');
grid on;