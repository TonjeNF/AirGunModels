function fig3
% Skript for å plotte burst som Fig3
load Data_3.mat
fsize=31;
lineW=1;
lineW_curve=3;
fontN='Calibri';
s = get(0, 'ScreenSize');
 fig = figure('Position', [0 0 s(4) s(4)]);;%figure('units','centimeters','position',[0,0,8.5,8.5]);

yyaxis left
plot(B)
axis([0 5000 -10000 20000])
hold on
ylabel('Sound pressure, Pa')
yyaxis right
plot(B1)
legend('measured','reconstructed')
xlabel('Sample no')
ylabel('Amplitude Pa or Pa m')
ylabel('Sound pressure, Pa m')
hold off
axis([0 5000 -10000 20000])

  set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
        'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
    set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);
    %fig = figure('units','centimeters','position',[0,0,8.5,8.5]);
   % set(gcf,'WindowState','fullscreen')
   print(fig,'SourceBurst','-djpeg');
    end
