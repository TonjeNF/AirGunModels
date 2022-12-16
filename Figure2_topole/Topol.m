
fsize=31;
lineW=1;
lineW_curve=3;
fontN='Calibri';
s = get(0, 'ScreenSize');
fig = figure('Position', [0 0 s(4) s(4)]);;%figure('units','centimeters','position',[0,0,8.5,8.5]);

% Topol2, for bruk med kilde og speilkilde
teta=[1:360]*pi/180;% tar med hele vinkelområdet, selv om ikke alt trengs

for i=1:2;
    if i==1
        N=1; % kan istedet gis utenfra
        
    elseif i==2;
        f=61;
        lambda=1500/f;
        d=2.5;
        N=d/lambda;
        
    end
    
    F=abs(sin(2*pi*N*cos(teta)));% vi bruker abs fordi fasen ikke er cinteressant
    % figure(1) %for polarplott
    % polar(teta(1:90)-pi/2,abs(F(1:90)),'k')
    % hold on % Må plottes i to trinn, velger blå farge for ikke å skille bidragene
    % polar(teta(270:360)+3*pi/2,abs(F(270:360)),'k')
    % hold off
    % figure % for rektangulært plott
    px=F.*cos(teta+pi/2);
    py=F.*sin(teta+pi/2);
    K=90:270;
    plot(px(K),py(K))
    
    hold on
    %plot([-1 1],[0 0],'k')
    %title(['Two-pole directivity plot, N=' num2str(N)])
    xlabel('Horizontal range')
    ylabel('Depth')
   
    axis([-1 1 -1 0])
end
legend(['N=1'],['N=' num2str(round(N,2))])


  navn='Fig2';
      daspect([1 1 1])

        set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',fsize, ...
        'FontWeight','Normal', 'LineWidth', lineW,'layer','top');
    set(findobj(gcf, 'Type', 'Line'),'LineWidth',lineW_curve);
    %fig = figure('units','centimeters','position',[0,0,8.5,8.5]);
   % set(gcf,'WindowState','fullscreen')
   print(fig,[navn],'-djpeg');