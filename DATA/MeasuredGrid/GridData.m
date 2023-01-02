[~,~,Data_raw] = xlsread('punkt.xlsx');
Data=cell2struct(Data_raw(2:end,:),Data_raw(1,:),2);

for j=1:length(Data)

    %for kvart punkt, hent ut tre trykk og ein akselerasjon

   

    Point(j).ID=Data(j).ID;
    Point(j).x=Data(j).HorDist;
    Point(j).z=Data(j).Depth;


    %trykk1
    load(Data(j).Pressure1)
    Fs=str2double(File_Header.SampleFrequency);
    dt=1/Fs;
     [C,A] = butter(3,[20 4000]/(Fs/2),'bandpass');
    signal=-filtfilt(C,A,Channel_6_Data);
   
    CH=Data(j).Pressure1_ch;
    if CH==1
        signal=Channel_1_Data;
        % signal=filtfilt(C,A,Channel_1_Data);
    elseif CH==2
        signal=Channel_2_Data;
        % signal=filtfilt(C,A,Channel_2_Data);
    else
        disp('error')
    end
 tid=((1:length(signal))*dt)-dt;
    figure(j)
    subplot(2,1,1)
    plot(tid,signal,'r')
    hold on
    title(['ID ' num2str(Point(j).ID)])

    [zeroPeak absZeroPeak SEL]=analyzeSignal(Fs,signal);

    %Point(j).zeroPeakPressure(1)=zeroPeak;
    Point(j).absZeroPeak(1)=absZeroPeak;
    Point(j).SEL(1)=SEL;

        %trykk2
    
    load(Data(j).Pressure2)
    Fs=str2double(File_Header.SampleFrequency);
    dt=1/Fs;
   
    CH=Data(j).Pressure2_ch;
    if CH==1
      %  signal=Channel_1_Data;
         signal=filtfilt(C,A,Channel_1_Data);
    elseif CH==2
       % signal=Channel_2_Data;
         signal=filtfilt(C,A,Channel_2_Data);
    else
        disp('error')
    end
  tid=((1:length(signal))*dt)-dt;

    figure(j)
    subplot(2,1,1)
    plot(tid,signal,'m')
    hold on
    [zeroPeak absZeroPeak SEL]=analyzeSignal(Fs,signal);

   % Point(j).zeroPeakPressure(2)=zeroPeak;
    Point(j).absZeroPeak(2)=absZeroPeak;
    Point(j).SEL(2)=SEL;
    clear signal


            %akselerasjon og trykk3
    
    load(Data(j).Acceleration)
    Fs=str2double(File_Header.SampleFrequency);
    dt=1/Fs;
   
 %trykk først:
     %   signal=-Channel_6_Data;
   [C,A] = butter(3,[20 4000]/(Fs/2),'bandpass');
    signal=-filtfilt(C,A,Channel_6_Data);%x-aksen
   
  tid=((1:length(signal))*dt)-dt;

    figure(j)
    subplot(2,1,1)
    plot(tid,signal,'b')
    hold on
    legend('B&K','B&K','VHS-100')
    [zeroPeak absZeroPeak SEL]=analyzeSignal(Fs,signal);
%     xlabel('time (s)')
    ylabel('pressure (Pa)')

    %Point(j).zeroPeakPressure(3)=zeroPeak;
    Point(j).absZeroPeak(3)=absZeroPeak;
    Point(j).SEL(3)=SEL;
    clear signal

    %akselerasjon
    accx=-Channel_3_Data;
    accy=-Channel_4_Data;
    accz=-Channel_5_Data;

%     [C,A] = butter(3,[20 4000]/(Fs/2),'bandpass');
    accxF=-filtfilt(C,A,Channel_3_Data);%x-aksen
accyF=-filtfilt(C,A,Channel_4_Data);%z-aksen
acczF=-filtfilt(C,A,Channel_5_Data);%z-aksen
    
signal=sqrt((accx.^2)+(accy.^2)+(accz.^2));
signalF=sqrt((accxF.^2)+(accyF.^2)+(acczF.^2));
      tid=((1:length(signal))*dt)-dt;

    figure(j)
    subplot(2,1,2)
    plot(tid,signal,'b')
    hold on
    plot(tid,accx,'c--')
     plot(tid,accxF,'r')
    plot(tid,accy,'k--')
    plot(tid,accz,'g--')
    legend('total','x','y','z')
    [zeroPeak absZeroPeak AEL]=analyzeSignal(Fs,signalF);
    xlabel('time (s)')
    ylabel('acceleration (m/s)')
  %  Point(j).zeroPeakAccel=zeroPeak;
    Point(j).absZeroAccel=absZeroPeak;
    Point(j).AEL=AEL;
    clear signal
end
%write to csv
writetable(struct2table(Point), 'MeasuredData.csv')



function [ZeroPeak,absZeroPeak,SEL]=analyzeSignal(Fs,signal)
%0-peakPressure
ZeroPeak=max(signal);
%0-absPeakPressure
absZeroPeak=max(abs(signal));
%SEL
SEL=10*log10(((1/Fs)*sum(signal(1:Fs+1).^2))/1e-12);




end
