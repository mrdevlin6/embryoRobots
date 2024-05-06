%% this is in the illustrator
x = readtable('fig2k_data.csv');
y = table2array(x);

criticalForce = y(:,3);
motorTorque = y(:,2);
fluctuation = y(:,1);

%load the csv as arrays and take out the NaNs
criticalForce = criticalForce(~isnan(criticalForce));
fluctuation = fluctuation(~isnan(fluctuation));
motorTorque = motorTorque(~isnan(motorTorque));


criticalForce = normalize(criticalForce, 'range');
motorTorque = normalize(motorTorque, 'range');
fluctuation = normalize(fluctuation, 'range');


figure
hold on
box on
s = scatter3(fluctuation, motorTorque, criticalForce, [], criticalForce,  'filled');

cmap = createcolormap([231 1 1]/256, [69 72 230]/256);
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
fig.Position(3:4) = 3*[200, 175];

H=gca;
H.LineWidth=1; %change to the desired value 


grid off
view(2)
% print(gcf,'-vector','-dsvg',['phaseCompressSim','.svg']) % svg
