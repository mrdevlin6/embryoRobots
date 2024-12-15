
cd C:/Users/mrdev/Documents/EmbryoJournal/matlab_functions/

%% 20 cells compression v fluctuation
compression = load("compression_20.mat");
compression = compression.compression_20;

tension = compression(:,1);
fluct = compression(:,2);
fluct = normalize(fluct, 'range');
stress = compression(:,3)./4;
% stress120 = normalize([stress(tension==120)],'range');
stress120 = stress(tension==120)/65.05; %average peak crush force from stress strain data
std = compression(:,4);
stdNorm = std(tension==120)./(max(stress(tension==120))-min(stress(tension==120)));
% stdNorm = std(tension==120)./(max(stress(tension==120))-min(stress(tension==120)));
standardErrorNorm = stdNorm./3;


figure
set(groot, 'DefaultAxesFontSize', 7);
set(groot, 'DefaultTextFontSize', 7);
scatter(fluct(tension==120), stress120, 75, 'filled')
hold on
errorbar(fluct(tension==120), stress120, standardErrorNorm, 'vertical', '.', 'Color','k')


hScatter = findobj(gca, 'Type', 'Scatter');
hErrorBar = findobj(gca, 'Type', 'ErrorBar');


fig = gcf;  % Get current figure handle
fig.Position(3:4) = [75, 200];
H=gca;
H.LineWidth=1;
yticks([0 0.2])
xticks([0 1])


% xlabel("Fluctuation ampltiude")
% ylabel("Stress (N/unit)")
% title("Critical force v fluctuation")

ylim([0 .2])
print(gcf,'-vector','-dsvg',['20unitcompression','.svg']) % svg
