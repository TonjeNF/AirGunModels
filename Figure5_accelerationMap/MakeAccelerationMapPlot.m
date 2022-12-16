clear all;close all
addpath('Analytisk');
figure
subplot(3,2,1)
AnalytR_withoutSurface

daspect([1 1 1])
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
xlabel('')
ylabel('depth, m')
% q=colorbar;
% q.Label.String='m/s^2'
w = H.LineWidth;
H.LineWidth = 2;
caxis([0 10])
clabel(c,H,[10 4 2 1 0.5 0.4 0.3 0.2 0.1],'labelspacing',160, 'FontSize', 16);
clear
subplot(3,2,2)
AnalytR_withSurface
daspect([1 1 1])
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
xlabel('')
ylabel('')
q=colorbar;
q.Label.String='m/s^2'
w = H.LineWidth;
H.LineWidth = 2;
caxis([0 10])
clabel(c,H,[10 4 2 1 0.5 0.4 0.3 0.2 0.1],'labelspacing',160, 'FontSize', 16);



 fsize=20;
lineW=1;
lineW_curve=3;
fontN='Calibri';

set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
        'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
    set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);