%%simulated phase intercalation
%% this is in the illustrator
x = readtable('fig2e_data.csv');
y = table2array(x);

criticalForce = y(:,3);
motorTorque = y(:,2);
fluctuation = y(:,1);

%load the csv as arrays and take out the NaNs
criticalForce = criticalForce(~isnan(criticalForce)); %this is success rate
fluctuation = fluctuation(~isnan(fluctuation));
motorTorque = motorTorque(~isnan(motorTorque));


criticalForce = normalize(criticalForce, 'range');
motorTorque = normalize(motorTorque, 'range');
fluctuation = normalize(fluctuation, 'range');


figure
hold on
box on
s = scatter3(fluctuation, motorTorque, criticalForce, [], criticalForce,  'filled', 'square');

% cmap = createcolormap( [240 83 49]/256,[255 204 0]/256);
% cmap = createcolormap( [240 83 49]/256,[242 212 142]/256);
cmap = createcolormap( [44 128 175]/256,[232 233 234]/256);
%new colors
% cmap = createcolormap([68 64 65]/256, [242 212 142]/256, [244 163 64]/256);
h=colorbar;
% colormap(flipud(colormap));
colormap(cmap)
caxis([min(criticalForce), max(criticalForce)]);
t=get(h,'Limits');
% set(h,'Ticks',linspace(t(1),t(2),3)) old
set(h,'Ticks', [0 1])
s.SizeData = 100;
xlabel('fluctuation')
ylabel('torque')
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
print(gcf,'-vector','-dsvg',['phaseIntercalateSimNewColor','.svg']) % svg
%% success rate versus torque
figure
hold on
box on

slice = 0.3;
s = scatter(fluctuation(motorTorque==slice), criticalForce(motorTorque==slice), [], criticalForce(motorTorque==slice),  'filled');

cmap = createcolormap([255 204 0]/256, [102 152 0]/256);
h=colorbar;
% colormap(flipud(colormap));
colormap(cmap)
caxis([min(criticalForce), max(criticalForce)]);
t=get(h,'Limits');
% set(h,'Ticks',linspace(t(1),t(2),3)) old
set(h,'Ticks', [0 1])
s.SizeData =200;
xlabel('fluctuation')
ylabel('Success')
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
print(gcf,'-vector','-dsvg',['phaseIntercalateSimSlicefixedTorque','.svg']) % svg

%% success rate versus fluctuation
figure
hold on
box on

% slice = 0.5;
slice = fluctuation(30);
s = scatter(motorTorque(fluctuation==slice), criticalForce(fluctuation==slice), [], criticalForce(fluctuation==slice),  'filled');

cmap = createcolormap([255 204 0]/256, [102 152 0]/256);
h=colorbar;
% colormap(flipud(colormap));
colormap(cmap)
caxis([min(criticalForce), max(criticalForce)]);
t=get(h,'Limits');
% set(h,'Ticks',linspace(t(1),t(2),3)) old
set(h,'Ticks', [0 1])
s.SizeData =200;
xlabel('Torque')
ylabel('Success')
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
print(gcf,'-vector','-dsvg',['phaseIntercalateSimSlicefixedFluct','.svg']) % svg


