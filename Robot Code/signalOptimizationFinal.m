%compareSignals
close all
clear all
%% pull data
uniform = readtable("C:\Users\mrdev\Documents\EmbryoJournal\SignalOptimization\SuperUniformCheckFinal1.csv");
gaussian = readtable("C:\Users\mrdev\Documents\EmbryoJournal\SignalOptimization\CenteredGaussian2.csv");
bimodal = readtable("C:\Users\mrdev\Documents\EmbryoJournal\SignalOptimization\bimodalCheckFinal4.csv");

%% get data
% first 3 columns are random values on different robots
uniformData = uniform{:,"x_______________________PuTTYLog2023_05_3111_52_26_____________"};
gaussianData = [gaussian{:, "x_______________________PuTTYLog2023_05_3112_43_53_____________"}];
bimodalData = [bimodal{:, "x_______________________PuTTYLog2023_05_3114_33_31_____________"}];
%%
figure
hold on
histogram(uniformData);
xlabel('Values');
ylabel('Frequency');
title('Uniform distribution');

figure
hold on
histogram(gaussianData);
xlabel('Values');
ylabel('Frequency');
title('Gaussian distribution');

figure
hold on
histogram(bimodalData);
xlabel('Values');
ylabel('Frequency');
title('Bimodal distribution');
%%
uniformSig = [];
gaussianSig = [];
bimodalSig = [];
length1 = 300;

for i = 1:1:length1
    temp = uniformData(i)*ones([1,randi([10, 100])]);
    uniformSig = [uniformSig temp];
    temp2 = gaussianData(i)*ones([1,randi([10, 100])]);
    gaussianSig = [gaussianSig temp2];
    temp3 = bimodalData(i)*ones([1,randi([10, 100])]);
    bimodalSig = [bimodalSig temp3];
end

figure
% Plot the first subplot (top row)
subplot(3, 2, 2);
plot(uniformSig./max(uniformSig), 'LineWidth',1);
yline(110./max(uniformSig), 'LineWidth',1, 'Color', 'r')
title('Uniform distribution');
xlabel('Samples');
ylabel('Internal tension');
ylim([0 1.1])
xlim([1 length(uniformSig)])


% Plot the second subplot (middle row)
subplot(3, 2, 4);
plot(gaussianSig./max(gaussianSig), 'LineWidth',1);
yline(110./max(gaussianSig), 'LineWidth',1, 'Color', 'r')
title('Gaussian distribution');
xlabel('Samples');
ylabel('Internal tension');
ylim([0 1.1])
xlim([1 length(uniformSig)])


% Plot the third subplot (bottom row)
subplot(3, 2, 6);
plot(bimodalSig./max(bimodalSig), 'LineWidth',1);
yline(110./max(bimodalSig), 'LineWidth',1, 'Color', 'r')
title('Bimodal distribution');
xlabel('Samples');
ylabel('Internal tension');
ylim([0 1.1])
xlim([1 length(uniformSig)])
%
subplot(3, 2, 1);
histogram(uniformData);
xline(110, 'LineWidth',1, 'Color', 'r')
xlabel('Values');
ylabel('Frequency');
title('Uniform distribution');
xlim([0 max(uniformData)+10])
xticks([0 max(uniformData)])


% Plot the second subplot (middle row)
subplot(3, 2, 3);
histogram(gaussianData);
xline(110, 'LineWidth',1, 'Color', 'r')
xlabel('Values');
ylabel('Frequency');
title('Gaussian distribution');
xlim([0 max(gaussianData)+10])
xticks([0 max(gaussianData)])

% Plot the third subplot (bottom row)
subplot(3, 2, 5);
histogram(bimodalData);
xline(110, 'LineWidth',1, 'Color', 'r')
xlabel('Values');
ylabel('Frequency');
title('Bimodal distribution');
xlim([0 max(bimodalData)+10])
xticks([0 max(bimodalData)])

print(gcf,'-vector','-dsvg',['signaloptimizationfig','.svg']) % svg
