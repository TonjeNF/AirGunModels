%function fig3
% Skript for å plotte burst som Fig3
load Bursts8.mat
load Data_3.mat

fsize=31;
lineW=1;
lineW_curve=2;
fontN='Calibri';
s = get(0, 'ScreenSize');
 fig = figure('Position', [0 0 s(3) s(3)/3]);;%figure('units','centimeters','position',[0,0,8.5,8.5]);
subplot(1,2,1)
yyaxis left
t=((1:length(B))-1)*dt;
plot(t,B)
axis([0 0.25 -10000 20000])
hold on
ylabel('Sound pressure, Pa')
yyaxis right
t1=((1:length(B8))-1)*dt8;
plot(t1,B8)
legend('measured','reconstructed')
xlabel('time, s')
ylabel('Amplitude Pa or Pa m')
ylabel('Sound pressure, Pa m')
hold off
axis([0 0.25 -10000 20000])

  set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
        'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
    set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);
    %fig = figure('units','centimeters','position',[0,0,8.5,8.5]);
   %set(gcf,'WindowState','fullscreen')
  print(fig,'SourceBurst','-djpeg');




    %ser på frekvens:
  %   fig2 = figure('Position', [0 0 s(4) s(4)]);;%figure('units','centimeters','position',[0,0,8.5,8.5]);
subplot(1,2,2)
Fs=1/dt;
Fs8=1/dt8;
     Y1=fft(B8); %1 sekund signal-sekvens
        L1=length(B8);
        P21=abs(Y1/L1);
        P11=P21(1:L1/2+1); %tek halve spekteret
        P11(2:end-1)=2*P11(2:end-1); %gongar mesteparten av spekteret med 2
        frekv1=Fs8*(0:(L1/2))/L1;
        ESD1=((abs(P11)).^2)*(L1/(2*Fs));

        
     Y=fft(B); %1 sekund signal-sekvens
        L=length(B);
        P2=abs(Y/L);
        P1=P2(1:L/2+1); %tek halve spekteret
        P1(2:end-1)=2*P1(2:end-1); %gongar mesteparten av spekteret med 2
        frekv=Fs*(0:(L/2))/L;
        ESD=((abs(P1)).^2)*(L/(2*Fs));



        yyaxis left

plot(frekv,P1)

hold on
ylabel('Sound pressure, Pa')
yyaxis right

plot(frekv1,P11)
legend('measured','reconstructed')
xlabel('Sample no')

ylabel('Sound pressure, Pa m')
hold off
xlabel('frequency, Hz')
xlim([0 300])
grid on

  set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
        'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
    set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);
    %fig = figure('units','centimeters','position',[0,0,8.5,8.5]);
   % set(gcf,'WindowState','fullscreen')
   print(fig,'SourceBurstFreq2','-djpeg');
%end

xi=45:0.1:75;
y2 = interp1(frekv1(12:17),ESD1(12:17),xi,'cubic')

figure
plot(frekv1,10*log10(ESD1/1e-12))
hold on
plot(xi,10*log10(y2/1e-12))
yline(max(10*log10(y2/1e-12))-3)
xlim([0 80])
% %% padding
% figure(2)
% 
% padd=zeros([1 floor((1-t1(end))/dt)])
% Fs=1/dt;
% B8=[B8 padd]
% 
%      Y1=fft(B8); %1 sekund signal-sekvens
%         L1=length(B8);
%         P21=abs(Y1/L1);
%         P11=P21(1:L1/2+1); %tek halve spekteret
%         P11(2:end-1)=2*P11(2:end-1); %gongar mesteparten av spekteret med 2
%         frekv1=Fs*(0:(L1/2))/L1;
%         ESD1=((abs(P11)).^2)*(L1/(2*Fs));
% 
%         
%      Y=fft(B); %1 sekund signal-sekvens
%         L=length(B);
%         P2=abs(Y/L);
%         P1=P2(1:L/2+1); %tek halve spekteret
%         P1(2:end-1)=2*P1(2:end-1); %gongar mesteparten av spekteret med 2
%         frekv=Fs*(0:(L/2))/L;
%         ESD=((abs(P1)).^2)*(L/(2*Fs));
% 
% 
% 
%         yyaxis left
% 
% plot(frekv,P1)
% 
% hold on
% ylabel('Sound pressure, Pa')
% yyaxis right
% 
% plot(frekv1,P11)
% legend('measured','reconstructed')
% xlabel('Sample no')
% 
% ylabel('Sound pressure, Pa m')
% hold off
% xlabel('Freq. Hz')
% xlim([0 300])
% grid on
% 
%   set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
%         'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
%     set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);
%     %fig = figure('units','centimeters','position',[0,0,8.5,8.5]);
%    % set(gcf,'WindowState','fullscreen')

%finner frekvens
Xi=45:0.1:65;
Y2 = interp1(frekv1(12:17),P11(12:17),Xi,'cubic')
[a b]=max(Y2);
Xi(b)

figure
plot(frekv1(12:17),P11(12:17))
hold

plot(Xi,Y2)