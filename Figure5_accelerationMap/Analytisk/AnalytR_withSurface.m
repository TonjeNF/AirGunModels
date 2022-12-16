% AnalytR.m modifisert fra topol12B,7/9-20
% Analytisk løsning med sinusburst 6/9-20

%Topol12.m HH 14/10 B

%clear
tic
%%Inputparametre:
dt =  0.000015259;
f=59.4; %Hz
S=sin(2*pi*f*dt*(1:15000));
B=9405; %amplitude
d=2.5; %kildedyp i meter
dx=0.05;;%  10cm oppløsning
dz=dx;%;
x=0:dx:10;
z=0:dz:8;
N=length(x);%Maksimalt antall steg horisontalt 20*15 m
M=length(z);% vertikalt
R2=-1;%Refleksjonskoeffisient
c=1500;% m/s
x2=x.^2;
c=1500;%vann
rho=1000;%vannets tethet
k=2*pi*f/c;

%Basisberegninger
for m=1:M
r1(:,m)=sqrt(x2+(z(m)-d)^2);
r2(:,m)=sqrt(x2+(z(m)+d)^2);

% Eksakt topol -> p:, setter trykkamplituden i signalet til 1
f1(:,m)=exp(i*k*r1(:,m))./r1(:,m);
f2(:,m)=exp(i*k*r2(:,m))./r2(:,m);
end
p=(f1-f2);

% figure(1)
% %plott av trykkfeltet
 X=[1:N]*dx;% For plotting
Z=[1:M]*dz;
% 
% [c,H]=contour(X,-Z,abs(B*p'),0:200:5000);
% title(['Pressure Pa,  AnalytR, frq = ' num2str(f) ' Hz, delta =  200  Pa, R = ' num2str(R2) ', d = ' num2str(d) ' m'])
% clabel(c,H);
% xlabel('Range -m')
% ylabel('Depth - m')
% grid
% set(gca,'xtick', [3 4.5 6],'ytick', [-4 -2.5 -1])

%Aksellerasjonen: gradienten av trykkfeltet
%  analytisk
for m=1:M

E1(:,m)=(i*k*r1(:,m)-1)./r1(:,m).^2.*f1(:,m);
E2(:,m)=(i*k*r2(:,m)-1)./r2(:,m).^2.*f2(:,m);
Ax1(:,m)=E1(:,m).*x'; % x-aks for p1
Ax2(:,m)=E2(:,m).*x'; % x-aks for p2
Az1(:,m)=E1(:,m).*(z(m)-d)';
Az2(:,m)=E2(:,m).*(z(m)+d)';

Ax(:,m)=B*real(Ax1(:,m)-Ax2(:,m))/rho;
Az(:,m)=B*real(Az1(:,m)-Az2(:,m))/rho;
Aks(:,m)=sqrt(real(Ax(:,m)).^2+real(Az(:,m)).^2);
%Aks(:,m)=sqrt(abs(Ax(:,m)).^2+abs(Az(:,m)).^2);
end

%figure(2)

[c,H]=contour(X,-Z,(Aks'),0:0.1:10);
%title(['Particle acceleration total- m/s^2, analytic, delta = 0.1 m/s2'])
clabel(c,H)
xlabel('Range - m')
ylabel('Range - m')
grid
set(gca,'xtick', [3 4.5 6],'ytick', [-4 -2.5 -1])

%digitalt:
%[az,ax]=gradient(abs(p),dx,dz);
[az,ax]=gradient(real(p),dx,dz);
% for n=1:N
% a(n,:)=sqrt(ax(n,:).^2+az(n,:).^2);
% end
% figure(3)
% [c,H]=contour(X,-Z,(B*a'/rho),0:0.1:3);
% title(['Particle acceleration total- m/s^2, numeric, delta=0.1 m/s2,'])
% clabel(c,H)
% xlabel('Range - m')
% ylabel('Range - m')
% grid
% set(gca,'xtick', [3 4.5 6],'ytick', [-4 -2.5 -1])
% 
% figure(4)
% j=2:201;l=2:161;
% [c,H]=contour(X(j),-Z(l),real(Ax(j,l)'),-3:0.1:3);
% title(['Particle acceleration x- m/s^2, analytic,'])
% clabel(c,H)
% xlabel('Range - m')
% ylabel('Range - m')
% grid
% set(gca,'xtick', [3 4.5 6],'ytick', [-4 -2.5 -1])
% 
% figure(5)
% j=2:201;l=2:161;
% [c,H]=contour(X(j),-Z(l),real(B*ax(j,l)'/rho),-3:0.1:3);
% title(['Particle acceleration x- m/s^2, numeric,'])
% clabel(c,H)
% xlabel('Range - m')
% ylabel('Range - m')
% grid
% set(gca,'xtick', [3 4.5 6],'ytick', [-4 -2.5 -1])
% 
% figure(6)
% [c,H]=contour(X(j),-Z(l),real(Az(j,l)'),-3:0.1:3);
% title(['Particle acceleration z- m/s^2, analytic,'])
% clabel(c,H)
% xlabel('Range - m')
% ylabel('Range - m')
% grid
% set(gca,'xtick', [3 4.5 6],'ytick', [-4 -2.5 -1])
% 
% figure(7)
% 
% [c,H]=contour(X(j),-Z(l),real(B*az(j,l)'/rho),-3:0.1:3);
% title(['Particle acceleration z- m/s^2, numeric,'])
% clabel(c,H)
% xlabel('Range - m')
% ylabel('Range - m')
% grid
% set(gca,'xtick', [3 4.5 6],'ytick', [-4 -2.5 -1])
% toc
