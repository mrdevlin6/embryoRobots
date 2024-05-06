%%20 unit video processing

%% scrape

% Specify the path to the parent folder
parentFolder = 'C:\Users\mrdev\Documents\EmbryoJournal\twenties';

% Get a list of all CSV files in the parent folder and its subfolders
csvFiles = dir(fullfile(parentFolder, '**', '*.csv'));

% Loop through each CSV file
for i = 1:length(csvFiles)
    % Construct the full path to the current CSV file
    csvFilePath = fullfile(csvFiles(i).folder, csvFiles(i).name);

    % Generate a variable name based on the file name
    [~, fileName, ~] = fileparts(csvFilePath);
    variableName = genvarname([fileName]);

    % Load data from the CSV file using readtable
    eval([variableName ' = readtable(csvFilePath);']); % or use csvread for numeric data

    % Display the loaded data
    disp(['Loaded data from ' csvFilePath ' into variable ' variableName]);
end
%% process
% figure
% hold on
% box on
%
px2m1 = 0.3048/max(data_100_0_1.Length);
d100_0_1 = [0.5*data_100_0_1.Var1(1:60) px2m1*data_100_0_1.Width(1:60) px2m1*data_100_0_1.Height(1:60)];

px2m1 = 0.3048/max(data_100_0_2.Length);
d100_0_2 = [0.5*data_100_0_2.Var1(1:60) px2m1*data_100_0_2.Width(1:60) px2m1*data_100_0_2.Height(1:60)];

px2m1 = 0.3048/max(data_100_0_3.Length);
d100_0_3 = [0.5*data_100_0_3.Var1(1:60) px2m1*data_100_0_3.Width(1:60) px2m1*data_100_0_3.Height(1:60)];
%
px2m1 = 0.3048/max(data_100_30_1.Length);
d100_30_1 = [0.5*data_100_30_1.Var1(1:60) px2m1*data_100_30_1.Width(1:60) px2m1*data_100_30_1.Height(1:60)];

px2m1 = 0.3048/max(data_100_30_2.Length);
d100_30_2 = [0.5*data_100_30_2.Var1(1:60) px2m1*data_100_30_2.Width(1:60) px2m1*data_100_30_2.Height(1:60)];

px2m1 = 0.3048/max(data_100_30_3.Length);
d100_30_3 = [0.5*data_100_30_3.Var1(1:60) px2m1*data_100_30_3.Width(1:60) px2m1*data_100_30_3.Height(1:60)];
%
px2m1 = 0.3048/max(data_100_60_1.Length);
d100_60_1 = [0.5*data_100_60_1.Var1(1:60) px2m1*data_100_60_1.Width(1:60) px2m1*data_100_60_1.Height(1:60)];

px2m1 = 0.3048/max(data_100_60_2.Length);
d100_60_2 = [0.5*data_100_60_2.Var1(1:60) px2m1*data_100_60_2.Width(1:60) px2m1*data_100_60_2.Height(1:60)];

px2m1 = 0.3048/max(data_100_60_3.Length);
d100_60_3 = [0.5*data_100_60_3.Var1(1:60) px2m1*data_100_60_3.Width(1:60) px2m1*data_100_60_3.Height(1:60)];

clear data_100_0_1
clear data_100_0_2
clear data_100_0_3
clear data_100_30_1
clear data_100_30_2
clear data_100_30_3
clear data_100_60_1
clear data_100_60_2
clear data_100_60_3


%[time width height]
%% [time width height]

time = d100_60_3(:,1);

width0 = mean([d100_0_1(:,2) d100_0_2(:,2) d100_0_3(:,2)],2);
width0err = std([d100_0_1(:,2) d100_0_2(:,2) d100_0_3(:,2)], 0, 2);

width30 = mean([d100_30_1(:,2) d100_30_2(:,2) d100_30_3(:,2)],2);
width30err = std([d100_30_1(:,2) d100_30_2(:,2) d100_30_3(:,2)], 0, 2);

width60 = mean([d100_60_1(:,2) d100_60_2(:,2) d100_60_3(:,2)],2);
width60err = std([d100_60_1(:,2) d100_60_2(:,2) d100_60_3(:,2)], 0, 2);

%

height0 = mean([d100_0_1(:,3) d100_0_2(:,3) d100_0_3(:,2)],2);
height0err = std([d100_0_1(:,3) d100_0_2(:,3) d100_0_3(:,3)], 0, 2);

height30 = mean([d100_30_1(:,3) d100_30_2(:,3) d100_30_3(:,3)],2);
height30err = std([d100_30_1(:,3) d100_30_2(:,3) d100_30_3(:,3)], 0, 2);

height60 = mean([d100_60_1(:,3) d100_60_2(:,3) d100_60_3(:,3)],2);
height60err = std([d100_60_1(:,3) d100_60_2(:,3) d100_60_3(:,3)], 0, 2);


ar0 = mean([d100_0_1(:,2)./d100_0_1(:,3) d100_0_3(:,2)./ d100_0_2(:,3) d100_0_3(:,2)./d100_0_3(:,3)],2);
ar0err = std([d100_0_1(:,2)./d100_0_1(:,3) d100_0_3(:,2)./ d100_0_2(:,3) d100_0_3(:,2)./d100_0_3(:,3)], 0, 2);

ar30 = mean([d100_30_1(:,2)./d100_30_1(:,3) d100_30_3(:,2)./ d100_30_2(:,3) d100_30_3(:,2)./d100_30_3(:,3)],2);
ar30err = std([d100_30_1(:,2)./d100_30_1(:,3) d100_30_3(:,2)./ d100_30_2(:,3) d100_30_3(:,2)./d100_30_3(:,3)], 0, 2);

ar60 = mean([d100_60_1(:,2)./d100_60_1(:,3) d100_60_3(:,2)./ d100_60_2(:,3) d100_60_3(:,2)./d100_60_3(:,3)],2);
ar60err = std([d100_60_1(:,2)./d100_60_1(:,3) d100_60_3(:,2)./ d100_60_2(:,3) d100_60_3(:,2)./d100_60_3(:,3)], 0, 2);


v0 = mean([diff(d100_0_1(:,2))./diff(time) diff(d100_0_2(:,2))./diff(time) diff(d100_0_3(:,2))./diff(time)],2);
v0err = std([diff(d100_0_1(:,2))./diff(time) diff(d100_0_2(:,2))./diff(time) diff(d100_0_3(:,2))./diff(time)], 0, 2);

v30 = mean([diff(d100_30_1(:,2))./diff(time) diff(d100_30_2(:,2))./diff(time) diff(d100_30_3(:,2))./diff(time)],2);
v30err = std([diff(d100_30_1(:,2))./diff(time) diff(d100_30_2(:,2))./diff(time) diff(d100_30_3(:,2))./diff(time)], 0, 2);

v60 = mean([diff(d100_60_1(:,2))./diff(time) diff(d100_60_2(:,2))./diff(time) diff(d100_60_3(:,2))./diff(time)],2);
v60err = std([diff(d100_60_1(:,2))./diff(time) diff(d100_60_2(:,2))./diff(time) diff(d100_60_3(:,2))./diff(time)], 0, 2);



figure
hold on
box on
plot(time, width0, 'LineWidth', 2)
plot(time, width30, 'LineWidth', 2)
plot(time, width60, 'LineWidth', 2)
plotErrorRegion(time, width0, width0err/sqrt(3))
plotErrorRegion(time, width30, width30err/sqrt(3))
plotErrorRegion(time, width60, width60err/sqrt(3))

legend('0', '30', '60', 'Location','NorthWest')

ylabel('Width (m)')
xlabel('Time (s)')
ylim([0.3 1])
%%




figure
hold on
box on
plot(time, width0, 'LineWidth', 2)
plot(time, width30, 'LineWidth', 2)
plot(time, width60, 'LineWidth', 2)
plotErrorRegion(time, width0, width0err/sqrt(3))
plotErrorRegion(time, width30, width30err/sqrt(3))
plotErrorRegion(time, width60, width60err/sqrt(3))

legend('0', '30', '60', 'Location','NorthWest')

ylabel('Width (m)')
xlabel('Time (s)')
ylim([0.3 1])

%%

figure
hold on
box on
plot(time, height0, 'LineWidth', 2)
plot(time, height30, 'LineWidth', 2)
plot(time, height60, 'LineWidth', 2)
plotErrorRegion(time, height0, height0err/sqrt(3))
plotErrorRegion(time, height30, height30err/sqrt(3))
plotErrorRegion(time, height60, height60err/sqrt(3))

legend('0', '30', '60', 'Location','NorthWest')

ylabel('Height (m)')
xlabel('Time (s)')
ylim([0.1 .8])

figure
hold on
box on
plot(time, ar0, 'LineWidth', 2)
plot(time, ar30, 'LineWidth', 2)
plot(time, ar60, 'LineWidth', 2)
plotErrorRegion(time, ar0, ar0err/sqrt(3))
plotErrorRegion(time, ar30, ar30err/sqrt(3))
plotErrorRegion(time, ar60, ar60err/sqrt(3))

legend('0', '30', '60', 'Location','NorthWest')

ylabel('Aspect Ratio (width/height')
xlabel('Time (s)')
ylim([0.5 5])

figure
hold on
box on
buff = 10;
plot(time(2:end), smooth(v0,buff), 'LineWidth', 2)
plot(time(2:end), smooth(v30,buff), 'LineWidth', 2)
plot(time(2:end), smooth(v60,buff), 'LineWidth', 2)
plotErrorRegion(time(2:end), smooth(v0,buff), smooth(v0err/sqrt(3),buff))
plotErrorRegion(time(2:end), smooth(v30,buff), smooth(v30err/sqrt(3),buff))
plotErrorRegion(time(2:end), smooth(v60,buff), smooth(v60err/sqrt(3),buff))

legend('0', '30', '60', 'Location','NorthWest')

ylabel('Velocity (m/s)')
xlabel('Time (s)')
% ylim([0.5 5])

%% rearrangement data

dataTable = table2array(readtable('C:\Users\mrdev\Documents\EmbryoJournal\rearrange20data.csv'));
%%
t = dataTable(1,2:end);
r0_1 = dataTable(2,2:end);
r0_2 = dataTable(3,2:end);
r0_3 = dataTable(4,2:end);

r30_1 = dataTable(5,2:end);
r30_2 = dataTable(6,2:end);
r30_3 = dataTable(7,2:end);

r60_1 = dataTable(8,2:end);
r60_2 = dataTable(9,2:end);
r60_3 = dataTable(10,2:end);

figure
hold on
box on
plot(t,r0_1, 'Color', 'k', 'LineWidth', 1)
plot(t,r0_2, 'Color', 'k', 'LineWidth', 1)
plot(t,r0_3, 'Color', 'k', 'LineWidth', 1)
plot(t,r30_1,'Color', 'g', 'LineWidth', 1)
plot(t,r30_2,'Color', 'g', 'LineWidth', 1)
plot(t,r30_3,'Color', 'g', 'LineWidth', 1)
plot(t,r60_1,'Color', 'r', 'LineWidth', 1)
plot(t,r60_2,'Color', 'r', 'LineWidth', 1)
plot(t,r60_3,'Color', 'r', 'LineWidth', 1)
ylabel('Rearrangements')
xlabel('time (s)')


%

r0 = mean([r0_1; r0_2; r0_3]);
r0err = std([r0_1; r0_2; r0_3]);

r30 = mean([r30_1; r30_2; r30_3]);
r30err = std([r30_1; r30_2; r30_3]);

r60 = mean([r60_1; r60_2; r60_3]);
r60err = std([r60_1; r60_2; r60_3]);

figure
hold on
box on
plot(t,r0, 'LineWidth', 1)
plot(t,r30, 'LineWidth', 1)
plot(t,r60, 'LineWidth', 1)
plotErrorRegion(t',r0',r0err'/sqrt(3))
plotErrorRegion(t',r30',r30err'/sqrt(3))
plotErrorRegion(t',r60',r60err'/sqrt(3))

legend('0', '30', '60', 'Location','NorthWest')
ylabel('Rearrangements')
xlabel('time (s)')
ylim([0 60])

%
figure;
barValues = [r0(end) r30(end) r60(end)];  % Assuming you want to plot the first three rows
bar(barValues);

hold on;

% Add error bars
errorbar([1, 2, 3], barValues, [r0err(end)/sqrt(3) r30err(end)/sqrt(3) r60err(end)/sqrt(3)], 'k.', 'LineWidth', 1.5);

xlabel('Fluctuation amplitude');
ylabel('Rearrangements');

xticks([1, 2, 3]);
xticklabels({'0', '0.5', '1'});

%% rearrangement versus width all scatter
figure
hold on
box on
scatter(d100_0_1(:,2),r0_1(1:end-1), 'LineWidth', 1)
scatter(d100_0_2(:,2),r0_2(1:end-1), 'LineWidth', 1)
scatter(d100_0_3(:,2),r0_3(1:end-1), 'LineWidth', 1)
scatter(d100_30_1(:,2),r30_1(1:end-1), 'LineWidth', 1)
scatter(d100_30_2(:,2),r30_2(1:end-1), 'LineWidth', 1)
scatter(d100_30_3(:,2),r30_3(1:end-1), 'LineWidth', 1)
scatter(d100_60_1(:,2),r60_1(1:end-1), 'LineWidth', 1)
scatter(d100_60_2(:,2),r60_2(1:end-1), 'LineWidth', 1)
scatter(d100_60_3(:,2),r60_3(1:end-1), 'LineWidth', 1)

%line of best fit
x_a = [d100_0_1(:,2);d100_0_2(:,2);d100_0_3(:,2);d100_30_1(:,2);d100_30_2(:,2);d100_30_3(:,2);d100_60_1(:,2);d100_60_2(:,2);d100_60_3(:,2)];
y_a = [r0_1(1:end-1),r0_2(1:end-1),r0_3(1:end-1),r30_1(1:end-1),r30_2(1:end-1),r30_3(1:end-1),r60_1(1:end-1),r60_2(1:end-1),r60_3(1:end-1)]';

coefficient = polyfit(x_a, y_a, 1);
% coefficient(2) = 0; %force to start at 0

x_fit = linspace(min(x_a), max(x_a), 100);
y_fit = polyval(coefficient, x_fit);

% Plot the line of best fit
plot(x_fit, y_fit, 'r-', 'LineWidth', 2, 'DisplayName', 'Line of Best Fit');

% scatter(width30,r30(1:end-1), 'LineWidth', 1)
% scatter(width60,r60(1:end-1), 'LineWidth', 1)
% plotErrorRegion(width0,r0(1:end-1)',r0err(1:end-1)'/sqrt(3))
% plotErrorRegion(width30,r30(1:end-1)',r30err(1:end-1)'/sqrt(3))
% plotErrorRegion(width60,r60(1:end-1)',r60err(1:end-1)'/sqrt(3))

legend('0', '30', '60', 'Location','NorthWest')
ylabel('Rearrangements')
xlabel('Width (m)')
ylim([0 60])
% Display the R-value as text on the plot
r_value = corr(x_a, y_a);
text(0.5, max(y_a) - 0.1, ['R = ' num2str(r_value)], 'FontSize', 10);


%% rearrangement versus aspect ratio means

figure
hold on
box on

% scatter(width0,r0(1:end-1), 'k','filled')
% scatter(width30,r30(1:end-1), 'k', 'filled')
% scatter(width60,r60(1:end-1), 'k', 'filled')

% scatter(width0,r0(1:end-1), 'filled')
% scatter(width30,r30(1:end-1), 'filled')
% scatter(width60,r60(1:end-1), 'filled')

% this is good
% scatter(r0(1:end-1),ar0, 'filled', 'k')
% scatter(r30(1:end-1),ar30, 'filled','k')
% scatter(r60(1:end-1),ar60, 'filled','k')



% plotErrorRegion(r60(1:end-1)', ar60, ar60err/sqrt(3))
% plotErrorRegion(r30(1:end-1)', ar30, ar30err/sqrt(3))
% plotErrorRegion(r0(1:end-1)', ar0, ar0err/sqrt(3))

[rearrange, idxs] = sort([r0(1:end-1) r30(1:end-1) r60(1:end-1)]');
ars = [ar0; ar30; ar60];
arserr = [ar0err; ar30err; ar60err]/sqrt(3);

buff = 10;
x = smooth(rearrange, buff);
y = smooth(ars(idxs), buff);
z = smooth(arserr(idxs), buff);
plot(x,y,'k')
plotErrorRegion(x, y,z)

% plotErrorRegion(r0(1:end-1)', ar0, ar0err/sqrt(3))

hScatter = findobj(gca, 'Type', 'Scatter');
hErrorBar = findobj(gca, 'Type', 'ErrorBar');

%line of best fit
y_a1 = [ar0;ar30;ar60];
x_a1 = [r0(1:end-1)';r30(1:end-1)';r60(1:end-1)'];

coefficients = polyfit(x_a1, y_a1, 1);
% coefficient(2) = 0; %force to start at 0

x_fit1 = linspace(min(x_a1), max(x_a1), 100);
y_fit1 = polyval(coefficients, x_fit1);

% Plot the line of best fit
plot(x_fit1, y_fit1, 'r-', 'LineWidth', 2, 'DisplayName', 'Line of Best Fit');


% plotErrorRegion(width0,r0(1:end-1)',r0err(1:end-1)'/sqrt(3))
% plotErrorRegion(width30,r30(1:end-1)',r30err(1:end-1)'/sqrt(3))
% plotErrorRegion(width60,r60(1:end-1)',r60err(1:end-1)'/sqrt(3))

% legend('0', '30', '60', 'Location','NorthWest')
ylabel('Aspect ratio')
xlabel('Rearrangements')
% ylim([0 60])
% Display the R-value as text on the plot
r_value = corr(x_a1, y_a1)
text(25, max(y_a1) + 5, ['R = ' num2str(r_value)], 'FontSize', 10);

print(gcf,'-vector','-dsvg',['rearrangementVAspectRatio','.svg']) % svg

%%
figure;
barValues = [r0(end) r30(end) r60(end)];  % Assuming you want to plot the first three rows
bar(barValues);

hold on;

% Add error bars
errorbar([1, 2, 3], barValues, [r0err(end)/sqrt(3) r30err(end)/sqrt(3) r60err(end)/sqrt(3)], 'k.', 'LineWidth', 1.5);

xlabel('Fluctuation amplitude');
ylabel('Rearrangements');

xticks([1, 2, 3]);
xticklabels({'0', '0.5', '1'});



%% average velocity for the first 15 seconds

v0 = mean([diff(d100_0_1(:,2))./diff(time) diff(d100_0_2(:,2))./diff(time) diff(d100_0_3(:,2))./diff(time)],2);
v0err = std([diff(d100_0_1(:,2))./diff(time) diff(d100_0_2(:,2))./diff(time) diff(d100_0_3(:,2))./diff(time)], 0, 2);

v30 = mean([diff(d100_30_1(:,2))./diff(time) diff(d100_30_2(:,2))./diff(time) diff(d100_30_3(:,2))./diff(time)],2);
v30err = std([diff(d100_30_1(:,2))./diff(time) diff(d100_30_2(:,2))./diff(time) diff(d100_30_3(:,2))./diff(time)], 0, 2);

v60 = mean([diff(d100_60_1(:,2))./diff(time) diff(d100_60_2(:,2))./diff(time) diff(d100_60_3(:,2))./diff(time)],2);
v60err = std([diff(d100_60_1(:,2))./diff(time) diff(d100_60_2(:,2))./diff(time) diff(d100_60_3(:,2))./diff(time)], 0, 2);

%
tt = 15; %seconds
[v00err, v00mean] = std(v0(1:2*tt));
[v300err, v300mean] = std(v30(1:2*tt));
[v600err, v600mean] = std(v60(1:2*tt));


figure;
barValues = [v00mean v300mean v600mean];  
bar(barValues);

hold on;

% Add error bars
errorbar([1, 2, 3], barValues, [v00err(end)/sqrt(3) v300err(end)/sqrt(3) v600err(end)/sqrt(3)], 'k.', 'LineWidth', 1.5);

xlabel('Fluctuation amplitude');
ylabel('Velocity');

xticks([1, 2, 3]);
xticklabels({'0', '0.5', '1'});
%% peak velocity
[v0errmax, v0max] = std([max(diff(d100_0_1(:,2))./diff(time)) max(diff(d100_0_2(:,2))./diff(time)) max(diff(d100_0_3(:,2))./diff(time))]);
[v30errmax, v30max] = std([max(diff(d100_30_1(:,2))./diff(time)) max(diff(d100_30_2(:,2))./diff(time)) max(diff(d100_30_3(:,2))./diff(time))]);
[v60errmax, v60max] = std([max(diff(d100_60_1(:,2))./diff(time)) max(diff(d100_60_2(:,2))./diff(time)) max(diff(d100_60_3(:,2))./diff(time))]);

figure;
barValues = [v0max v30max v60max];  
bar(barValues);

hold on;

% Add error bars
errorbar([1, 2, 3], barValues, [v0errmax(end)/sqrt(3) v30errmax(end)/sqrt(3) v60errmax(end)/sqrt(3)], 'k.', 'LineWidth', 1.5);

xlabel('Fluctuation amplitude');
ylabel('Peak Velocity');

xticks([1, 2, 3]);
xticklabels({'0', '0.5', '1'});
%%

function plotErrorRegion(time, meanValues, stdError)
    % Check if the input sizes match
    if numel(time) ~= numel(meanValues) || numel(meanValues) ~= numel(stdError)
        error('Input sizes must match.');
    end

    % Calculate upper and lower bounds for the error region
    upperBound = meanValues + stdError;
    lowerBound = meanValues - stdError;

    % Create a figure
%     figure;

    % Plot the mean line
%     plot(time, meanValues, 'LineWidth', 2, 'Color', 'blue');
%     hold on;
    [time, idx] = sort(time);
    % Create shaded error region centered around the mean
    shaded_time = [time', flip(time)'];
    shaded_values = [upperBound(idx)', flip(lowerBound(idx))'];

    fill(smooth(shaded_time,1), smooth(shaded_values,1), 'b', 'FaceAlpha', 0.1);

%     xlabel('Time');
%     ylabel('Mean Values');
%     title('Mean Values vs Time with Centered Shaded Error Region');
end

