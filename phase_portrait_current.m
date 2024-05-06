% This script takes in a a .mat file generate from 'scrape_and_compile.m' s
% and generates a phase portrait of the success rate with different
% parameter combinations of fluctuation and tension amplitudes
% 
% Each section is meant to be run separately
%
% Inputs:
%   - .mat files from 'scrape_and_compile.m'
%
% Output:
%   - a plot of the phase portrait for 4 cells and 20 cells

% Author: Matthew Devlin
% Last Modified: July 17, 2023


%% 4 cells

cd C:/Users/mrdev/Documents/EmbryoJournal/matlab_functions/

energy_four = load("currentDataFinaltestScript.mat");
energy_four = energy_four.energy;
% energy_four = energy;
vibration = energy_four(:,1);
current = energy_four(:,3); real current
% current = energy_four(:,2); %PWM
succesRate = energy_four(:,7);
err = energy_four(:,4);

figure
set(groot, 'DefaultAxesFontSize', 16);
set(groot, 'DefaultTextFontSize', 16);
subplot(2,2,1)
s = scatter3(vibration, current, succesRate, [], succesRate,  'filled');
hold on
h=colorbar;
colormap(flipud(colormap));
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),5))
s.SizeData = 100;
xlabel('Average Fluctuation Amplitude')
ylabel('Internal Tension')
% ylim([35 165])
zlabel('Success rate')

% figure
subplot(2,2,2)
s = scatter3(vibration, current, succesRate, [], succesRate,  'filled');
hold on
errorbar(current, succesRate, err, 'horizontal', '.','Color', 'k', 'Linewidth', .5)
h=colorbar;
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),5))
s.SizeData = 100;
xlabel('Average Fluctuation Amplitude')
ylabel('Internal Tension')
% ylim([35 165])
zlabel('Success rate')
title('Success vs Drive')
view(90,0)

% figure
subplot(2,2,3)
s = scatter3(vibration, current, succesRate, [], succesRate,  'filled');
hold on
h=colorbar;
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),5))
s.SizeData = 100;
xlabel('Average Fluctuation Amplitude')
% xlim([0 70])
ylabel('Internal Tension')
% ylim([35 165])
zlabel('Success rate')
title('Success vs Vibration')
view(0,0)

% figure actual phase portrait
subplot(2,2,4)
s = scatter3(current, vibration, succesRate, [], succesRate,  'filled'); %%axes swapped from intercalation
hold on
errorbar(current, vibration, err, 'horizontal', '.','Color', 'k', 'Linewidth', .5)
h=colorbar;
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),5))
s.SizeData = 100;
ylabel('Average Fluctuation Amplitude')
xlabel('Internal Tension')
xlim([0.15 0.6])
zlabel('Success rate')
% title('Fluctuation phase portrait')
title('Phase portrait')
ylim([-0.5 70])
view(2)
%%
figure
s = scatter(current, succesRate, 100, 'filled');
hold on
errorbar(current, succesRate, err, 'horizontal', '.','Color', 'k', 'Linewidth', .5)

t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),5))
s.SizeData = 100;
xlabel('Average Fluctuation Amplitude')
ylabel('Success rate')
% ylim([35 165])
title('Success vs Drive')


%% phase portrait cleaner THIS ONE in illustrator
cd C:/Users/mrdev/Documents/EmbryoJournal/matlab_functions/

energy_four = load("currentDataFinaltestScript.mat");
energy_four = energy_four.energy;
% energy_four = energy;
vibration = energy_four(:,1);
% current = energy_four(:,3); real current
current = energy_four(:,2); %PWM
succesRate = energy_four(:,7);
% err = energy_four(:,4);

figure
set(groot, 'DefaultAxesFontSize', 7);
set(groot, 'DefaultTextFontSize', 7);

% current = normalize(current,'range');

vibration = normalize(vibration, 'range');

% err = err./(max(current)-min(current));
% err = err/sqrt(10); %standard error
current = normalize(current, 'range');



% s = scatter3(current, vibration, succesRate, [], succesRate,  'filled'); %%axes swapped from intercalation
s = scatter3(vibration, current, succesRate, [], succesRate,  'filled'); %fluctuation on the x for newest draft
hold on
box on
% errorbar(vibration, current, err, 'vertical', '.','Color', 'k', 'Linewidth', .5)
% cmap = createcolormap([255 204 0]/256, [102 152 0]/256);
% cmap = createcolormap( [240 83 49]/256,[242 212 142]/256);
% cmap = createcolormap( [242 163 64]/256,[232 233 234]/256);
cmap = createcolormap( [44 128 175]/256,[232 233 234]/256);
h=colorbar;
% colormap(flipud(colormap));
colormap(cmap)
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
% set(h,'Ticks',linspace(t(1),t(2),3)) old
set(h,'Ticks', [0 1])
s.SizeData = 100;
% 
% ylabel('Fluctuation Amplitude')
% xlabel('Internal Tension')
% zlabel('Success rate')

% title('Fluctuation phase portrait')
% title('Phase portrait')
ylim([-0.15 1.15])
% xlim([0 1e-1])
yticks([0 1])
xticks([0 1])
xlim([-0.15 1.15])

fig = gcf;  % Get current figure handle
fig.Position(1:2) = [500, 200];
fig.Position(3:4) = 3*[200, 175];

H=gca;
H.LineWidth=1; %change to the desired value 


grid off
view(2)
print(gcf,'-vector','-dsvg',['phaseIntercalateRealnewColor','.svg']) % svg

%% phase portrait isolated heatmap
figure
current = normalize(current,'range');
vibration = normalize(vibration, 'range');
s = scatter3(current, vibration, succesRate, [], succesRate,  'filled','s'); %%axes swapped from intercalation
hold on
h=colorbar;
colormap(flipud(colormap));
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),3))
s.SizeData = 3000;
ylabel('Fluctuation Amplitude')
xlabel('Internal Tension')

zlabel('Success rate')
% title('Fluctuation phase portrait')
% title('Phase portrait')
xlim([-0.1 1.1])
xticks([0 0.5 1])
yticks([0 0.5 1])
ylim([-0.15 1.15])

fig = gcf;  % Get current figure handle
fig.Position(3:4) = [500, 300];


grid off
view(2)
%% 20 cells honestly not that useful

cd C:/Users/mrdev/Documents/EmbryoJournal/matlab_functions/

energy_twenty= load("20Finals.mat");
energy_twenty = energy_twenty.energy;
vibration = energy_twenty(:,1);
current = energy_twenty(:,2);
succesRate = energy_twenty(:,7);


powerMap = load("powerMap.mat");
powerMap = powerMap.powerMap;
% tension = normalize(energy(:,2),'range');
current = energy_twenty(:,2);
% tension(tension == 60) = powerMap(powerMap(:,1)==60,2);
current(current == 80) = powerMap(powerMap(:,1)== 80,2);
current(current == 100) = powerMap(powerMap(:,1)==100,2);
current(current == 120) = powerMap(powerMap(:,1)==120,2);
current(current == 140) = powerMap(powerMap(:,1)==140,2);
current(current == 160) = 0.53; %made up

figure
set(groot, 'DefaultAxesFontSize', 16);
set(groot, 'DefaultTextFontSize', 16);
subplot(2,2,1)
s = scatter3(vibration, current, succesRate, [], succesRate,  'filled');
hold on
h=colorbar;
colormap(flipud(colormap));
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),5))
s.SizeData = 100;
xlabel('Average Fluctuation Amplitude')
ylabel('Internal Tension')
ylim([.1 .61])
zlabel('Success rate')

% figure
subplot(2,2,2)
s = scatter3(vibration, current, succesRate, [], succesRate,  'filled');
hold on
h=colorbar;
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),5))
s.SizeData = 100;
xlabel('Average Fluctuation Amplitude')
ylabel('Internal Tension')
ylim([.1 .61])
zlabel('Success rate')
title('Success vs Drive')
view(90,0)

% figure
subplot(2,2,3)
s = scatter3(vibration, current, succesRate, [], succesRate,  'filled');
hold on
h=colorbar;
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),5))
s.SizeData = 100;
xlabel('Average Fluctuation Amplitude')
xlim([0 70])
ylabel('Internal Tension')
ylim([.1 .61])
zlabel('Success rate')
title('Success vs Vibration')
view(0,0)

% figure
subplot(2,2,4)
s = scatter3(current, vibration, succesRate, [], succesRate,  'filled'); %%axes swapped from intercalation
hold on
h=colorbar;
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),5))
s.SizeData = 100;
ylabel('Average Fluctuation Amplitude')
xlabel('Internal Tension')
xlim([.1 .61])
zlabel('Success rate')
% title('Fluctuation phase portrait')
title('Phase portrait')
ylim([0 70])
view(2)


% phase portrait isolated
figure
current = normalize(current,'range');
vibration = normalize(vibration, 'range');
s = scatter3(current, vibration, succesRate, [], succesRate,  'filled','s'); %%axes swapped from intercalation
hold on
h=colorbar;
colormap(flipud(colormap));
caxis([min(succesRate), max(succesRate)]);
t=get(h,'Limits');
set(h,'Ticks',linspace(t(1),t(2),3))
s.SizeData = 300;
ylabel('Fluctuation Amplitude')
xlabel('Internal Tension')

zlabel('Success rate')
% title('Fluctuation phase portrait')
% title('Phase portrait')
xlim([-0.1 1.1])
xticks([0 0.5 1])
yticks([0 0.5 1])
ylim([-0.15 1.15])

fig = gcf;  % Get current figure handle
fig.Position(3:4) = [500, 300];


grid off
view(2)
