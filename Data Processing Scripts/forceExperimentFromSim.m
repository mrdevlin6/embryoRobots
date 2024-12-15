%% attempt to scrape forces

x = readtable('threeCellForce_data.csv');
y = table2array(x);
%%
criticalForce = y(:,3);
motorTorque = y(:,1);
fluctuation = y(:,2);
T1Prob = y(:,4);

% i = 5;
% % j = 5;
% 
% forceBuff = [0];
% 
% y1 = motorTorque(i);
% x1 = fluctuation(i);
% 
% temp = T1Prob(i)-forceBuff(end);
% forceBuff(i) = [forceBuff(i) temp];
% 

%%

output = []; 

X = unique(motorTorque);
Y = unique(fluctuation);

lengthX = size(X);
lengthY = size(Y);

for i = 1:lengthX
    for j = 1:lengthY
        
        torque = X(i);
        fluct = Y(j);

        %stack all critical force probabilities
        % Create logical conditions for x and y coordinates
        x_condition = motorTorque == torque;  % Example condition for x coordinate
        y_condition = fluctuation == fluct;  % Example condition for y coordinate
        
        % Combine conditions for x and y using logical AND (&)
        combined_condition = x_condition & y_condition;
        
        % Use logical indexing to get the desired values for z coordinate
        result = [T1Prob(combined_condition), criticalForce(combined_condition)];
        if ~isempty(result)
            a = result(:,1)-[0; result(1:end-1,1)];
            b = a.*result(:,2);
            F = sum(b)./result(end,1);
            output = [output; [fluct, torque, F]]; %this approach does not allow for standard deviation yet
        end
    end
end
%% this is in the illustrator - Jan 28th
%normalized critical force to the entire dataset and then cropped
figure
hold on
box on
s = scatter3(output(:,1)./0.02, output(:,2)./0.02, output(:,3), 100, output(:,3),  'filled', 'square');

% cmap = createcolormap([232 233 234]/256, [69 72 230]/256);
h=colorbar;
% colormap(flipud(colormap));
% cmap = createcolormap([231 1 1]/256, [198 15 46]/256, [101 58 183]/256, [69 72 230]/256);
% cmap = createcolormap([231 162 186]/256 , [219 57 112]/256,[134 61 85]/256, [68 64 65]/256 );
cmap = createcolormap([232 233 234]/256, [231 162 186]/256 , [219 57 112]/256,[134 61 85]/256);
% % cmap = createcolormap([231 162 186]/256 , [219 57 112]/256, [118 180 170]/256, [118 180 170]/256 );
colormap(cmap)
% caxis([0.11,0.16]);
set(h,'Ticks', [0 1])


x_max = .5;
x_min = 0;
y_max = 1;
y_min = 0.55;
xlim([x_min-0.04 x_max+.04])
ylim([y_min-.04 y_max+.04])
yticks([0.55 1])
xticks([0 .5])


xlabel('fluctuation')
ylabel('torque')

fig = gcf;  % Get current figure handle
fig.Position(1:2) = [500, 200];
fig.Position(3:4) = 3*[200, 175];

H=gca;
H.LineWidth=1; %change to the desired value 
print(gcf,'-vector','-dsvg',['forceExperimentSim_recolor', '.svg']) % svg

%%
% x_max = 0.014;
% x_min = 0.005;
% y_max = 0.02;
% y_min = 0.015;

x_max = 0.008;
x_min = 0;
y_max = 0.02;
y_min = 0.009;


% Create logical conditions for x and y coordinates
x_con = output(:,1) >= x_min & output(:,1) <= x_max;  % Example condition for x coordinate
y_con = output(:,2) >= y_min & output(:,2) <= y_max;  % Example condition for y coordinate

% % Combine conditions for x and y using logical AND (&)
combo = x_con & permute(y_con, [1, 3, 2]);

% output()


outputROI = output(combo,:);

fl = normalize(outputROI(:,1), 'range');
dr = normalize(outputROI(:,2), 'range');
force = normalize(outputROI(:,3), 'range');


figure
hold on
box on
s = scatter3(fl, dr, force, 100, force,  'filled');

cmap = createcolormap([231 1 1]/256, [101 58 183]/256, [69 72 230]/256);
h=colorbar;
% colormap(flipud(colormap));
colormap(cmap)
caxis([min(force), max(force)]);
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
print(gcf,'-vector','-dsvg',['forceExperimentSim','.svg']) % svg

