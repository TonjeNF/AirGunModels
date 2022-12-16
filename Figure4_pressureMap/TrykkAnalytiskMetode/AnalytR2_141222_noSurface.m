% Analytisk løsning, sinusburst, 7/9-20, HH
% Beregner trykkfordeling (peak amplitude)


tic
%%Inputparametre:
dt =  0.000015259;
f=59; %Hz
S=sin(2*pi*f*dt*(1:15000));
B=9405; %amplitude
d=2.5; %kildedyp i meter
dx=0.05;;%  5 cm oppløsning
dz=dx;%;
x=0:dx:10;
z=0:dz:8;
N=length(x);%Maksimalt antall steg horisontalt 
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
p=f1;%=(f1-f2); %endrar frå topol til punktkjelde (tek vekk overflata)

% figure(1)
%plott av trykkfeltet
 X=[1:N]*dx;% For plotting
Z=[1:M]*dz;

[c,H]=contour(X,-Z,abs(B*p'),0:200:8000);
%title(['Pressure Pa,  AnalytR, frq = ' num2str(f) ' Hz, delta =  500  Pa, R = ' num2str(R2) ', d = ' num2str(d) ' m'])
clabel(c,H,0:1000:5000, 'FontSize', 18);
w = H.LineWidth;
H.LineWidth = 2;
daspect([1 1 1])
clim([1000 8000])
%xlabel('Range -m')
ylabel('Depth - m')
grid
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
toc
