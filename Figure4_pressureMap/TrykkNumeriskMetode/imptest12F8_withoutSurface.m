%imptest11.m 21/11-19 HH
%for å teste ut impulsgenerering
%Her tas signalet i hver posisjon vare på
% 
tic
%load Bursts%%
load Bursts8
%% Her kan du velge mellom opprinnelig tidsoppløsning i signalet eller 4x tidsoppløsning
%% Opprinnelig er B1 og dt, mens ekspandert er B4 og dt4. Default er B1 og dt.
%% For ekspandert velg B4 og sett dt=dt4
B=B8;
dt=dt8;
nS=length(B);
d=2.5; %kildedyp i meter
%%  Her velger du romlig oppløsning
dx=0.05;
%dx=0.05;;%  10cm oppløsning 0.1;%
dz=dx;%
x=0:dx:10;%10 m  Her velger du størrelsen på området!!
z=0:dz:8;% 8 m
%x=[0 2.95 3 3.05 4.45 4.5 4.55 5.95 6.0 6.05];%horisontalt
%z=[0.95 1.0 1.05 2.0 2.45 2.5 2.55 3.95 4.0 4.05];% vertikalt
N=length(x);%Maksimalt antall steg horisontalt 10x8 m
M=length(z);% vertikalt
R2=-1;%Refleksjonskoeffisient;%
c=1500;% m/s, lydhastighet
x2=x.^2;
ct=c*dt;
%pkg load signal

[C,D]=butter(3,[20 1000]/(1/dt/2));
%Basisberegninger
JJ=zeros(N,M,nS); %Allokering av minne
% Denne versjonen antar y=0, dvs. vi ser bare i x-z-planet
for m=1:M
r1(:,m)=sqrt(x2+(z(m)-d)^2);
r2(:,m)=sqrt(x2+(z(m)+d)^2);
end
DT=round((r2-r1)/ct); % tidsforskjell på bidragene

K0=zeros(1,nS);% hjelpevektor
for n=1:N
for m=1:M
K=B/r1(n,m);%Dette er første bidrag%Merk: ingen forsinkelse av første bidrag!
H=K0;
H(DT(n,m)+1:nS)=B(1:nS-DT(n,m)); %Bidrag nr 2 - må fjerne
%K=K+R2*H/r2(n,m); %fjernar denne for å slette bidrag nr 2
JJ(n,m,:)=K(1:nS);%% JJ inneholder hele signalet
%AH=filtfilt(C,D,JJ(n,m,:));
%PF(n,m)=max(AH);
%[na,nb]=max(JJ(n,m,:));
%[nc,nd]=min(JJ(n,m,:));
%dP=na-nc;
%dT=nb-nd;
%DPT(n,m)=dP/dT/dt;
%DeltaT(n,m)=dT*dt;
P1(n,m)=max((JJ(n,m,:)));
%prms(n,m)=rms(JJ(n,m,:));
%SELr(n,m)=10*log10(dt*sum(real(JJ(n,m,:)).^2)/1e-12);
%SEL(n,m)=10*log10(dt*sum((JJ(n,m,:)).^2)/1e-12);
%Lpeak(n,m)=20*log10(max((JJ(n,m,:)))/1e-6);
end
end
figure(1)
[c,H]=contour(x,-z,P1',0:200:8000);
clabel(c,H,0:1000:5000, 'FontSize', 18);
w = H.LineWidth;
H.LineWidth = 2;
clim([1000 8000])
daspect([1 1 1])
xlabel('Range - m')
 ylabel('Depth - m')

%title(['Imptest12, Burst B1, max pressure Pa, delta=500 Pa, R = ' num2str(R2) ', d = ' num2str(d) ' m'])  
 grid
set(gca,'xtick',[2.8 4.2 5.7],'ytick',[-4 -2.5 -1]);

%dlim=1e-2;limh=0.3;
% figure(2)
% %[c,H]=contour(x,-z,PF',0:500:5000);
% clabel(c,H,0:500:5000);
% %clabel(c,H,0:dlim:limh,'LabelSpacing',500);
% xlabel('Range - m')
%  ylabel('Depth - m')
% title(['Imptest12, Burst B1, Filtered max pressure, R = ' num2str(R2) ', d = ' num2str(d) ' m'])  
% % grid
% %set(gca,'xtick',[3 4.5 6],'ytick',[-4 -2.5 -1]);%
%  grid
% set(gca,'xtick',[2.8 4.2 5.7],'ytick',[-4 -2.5 -1]);
% %figure(3)
% %[c1,H]=contour(x,-z,w*vzrms',0:dlim:limh,'LabelSpacing',500);
% %title('Imptest12, B1, dx=10 cm, vertical acceleration component - m/s^2')
% %clabel(c1,H,0:dlim:limh);
% %xlabel('Range -m')
% %ylabel('Depth - m')
% %grid
% %set(gca,'xtick', [3 4.5 6],'ytick', [-4 -2.5 -1])
% % grid


toc

