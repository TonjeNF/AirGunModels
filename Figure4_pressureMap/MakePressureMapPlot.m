clear all;close all
addpath('TrykkAnalytiskMetode')
addpath('TrykkNumeriskMetode')
s = get(0, 'ScreenSize');
fig = figure('Position', [0 0 s(4) s(4)]);
subplot(2,2,1)

AnalytR2_141222_noSurface
[c,H]=contour(X,-Z,abs(B*p'),0:200:8000);
%title(['Pressure Pa,  AnalytR, frq = ' num2str(f) ' Hz, delta =  500  Pa, R = ' num2str(R2) ', d = ' num2str(d) ' m'])
clabel(c,H,0:1000:5000, 'FontSize', 22);
w = H.LineWidth;
H.LineWidth = 2;
daspect([1 1 1])
clim([1000 8000])
%xlabel('Range -m')
ylabel('z (m)')
grid
hold on
sym='ko';

%set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
scatter(2.8,-2.5,150,sym,'filled')
scatter(4.2,-4,150,sym,'filled')
scatter(4.2,-2.5,150,sym,'filled')
scatter(4.2,-1,150,sym,'filled')
scatter(5.7,-2.5,150,sym,'filled')
text(8,-1,'A','Fontsize',40)

subplot(2,2,2)
clear
AnalytR2_141222
[c,H]=contour(X,-Z,abs(B*p'),0:200:8000);
clabel(c,H,0:1000:5000, 'FontSize', 22);
w = H.LineWidth;
H.LineWidth = 2;
daspect([1 1 1])
q=colorbar;
q.Label.String='Pa';
clim([1000 8000])
% uicontrol('Style','text','Units','pixels','Position',[1557 970 135 20], ...
%           'String','B','FontSize',30);
grid
sym='ko';
hold on
scatter(2.8,-2.5,150,sym,'filled')
scatter(4.2,-4,150,sym,'filled')
scatter(4.2,-2.5,150,sym,'filled')
scatter(4.2,-1,150,sym,'filled')
scatter(5.7,-2.5,150,sym,'filled')
text(8,-1,'B','Fontsize',40)
clear
subplot(2,2,3)
 imptest12F8_withoutSurface
 [c,H]=contour(x,-z,P1',0:200:8000);
clabel(c,H,0:1000:5000, 'FontSize', 22);
w = H.LineWidth;
H.LineWidth = 2;
clim([1000 8000])
daspect([1 1 1])
xlabel('x (m)')
 ylabel('z (m)')
grid
sym='ko';
hold on
scatter(2.8,-2.5,150,sym,'filled')
scatter(4.2,-4,150,sym,'filled')
scatter(4.2,-2.5,150,sym,'filled')
scatter(4.2,-1,150,sym,'filled')
scatter(5.7,-2.5,150,sym,'filled')
text(8,-1,'C','Fontsize',40)

 clear
subplot(2,2,4)
 imptest12F8_withSurface
 [c,H]=contour(x,-z,P1',0:200:8000);
clabel(c,H,0:1000:5000, 'FontSize', 22);
w = H.LineWidth;
H.LineWidth = 2;
daspect([1 1 1])
q=colorbar;
q.Label.String='Pa';
clim([1000 8000])
xlabel('x (m)')
%ylabel('Depth - m')


grid
sym='ko';
hold on
scatter(2.8,-2.5,150,sym,'filled')
scatter(4.2,-4,150,sym,'filled')
scatter(4.2,-2.5,150,sym,'filled')
scatter(4.2,-1,150,sym,'filled')
scatter(5.7,-2.5,150,sym,'filled')
text(8,-1,'D','Fontsize',40)

 fsize=30;
lineW=1;
lineW_curve=3;
fontN='Calibri';

set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
        'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
    set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);