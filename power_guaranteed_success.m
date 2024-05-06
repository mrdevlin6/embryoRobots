 %%power per guaranteed success rate
%% 4 cells

%columns are "Avg energy per trial (J), std of energy, Avg power per trial
%(W), std of power, success rate across >= 10 trials, measured voltage (if
%applicable), mean intercalation rate (1/s), and std of rate"

cd C:/Users/mrdev/Documents/EmbryoJournal/matlab_functions/

energy_four = load("powerData.mat");
energy_four = energy_four.energy;

successes = load("powerDatasuccess.mat");
successes = successes.energy;
unsuccesses = load("powerDatanotsuccess.mat");
unsuccesses = unsuccesses.energy;

%easier to sort the data in excel by power, and then just grab the lowest
%power conditions where successRate == 1
%%
constant = energy_four(energy_four(:,1) == 0, :);
constantSucc = successes(successes(:,1) == 0, :);
constantUnsucc = unsuccesses(unsuccesses(:,1) == 0, :);


sixty = energy_four(energy_four(:,1) == 60, :);
sixtySucc = successes(successes(:,1) == 60, :);
sixtyUnsucc = unsuccesses(unsuccesses(:,1) == 60, :);


sixtySuccConst = sixtySucc(:,5)./(sixtySucc(:,2).*8.2./255); 
sixtySucccurrentstd = sixtySucc(:,6)./(sixtySucc(:,2).*8.2./255);

sixtyUnsuccConst = sixtyUnsucc(:,5)./(sixtyUnsucc(:,2).*8.2./255);
sixtyUnsucccurrentstd = sixtyUnsucc(:,6)./(sixtyUnsucc(:,2).*8.2./255);

sixtyConst = sixty(:,5)./(sixty(:,2).*8.2./255);
sixtycurrentstd = sixty(:,6)./(sixty(:,2).*8.2./255);


currentConst = constant(:,5)./(constant(:,2).*8.2./255);
currentstd = constant(:,6)./(constant(:,2).*8.2./255);

constantSuccConst = constantSucc(:,5)./(constantSucc(:,2).*8.2./255);
constantSuccstd = constantSucc(:,6)./(constantSucc(:,2).*8.2./255);

constantUnsuccConst = constantUnsucc(:,5)./(constantUnsucc(:,2).*8.2./255);
constantUnsuccstd = constantUnsucc(:,6)./(constantUnsucc(:,2).*8.2./255);

%%

x = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;constant(:,2); sixty(:,2)];
y = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;constant(:,5); sixty(:,5)];

% Compute linear regression parameters (slope and intercept)
coefficients = polyfit(x, y, 1);
slope = coefficients(1);
intercept = coefficients(2);

% Plot the linear trendline
x_trendline = linspace(min(x), max(x), 100);
y_trendline = slope * x_trendline + intercept;




figure
set(groot, 'DefaultAxesFontSize', 16); %usually 16 for me
set(groot, 'DefaultTextFontSize', 16);
scatter(constant(:,2), constant(:,5), 70, 'filled');
hold on
scatter(sixty(:,2), sixty(:,5), 70, 'filled');
errorbar(constant(:,2), constant(:,5), constant(:,6)./sqrt(10), 'vertical', '.', 'Color','k')
errorbar(sixty(:,2), sixty(:,5), sixty(:,6)./sqrt(10), 'vertical', '.', 'Color','k')
plot(x_trendline, y_trendline, 'r', 'LineWidth', 2);
xlabel('voltage')
ylabel('power')
xlim([0 170])
xticks([0 160])
ylim([0 6])
legend('constant', 'fluctuating')
%% constant double axes
figure
set(groot, 'DefaultAxesFontSize', 16); %usually 16 for me
set(groot, 'DefaultTextFontSize', 16);
yyaxis left
scatter(constant(:,2), constant(:,5), 70, 'filled');
hold on
% scatter(sixty(:,2), sixty(:,5), 70, 'filled');
errorbar(constant(:,2), constant(:,5), constant(:,6), 'vertical', '.', 'Color','k')
% errorbar(sixty(:,2), sixty(:,5), sixty(:,6), 'vertical', '.', 'Color','k')
xlabel('voltage')
ylabel('power')
xlim([0 170])
ylim([0 6])

yyaxis right
scatter(constant(:,2), currentConst, 70, 'filled');
hold on
% scatter(sixty(:,2), sixtyConst, 70, 'filled';
errorbar(constant(:,2), currentConst, currentstd, 'vertical', '.', 'Color','k')
% errorbar(sixty(:,2), sixtyConst, sixtycurrentstd, 'vertical', '.', 'Color','k')
xlabel('voltage')
ylabel('current')
title('constant data')

xline(130) %guaranteed success

ylim([0 1.5])

%% fluctuating double axes
figure
set(groot, 'DefaultAxesFontSize', 16); %usually 16 for me
set(groot, 'DefaultTextFontSize', 16);
yyaxis left
% scatter(constant(:,2), constant(:,5), 70, 'filled');
hold on
scatter(sixty(:,2), sixty(:,5), 70, 'filled');
% errorbar(constant(:,2), constant(:,5), constant(:,6), 'vertical', '.', 'Color','k')
errorbar(sixty(:,2), sixty(:,5), sixty(:,6), 'vertical', '.', 'Color','k')
xlabel('voltage')
ylabel('power')
xlim([0 170])
ylim([0 6])

yyaxis right
% scatter(constant(:,2), currentConst, 70, 'filled');
hold on
scatter(sixty(:,2), sixtyConst, 70, 'filled');
% errorbar(constant(:,2), currentConst, currentstd, 'vertical', '.', 'Color','k')
errorbar(sixty(:,2), sixtyConst, sixtycurrentstd, 'vertical', '.', 'Color','k')
xlabel('voltage')
ylabel('current')
title('fluctuating data')

xline(80) %guaranteed success

ylim([0 1.5])
%% constant double axes, current vs rate vs voltage (x)
figure
set(groot, 'DefaultAxesFontSize', 16); %usually 16 for me
set(groot, 'DefaultTextFontSize', 16);

% yyaxis left
% set(groot, 'DefaultAxesFontSize', 16); %usually 16 for me
% set(groot, 'DefaultTextFontSize', 16);

yyaxis left
% scatter(constant(:,2), constant(:,5), 70, 'filled');
hold on
scatter(sixty(:,2), sixty(:,5), 70, 'filled');
% errorbar(constant(:,2), constant(:,5), constant(:,6), 'vertical', '.', 'Color','k')
errorbar(sixty(:,2), sixty(:,5), sixty(:,6), 'vertical', '.', 'Color','k')
xlabel('voltage')
ylabel('power')
xlim([0 170])
ylim([0 6])

% yyaxis left
% scatter(constant(:,2), currentConst, 70, 'filled');
% hold on
% % scatter(sixty(:,2), sixtyConst, 70, 'filled');
% errorbar(constant(:,2), currentConst, currentstd, 'vertical', '.', 'Color','k')
% % errorbar(sixty(:,2), sixtyConst, sixtycurrentstd, 'vertical', '.', 'Color','k')
% xlabel('voltage')
% ylabel('current')

% ylim([0 3])

yyaxis right
% scatter(constant(:,2), constant(:,9), 70, 'filled');
hold on
scatter(sixty(:,2), sixty(:,9), 70, 'filled');
% errorbar(constant(:,2), constant(:,9), constant(:,10), 'vertical', '.', 'Color','k')
errorbar(sixty(:,2), sixty(:,9), sixty(:,10), 'vertical', '.', 'Color','k')
xlabel('voltage')
ylabel('rate')
title('fluctuating data')

xline(80, 'color', 'g') %guaranteed success
xlim([0 170])
ylim([0 3])
%%
figure
scatter(constant(:,2), currentConst, 70, 'filled');
hold on
scatter(sixty(:,2), sixtyConst, 70, 'filled');
errorbar(constant(:,2), currentConst, currentstd, 'vertical', '.', 'Color','k')
errorbar(sixty(:,2), sixtyConst, sixtycurrentstd, 'vertical', '.', 'Color','k')
xlabel('voltage')
ylabel('current')
xlim([0 170])
ylim([0 1.5])
legend('constant', 'fluctuating')
%% voltage current successfull vs unsuccessful
figure
scatter(constantSucc(:,2), constantSuccConst, 70, 'filled');
hold on
scatter(constantUnsucc(:,2), constantUnsuccConst, 70, 'filled');
errorbar(constantSucc(:,2), constantSuccConst, constantSuccstd, 'vertical', '.', 'Color','k')
errorbar(constantUnsucc(:,2), constantUnsuccConst, constantUnsuccstd, 'vertical', '.', 'Color','k')
xlabel('voltage')
ylabel('current')
xlim([0 170])
ylim([0 1.5])
legend('successful', 'unsuccessful')
title('constant')

figure
scatter(sixtySucc(:,2), sixtySuccConst, 70, 'filled');
hold on
scatter(sixtyUnsucc(:,2), sixtyUnsuccConst, 70, 'filled');
errorbar(sixtySucc(:,2), sixtySuccConst, sixtySucccurrentstd, 'vertical', '.', 'Color','k')
errorbar(sixtyUnsucc(:,2), sixtyUnsuccConst, sixtyUnsucccurrentstd, 'vertical', '.', 'Color','k')
xlabel('voltage')
ylabel('current')
xlim([0 170])
ylim([0 1.5])
legend('successful', 'unsuccessful')
title('fluctuating')
%%
figure
scatter(currentConst, constant(:,7), 70, 'filled');
hold on
scatter(sixtyConst, sixty(:,7), 70, 'filled');
errorbar(currentConst, constant(:,7), currentstd, 'horizontal', '.', 'Color','k')
errorbar(sixtyConst, sixty(:,7), sixtycurrentstd, 'horizontal', '.', 'Color','k')
% errorbar(constant(:,2), currentConst, currentstd, 'vertical', '.', 'Color','k')
xlabel('Current (torque?)')
ylabel('Success rate')
xlim([0 1.5])
ylim([0 1.1])
legend('constant', 'fluctuating')
%%
figure
set(groot, 'DefaultAxesFontSize', 16); %usually 16 for me
set(groot, 'DefaultTextFontSize', 16);
scatter(constant(:,5), constant(:,7), 70, 'filled');
hold on
scatter(sixty(:,5), sixty(:,7), 70, 'filled');
errorbar(constant(:,5), constant(:,7), constant(:,6), 'horizontal', '.', 'Color','k')
errorbar(sixty(:,5), sixty(:,7), sixty(:,6), 'horizontal', '.', 'Color','k')
xlabel('power')
ylabel('success rate')
legend('constant', 'fluctuating')
% xlim([0 2])
ylim([0 1.1])

%% This one in illustrator

% p = 6.0922e-07
meansConstShape = [3633.225 3957.762 2954.615 3832.962 4389.368 3841.692 4243.967 3912.4 3457.541 4917.767]./1000;
meansFluctShape = [2218.5 2476.709 2644.351 2496.209 2544.413 2857.57 2837.1 2691.256 2482.409 2416.395]./1000;

[h,p,ci,stats] = ttest2(meansConstShape,meansFluctShape)

%data -> fluctuation, power, std
basal = 1.6;% 0 40 free spin power?
% basal = 0.2;
% data = [0, 3.235048-basal, 0.323822; 60, 2.401912-basal, 0.22102];
% data = [0, 3.235048, 0.323822; 60, 2.401912, 0.22102];
data = [0 mean(meansConstShape) std(meansConstShape)/sqrt(length(meansConstShape)); 60 mean(meansFluctShape) std(meansFluctShape)/sqrt(length(meansFluctShape));]

figure;
set(groot, 'DefaultAxesFontSize', 7); %usually 16 for me
set(groot, 'DefaultTextFontSize', 7);
bar(data(:,2), 'linewidth', 1);
hold on
errorbar([1:numel(data(:,2))], data(:,2), data(:,3), 'k', 'linestyle', 'none', 'linewidth', 1);

% Set the x-axis labels
% xlabels = {'Constant' 'Fluctuating'};
set(gca, 'XTickLabel', {'0', '1'});

% Add axis labels and a title
% ylabel('Minimum power for guaranteed success');
% title('4 cells intercalating');

fig = gcf;  % Get current figure handle
w = 125;
fig.Position(3:4) = [w, w*3/4];
H=gca;
H.LineWidth=1;
ylim([basal 4.6])
yticks([basal 4])


%% this one in illustrator for softening power
% softening significance two tailed t test for difference with 0.0056 p value rejects null hypothesis of the same mean
meansFluct = [2252.729 2148.462 1810.893 980.7407]./1000;
meansConst = [4070.889 6269.467 5746.603 3437.861]./1000;

x = meansConst;
% x = 
% [h,p,ci,stats] = ttest2(x,y)

basal = 1.6;
% basal = 0.2; %for nonfluct case
% data = [0, 3.7518-basal, 0.5184591; 60, 1.753-basal, 0.5527859];
data = [0, 3.7518, 0.5184591; 60, 1.753, 0.5527859];
data = [0 mean(meansConst) std(meansConst)/sqrt(length(meansConst)); 60 mean(meansFluct) std(meansFluct)/sqrt(length(meansFluct));]

figure;
set(groot, 'DefaultAxesFontSize', 7); %usually 16 for me
set(groot, 'DefaultTextFontSize', 7);
bar(data(:,2), 'linewidth', 1);
hold on
errorbar([1:numel(data(:,2))], data(:,2), data(:,3), 'k', 'linestyle', 'none', 'linewidth', 1);

% Set the x-axis labels
% xlabels = {'Constant' 'Fluctuating'};
set(gca, 'XTickLabel', {'0', '1'});

% Add axis labels and a title
% ylabel('Minimum power for guaranteed success');
% title('4 cells intercalating');

fig = gcf;  % Get current figure handle
w = 125;
fig.Position(3:4) = [w, w*3/4];
H=gca;
H.LineWidth=1;
% ylim([0 4.6])
ylim([basal 5.7])
yticks([basal 5])
%
%check significance


y = meansFluct;
[h,p,ci,stats] = ttest2(x,y)

%%