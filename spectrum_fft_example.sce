clc
clear
clf

Fs=1000;        //sample freq.
L=1000;     //Length of signal
Freq=100;
rate=1;

t=0:1/Fs:(L-1)/Fs;    //time vector. 0-1
f=Fs*(0:(L/2))/L; //freq vector. freq res.=Fs/N*n. n=0-N/2
n=length(f) //length of freq

x2=zeros(1,L);
for i=1:L/rate
    x1(1,i*rate:i*rate+rate-1)=sin(2*%pi*Freq*t(i*rate));
    x2(1,i*rate)=sin(2*%pi*Freq*t(i*rate));
end

subplot(1,2,1)
plot(t,x1(1,1:length(t)),"o-")
y1=fft(x1(1,1:length(t)));
xgrid()
title("Time domain","fontsize",5)
xlabel("Time [s]","fontsize",5)
ylabel("Amplitude","fontsize",5)
g1=gca();   //get axis object
g1.data_bounds(:,1)=[0;10/Freq];   //y axis scale
g1.data_bounds(:,2)=[-1.2;1.2];   //y axis scale
g1.font_size=3

subplot(1,2,2)
plot(f,20*log10(abs(y1(1:n))))
xgrid()
title("Spectrum","fontsize",5)
xlabel("Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g2=gca();   //get axis object
g2.data_bounds(:,1)=[0;Fs/2];   //y axis scale
g2.data_bounds(:,2)=[-20;60];   //y axis scale
g2.font_size=3
