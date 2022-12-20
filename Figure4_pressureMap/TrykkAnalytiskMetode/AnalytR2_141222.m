% Analytisk løsning, sinusburst, 7/9-20, HH
% Beregner trykkfordeling (peak amplitude)
tic
%%Inputparametre:
dt =  0.000015259;
f=59.4; %Hz
S=sin(2*pi*f*dt*(1:15000));
B=9405; %amplitude
d=2.5; %kildedyp i meter
dx=0.1;%  5 cm oppløsning
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
p=(f1-f2);

% figure(1)
%plott av trykkfeltet
 X=[1:N]*dx;% For plotting
Z=[1:M]*dz;


toc
