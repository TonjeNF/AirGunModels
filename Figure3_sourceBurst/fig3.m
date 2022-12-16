function fig3
% Skript for å plotte burst som Fig3
fsize=31;
lineW=1;
lineW_curve=3;
fontN='Calibri';
s = get(0, 'ScreenSize');
 fig = figure('Position', [0 0 s(4) s(4)]);;%figure('units','centimeters','position',[0,0,8.5,8.5]);
load Data_3.mat
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

end