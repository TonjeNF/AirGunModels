% skript Nyaksel3F8.m 20/10-20, HH
%basert på Ainslies metode for å beregne akselerasjonen
%Versjon for å bruke B8-signalet 18/8-22

d=2.5; %kildedyp i meter
%%  Her velger du romlig oppløsning
dx=0.1;
%dx=0.05;;%  10cm oppløsning 0.1;%
dz=dx;%
x=0:dx:8;%10 m  Her velger du størrelsen på området!!
z=0:dz:5;% 8 m
N=length(x);%Maksimalt antall steg horisontalt 10x8 m
M=length(z);% vertikalt
R2=-1;%Refleksjonskoeffisient;%
c=1500;% m/s, lydhastighet
x2=x.^2;

%pkg load signal
load Bursts8 %Trenger B8 og dB8
M=length(z);% vertikalt
%[C,D]=butter(3,[20 1000]/(1/dt/2));
%Basisberegninger
ct=c*dt;
for m=1:M
r1(:,m)=sqrt(x2+(z(m)-d)^2);
r2(:,m)=sqrt(x2+(z(m)+d)^2);
end
DT=round((r2-r1)./ct); % tidsforskjell på bidragene


B=B8;%(1:50000);;
rho=1000;
nS=length(B);
dB=dB8(1:nS);
%[C,D]=butter(3,[20 1000]/(1/dt/2));%filterparametre
tic
for n=1:N
for m=1:M

ind=DT(n,m)+1;
B2=zeros(1,nS);
dB2=B2(1:nS);
B2(ind:nS-1)=B(1:nS-ind);
dB2(ind:nS-1)=dB(1:nS-ind);
par1=(dB/c+B/r1(n,m))/rho/r1(n,m)^2;
ax1=x(n)*par1;
%ax1(n,m,:)=x(n)*par1;
az1=(d-z(m))*par1;
%az1(n,m,:)=(d-z(m))*par1;
par2=(dB2/c+B2/r2(n,m))/rho/r2(n,m)^2;
ax2=x(n)*par2;
%x2(n,m,:)=x(n)*par2;
az2=-(d+z(m))*par2;
%az2(n,m,:)=-(d+z(m))*par2;
ax(n,m,:)=ax1+R2*ax2;
%ax(n,m,:)=ax1(n,m,:)+R2*ax2(n,m,:);
az(n,m,:)=az1+R2*az2;
%az(n,m,:)=az1(n,m,:)+R2*az2(n,m,:);
a(n,m,:)=sqrt(ax(n,m,:).^2+az(n,m,:).^2);
%axf(n,m,:)=filtfilt(C,D,ax(n,m,:));
%azf(n,m,:)=filtfilt(C,D,az(n,m,:));
%af(n,m,:)=sqrt(axf(n,m,:).^2+azf(n,m,:).^2);%
aa(n,m)=max((a(n,m,:)));
aax(n,m)=max((ax(n,m,:)));
aaz(n,m)=max((az(n,m,:)));
%aaxf(n,m)=max((axf(n,m,:)));
%aazf(n,m)=max((azf(n,m,:)));
%aaf(n,m)=max((af(n,m,:)));
end
end
toc
subplot(2,2,2)
[c,H]=contour(x,-z,aa',0:0.2:10);
clabel(c,H,[0.1 0.2 0.3 0.4 0.5:0.5:2 5 8],'labelspacing', 300, 'FontSize', 22)
grid
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
xlabel('Range - m')
%ylabel('Depth - m')
%title('Simulated total axelleration - m/s^2, Nyaksel2, B1,max(()')
legend('total accel.')
clabel(c,H,[10 5 3 2 1 0.5 0.4 0.3 0.2 0.1],'labelspacing',160, 'FontSize', 22);
daspect([1 1 1])
H.LineWidth = 2;
caxis([0 10])
q=colorbar;
q.Label.String='m/s^2';
subplot(2,2,3)
[c,H]=contour(x,-z,aax',0:0.2:10);
clabel(c,H,[10 5 3 2 1 0.5 0.4 0.3 0.2 0.1],'labelspacing',160, 'FontSize', 22);
grid
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
xlabel('Range - m')
ylabel('Depth - m')
legend('x-component')
%title('Simulated horizontal axelleration - m/s^2, Nyaksel2, B1,max(() ')
q=colorbar;
q.Label.String='m/s^2'
daspect([1 1 1])
w = H.LineWidth;
H.LineWidth = 2;
caxis([0 10])
subplot(2,2,4)
[c,H]=contour(x,-z,aaz',0:0.2:10);
clabel(c,H,[10 5 3 2 1 0.5 0.4 0.3 0.2 0.1],'labelspacing',160, 'FontSize', 22);
grid
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
xlabel('Range - m')
%ylabel('Depth - m')
%title('Simulated vertical axelleration - m/s^2, Nyaksel2, B1,max())')
q=colorbar;
q.Label.String='m/s^2'
legend('z-component')
daspect([1 1 1])
w = H.LineWidth;
H.LineWidth = 2;
caxis([0 10])


set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
        'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
    set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);
 print(figA,'TemporalGradientAccelContour','-djpeg');
% figure(6)
% %[c,H]=contour(x,-z,aaxf',0:0.2:10);
% clabel(c,H,0:0.2:2);
% grid
% set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
% xlabel('Range - m')
% ylabel('Depth - m')
% title('Simulated horizontal axelleration filtered- m/s^2, Nyaksel3F, B1, max())')
% 
% figure(7)
% %[c,H]=contour(x,-z,aazf',0:0.2:10);
% clabel(c,H,0:0.2:2);
% grid
% set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
% xlabel('Range - m')
% ylabel('Depth - m')
% title('Simulated vertical axelleration filtered- m/s^2, Nyaksel3F, B1, max())')
% 
% figure(8)
% %[c,H]=contour(x,-z,aaf',0:0.2:10);
% clabel(c,H,0:0.2:2);
% grid
% set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
% xlabel('Range - m')
% ylabel('Depth - m')
% title('Simulated total axelleration filtered- m/s^2, Nyaksel3F, B1, max())')
toc