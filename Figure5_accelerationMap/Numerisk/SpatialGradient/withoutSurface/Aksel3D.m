% Aksel3 - kjøres etter imptest9
%25/10-2019 HH

rho=1000;%tettheten
Nev=2*dx*rho;
%Horisontal akselerasjon
%clear ax pax EaTx LEaTx
tic
for m=2:M
for n=1:N-2
%ax(n+1,m,:)=-(JJ(n+2,m,:)-JJ(n,m,:))/Nev;
ax=-(JJ(n+2,m,:)-JJ(n,m,:))/Nev;

%pks=findpeaks(ax(:),"doublesided");
%[pv,pos]=max((pks));
%peakx(n+1,m)=pks(pos);
%peakx(n,m)=max((ax(1000:end)));
peakx(n,m)=max((ax));
%OBS: Ingen verdier finnes for n=1 i sluttresultatet
EaTx(n+1,m)=dt*sum(ax.^2);
LEaTx(n+1,m)=10*log10((EaTx(n+1,m))/1e-12);
end
end

subplot(2,2,3)
[c,H]=contour(x(1:N-2),-z,peakx',0:0.1:8);
grid
 daspect([1 1 1])
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
xlabel('Range - m')
ylabel('Depth - m')
%('Peak x-acceleration m/s^2, burst B1 dx=10cm, delta=0.1 m/s^2')
legend('x-component')
q=colorbar;
q.Label.String='m/s^2'
w = H.LineWidth;
H.LineWidth = 2;
caxis([0 10])

clabel(c,H,[10 5 3 2 1 0.5 0.4 0.3 0.2 0.1],'labelspacing',160, 'FontSize', 22);
%Vertikal akselerasjon

for n=1:N
for m=2:M-2
az=-(JJ(n,m+2,:)-JJ(n,m,:))/Nev;
%pks=findpeaks(az(e,:),"doublesided");
%[pv,pos]=max((pks));
%paz(h,e)=pks(pos);
%peakz(n,m)=max((az(1000:end)));
peakz(n,m)=max((az));
EaTz(n,m)=dt*sum(az(:).^2);
LEaTz(n,m)=10*log10((EaTz(n,m))/1e-12);
end
end
%peakz=[peakz(:,2) peakz(:,2:end)];% Fjerner null-linjen ved m=1

subplot(2,2,4)
[c,H]=contour(x,-z(1:M-2)-dz,peakz',0:0.1:10);
 daspect([1 1 1])
grid
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
xlabel('Range - m')
%ylabel('Depth - m')
%title('Peak z-acceleration m/s^2, burst B1 dx=10cm, delta=0.1 m/s^2')

w = H.LineWidth;
H.LineWidth = 2;
caxis([0 10])
legend('z-component')
q=colorbar;
q.Label.String='m/s^2'

clabel(c,H,[ 10 5 3 2 1 0.5 0.4 0.3 0.2 0.1],'labelspacing',160, 'FontSize', 22);


%tallverdi av total peak aksellerasjon
a=sqrt(peakx(1:N-2,1:M-2).^2+peakz(1:N-2,1:M-2).^2);
%a=sqrt(peakx(:,2:M).^2+peakz(2:N,:).^2);
toc

subplot(2,2,2)
[c,H]=contour(x(2:N-1)-dx,-z(2:M-1)+dz,a',0:0.1:10);
 daspect([1 1 1])
grid
set(gca,'xtick', [2.8 4.2 5.7],'ytick', [-4 -2.5 -1])
xlabel('Range - m')
%ylabel('Depth - m')
%title('Peak magnitude-acceleration m/s^2, burst B1, dx=10cm, delta=0.1 m/s^2')
legend('tot. accel.')
q=colorbar;
q.Label.String='m/s^2'
w = H.LineWidth;
H.LineWidth = 2;
caxis([0 10])
clabel(c,H,[10 5 3 2 1 0.5 0.4 0.3 0.2 0.1],'labelspacing',160, 'FontSize', 22);


% set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
%         'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
%     set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);
%  print(figA,'SpatialDifferenceAccelContour','-djpeg');