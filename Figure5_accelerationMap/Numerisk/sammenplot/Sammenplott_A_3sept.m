
clear
%define parameters for plotting
fsize=29; %fontsize
lineW=1;
lineW_curve=2;
fontN='Calibri';
s = get(0, 'ScreenSize');
figA=figure('Position', [0 0 s(3) s(3)/3]);

%Kode for å plotte måledata mot simuleringer, både med gradientmetoden og med ainsleys metode. %Tidserier for punktene 2.8, 4.2 og 5.7 m avstand og dyp 2.5 m (meas2_52).
navn='meas2_52'; %ta eit målepunkt om gongen - målte data trykk og akselerasjon
load (['Erwins/' navn]); % filhenting, sjekk startmappen

load Bursts8.mat %use burst with 8 times increased resolution
B=B8;
dt=8*dt8;
[C,D]=butter(3,[20 1000]/(1/dt/2));%filterparametre
AF=filtfilt(C,D,Channel_3_Data);%x-aksen
BF=filtfilt(C,D,Channel_4_Data);%z-aksen
L1=10000;
n=[29 43 58]; m=26;%indeks for målepunkter% verdien n=29 tilsvarer 2.8 m når vi har dx=0.1
%verdien m= 26 tilsvarer 2.5 m djup når vi har dx=0.1;
[a1,a2]=min(AF);
j=1;
%
%L2=length(ax);
just1=100;%for forskyvvning av plott: må ha med starten



just2=8*just1;
subplot(1,2,1)
%Her beregner vi med gradientmetoden
tic
rho=1000;
R2=-1;
c=1500;
d=2.5; %source depth in meters
dx=0.10;%Spatial resolution horizontally  
dz=dx;%%Spatial resolution vertically 
x=0:dx:5.8;%Here you select the size of the section
z=2.4:dz:2.6;
N=length(x);%Maximum number of steps horizontally
M=length(z);plot((1:L1-a2+1)*dt,-AF(a2-just1:L1-just1))
x2=x.^2;
ct=c*dt;
nS=length(B);
Nev=2*dx*rho;
for m=1:M
r1(:,m)=sqrt(x2+(z(m)-d)^2);%Length of direct sound path
r2(:,m)=sqrt(x2+(z(m)+d)^2);%Length of reflected sound path
end
DT=round((r2-r1)/ct); % time difference of the contributions
% Here we form the impulse-response-array:
JJ=zeros(N,M,nS); %Allocation of memory
K0=zeros(1,nS);% Auxillary array, Start with nothing
for j=1:N
for l=1:M
K=B/r1(j,l);%Note: No delay of first contribution
H=K0;
H(DT(j,l)+1:nS)=B(1:nS-DT(j,l)); %Second contribution
K=K+R2*H/r2(j,l);
JJ(j,l,:)=K(1:nS);%% JJ contains the whole presssure signal
end
end
m=2;
for j=1:3  %bereknar akselerasjon for valgte punkt n(j)
Ax(j,:)=(JJ(n(j)+1,m,:)-JJ(n(j)-1,m,:))/Nev;%Horisontal
Az(j,:)=(JJ(n(j),m+1,:)-JJ(n(j),m-1,:))/Nev;%Vertikal
Atot_spatial(j,:)=sqrt((Ax(j,:).^2)+(Az(j,:).^2));
%Atot_spatial2(j,:)=-Ax(j,:)+Az(j,:);
end
save A_spatial.mat Ax Az Atot_spatial dt8
toc %end timer
L2=length(Ax);
j=1;
plot((1:L1-a2+1)*dt,-AF(a2-just1:L1-just1))
hold on
[b1,b2]=max(-Ax(j,:));;%Denne har negativ peak!
plot((1:L2-b2+1)*dt8,-Ax(j,b2-just2:L2-just2))
axis([0 0.104 -1 3])
%title('Horizontal acceleration, measured and simulated with gradient (difference) method')
xlabel('Time - s')
ylabel('Acceleration - m/s^2')
legend('Measured','Simulated')



subplot(1,2,2)
plot((1:L1-a2+1)*dt,BF(a2-just1:L1-just1))
hold on
L3=length(Az);
just3=2000;
Az=[zeros(3,5000) Az];
[c1,c2]=max(Az(j,:));%Denne har positiv peak!

plot((1:L3-c2+1)*dt8,Az(j,c2-just3:L3-just3))
axis([0 0.104 -1 3])
%title('Vertical acceleration, measured and simulated with gradient (difference) method')
xlabel('Time - s')

ylabel('Acceleration - m/s^2')
legend('Measured','Simulated')

%% Here beregnes med tidsderivasjon%
tic
B=B8(1:50000);;
nS=length(B);
dB=dB8(1:nS);
for n=1:N
for m=1:M
ind=DT(n,m)+1;
B2=zeros(1,nS);
dB2=B2(1:nS);
B2(ind:nS-1)=B(1:nS-ind);
dB2(ind:nS-1)=dB(1:nS-ind);
par1=(dB/c+B/r1(n,m))/rho/r1(n,m)^2;
ax1=x(n)*par1;
az1=(d-z(m))*par1;
par2=(dB2/c+B2/r2(n,m))/rho/r2(n,m)^2;
ax2=x(n)*par2;
az2=-(d+z(m))*par2;
ax(n,m,:)=ax1+R2*ax2;
az(n,m,:)=az1+R2*az2;
a(n,m,:)=sqrt(ax(n,m,:).^2+az(n,m,:).^2);
end
end
toc
%
subplot(1,2,1)
hold on
%plot((1:L1-a2+1)*dt,-AF(a2-just1:L1-just1)) %maalingen
hold on
plot((1:length(ax))*dt8,squeeze(ax(29,1,:)))% simleringen med tidsderivasjon
%title('Horizontal acceleration, measured and simulated with time derivation method')
xlabel('Time - s')
ylabel('Acceleration - m/s^2')
legend('Measured','Spatial difference','Gradient from temporal derivation')
subplot(1,2,2)
hold on
%plot((1:L1-a2+1)*dt,BF(a2-just1:L1-just1))
hold on
aa=az(29,2,:);% må velge riktig posisjon
K=length(aa);
just4=1000;%funnet manuellt
aaa=reshape(aa,1,K);%Litt komplisert her, men det virker hos meg
plot((1:length(az)+just4)*dt8,[zeros(1,just4) aaa])
%title('Vertical acceleration, measured and simulated with time derivation method')
xlabel('Time - s')
ylabel('Acceleration - m/s^2')
legend('Measured','Spatial difference','Gradient from temporal derivation')

  set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
        'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
    set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);

  print(figA,'CompareSignalsVerticalHorizontal','-djpeg');
  Az=aaa;
  save A_temporal.mat ax az a dt8