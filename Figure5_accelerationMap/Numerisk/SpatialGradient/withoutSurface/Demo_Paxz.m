%Det essensielle, for demonstrasjon: Demo_P
% Trykket::
load Bursts8
B=B8;
dt=dt8;
nS=length(B);
d=2.5; %kildedyp i meter
%%  Her velger du romlig oppløsning
dx=0.1;%  10cm oppløsning 0.1;%
dz=dx;%
x=0-dx:dx:8+dx;%Legger 10 cm utenfor området som er 0:8 x 0:5 cm
z=0-dz:dz:5+dz;%
N=length(x);%
M=length(z);
c=1500;% m/s, lydhastighet
x2=x.^2;
ct=c*dt;
JJ=zeros(N,M,nS); %Allokering av minne
for m=1:M
r1(:,m)=sqrt(x2+(z(m)-d)^2);
end
for n=1:N
for m=1:M
K=B/r1(n,m);
JJ(n,m,:)=K(1:nS);%
P1(n,m)=max((JJ(n,m,:)));
end
end
figure(1)
nn=2:N-1;
mm=2:M-1;
X=x(2:N-1);
Z=z(2:M-1);
[c,H]=contour(X,-Z,P1(nn,mm)',0:500:7000);
clabel(c,H,0:500:5000, 'FontSize', 16);
xlabel('Range - m')
 ylabel('Depth - m')
title(['Imptest12, Single-Burst B8, max pressure Pa, delta=500 Pa, d = ' num2str(d) ' m'])
grid
set(gca,'xtick',[2.8 4.2 5.7],'ytick',[-4 -2.5 -1]);
%Så langt ser det bra ut
%X-akselerasjon
rho=1000;%tettheten
Nev=2*dx*rho;
for m=1:M-2
for n=2:N-2
ax=-(JJ(n+1,m,:)-JJ(n-1,m,:))/Nev;
peakx(n,m)=max((ax));
end
end
figure(2)
Z=z(2:M-1);
[c,H]=contour(x(1:N-2),-Z,peakx',0:0.1:8);
grid
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
xlabel('Range - m')
ylabel('Depth - m')
%Legg merke til litt manglende symmetri ved å sammenligne kurvene oppe og nede
%Vertikal akselerasjon
for n=2:N-1
for m=2:M-2
az=-(JJ(n,m+2,:)-JJ(n,m,:))/Nev;
peakz(n,m)=max((az));
end
end
[c,H]=contour(x(2:end),-Z,peakz',0:0.1:10);
grid
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
xlabel('Range - m')
ylabel('Depth - m')
title('Peak z-acceleration m/s^2, burst B1 dx=10cm, delta=0.1 m/s^2')