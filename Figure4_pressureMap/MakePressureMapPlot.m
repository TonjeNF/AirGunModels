clear all;close all
addpath('TrykkAnalytiskMetode')
addpath('TrykkNumeriskMetode')
figure
subplot(2,2,1)

AnalytR2_141222_noSurface
subplot(2,2,2)
clear
AnalytR2_141222
clear
subplot(2,2,3)
 imptest12F8_withoutSurface
 clear
subplot(2,2,4)
 imptest12F8_withSurface

 fsize=25;
lineW=1;
lineW_curve=3;
fontN='Calibri';

set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
        'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
    set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);