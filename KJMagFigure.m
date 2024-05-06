%% this data belongs to K&J magnets who provided the magnets
%magnet 1 -> m1 is an N42 "D24DIA" magnet with a pull force of 1.16lbs
%magnet 2 -? m2 is an N42 "D36DIA" magnet with a pull force of 2.84lbs
%m2 were used in the robots for the paper

m1x = [0 0.001 0.003 0.004 0.006 0.009 0.013 0.019 0.025 0.038 0.05 0.063 0.075 0.088 0.1 0.113 0.125]*25.4; %in->mm
m1F = [1.16 1.055 0.994 0.945 0.866 0.786 0.721 0.617 0.536 0.416 0.331 0.267 0.219 0.181 0.151 0.127 0.107]*4.44822; %lbs->N
m2x = m1x;
m3x = [0 0.003 0.005 0.008 0.013 0.019 0.025 0.038 0.05 0.075 0.1 0.125 0.15 0.175 0.2 0.225 0.25]*25.4; %in->mm;
m2F = [2.84 2.63 2.51 2.41 2.25 2.08 1.94 1.72 1.53 1.25 1.04 0.88 0.75 0.65 0.56 0.49 0.43]*4.44822; %lbs->N
m3F = [5.26 4.47 4.45 4.21 3.83 3.45 3.14 2.65 2.27 1.72 1.34 1.07 0.86 0.7 0.57 0.47 0.39]*4.44822; %lbs->N
% fit quadratic curves
%%
% dXdata = m1x;
% dYdata = m1F;
% x = linspace(0,100,1000);
% % y = a*exp(-b*x);
% fun2 = @(w,xdata)(w(1)+exp(dXdata*(w(2))));
% x02 = [0,0];
% xFit2 = lsqcurvefit(fun2,x02,dXdata,dYdata);
% yAsy2 = xFit2(1).*x.^(xFit2(2));
% plot(x,yAsy2,dXdata,dYdata,'o'); grid;
% %%
% p2 = polyfit(m2x, m2F, 2);
% m2x_fit = linspace(min(m2x), 10, 100); % Generate x values for plotting
% m2F_fit = polyval(p2, m2x_fit); % Compute corresponding y values using the fitted polynomial coefficients
% 
% 
% 

figure
hold on
box on
plot(m1x, m1F,'LineWidth',1)
plot(m2x, m2F,'LineWidth',1)
plot(m3x-0.8, m3F,'LineWidth',1)

% plot(m1x_fit, m1F_fit, '--', 'LineWidth',1);
% plot(m2x_fit, m2F_fit, '--', 'LineWidth',1);

xline(2, '--', 'LineWidth', 1) %min 2.5mm is distance without window, 2 is tooth size
% yline(1.32, '--', 'LineWidth', 1) %0.135kg*9.81m/s2 ability to hang a robot from another
xline(0)
xlabel("Distance (mm)", 'Color', [0, 0, 0])
ylabel("F_m (N)", 'Color', [0, 0, 0])
xlim([-1 3])
% Set the figure's background color to white (optional)
set(gcf, 'Color', 'w');

% Set the axes properties
ax = gca;
ax.XColor = [0, 0, 0]; % X-axis color
ax.YColor = [0, 0, 0]; % Y-axis color


