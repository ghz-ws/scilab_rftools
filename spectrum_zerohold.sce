clc
clear
clf

Fs=1000;        //sample freq.
L=1000;     //Length of signal
freq_max=250;
freq_step=5;
show_freq=50;

rate=2; //oversample rate
t=0:1/Fs:L/Fs;    //time vector
f=Fs*(0:(L/2))/L; //freq vector. freq res.=Fs/L*n. n=0-N/2
n=length(f); //length of freq

for j=1:freq_max/freq_step
    Freq=j*freq_step;
    for i=1:L/rate
        x1(1,i*rate:i*rate+rate-1)=sin(2*%pi*Freq*t(i*rate));
    end
    for i=1:L/rate
        x2(1,i*rate)=sin(2*%pi*Freq*t(i*rate));
        x2(1,i*rate+1:i*rate+rate-1)=0;
    end
    
    //fft
    y1=fft(x1(1,1:length(t)));
    y2=fft(x2(1,1:length(t)));
    
    if Freq==show_freq
        show1=x1(1,1:length(t));
        show2=x2(1,1:length(t));
        sr1=y1;
        sr2=y2;
    end
    
    //extract 1st max val. and 2nd max val
    fv1(j)=Freq;        //freq vector
    [nyq1(j) index]=max(abs(y1)(1:n)); //1st nyquist
    y1(index)=0;  //mask max val
    fv2(j)=Fs/2-Freq;
    [nyq2(j) index]=max(abs(y1)(1:n)); //1st nyquist
    
    fv3(j)=Freq;        //freq vector
    [nyq3(j) index]=max(abs(y2)(1:n)); //1st nyquist
    y2(index)=0;  //mask max val
    fv4(j)=Fs/2-Freq;
    [nyq4(j) index]=max(abs(y2)(1:n)); //1st nyquist
end


subplot(3,2,1)
plot(t,show1,"o-")
xgrid()
title("Zero order hold","fontsize",5)
xlabel("Time [s]","fontsize",5)
ylabel("Amplitude","fontsize",5)
g1=gca();   //get axis object
g1.data_bounds(:,1)=[0;10/Freq];   //y axis scale
g1.data_bounds(:,2)=[-1.2;1.2];   //y axis scale
g1.font_size=3

subplot(3,2,2)
plot(t,show2,"o-")
xgrid()
title("Zero padding","fontsize",5)
xlabel("Time [s]","fontsize",5)
ylabel("Amplitude","fontsize",5)
g2=gca();   //get axis object
g2.data_bounds(:,1)=[0;10/Freq];   //y axis scale
g2.data_bounds(:,2)=[-1.2;1.2];   //y axis scale
g2.font_size=3

subplot(3,2,3)
plot(f,20*log10(abs(sr1(1:n))),"o-")
xgrid()
xlabel("Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g3=gca();   //get axis object
g3.data_bounds(:,2)=[-20;60];   //y axis scale
g3.font_size=3

subplot(3,2,4)
plot(f,20*log10(abs(sr2(1:n))),"o-")
xgrid()
xlabel("Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g4=gca();   //get axis object
g4.data_bounds(:,2)=[-20;60];   //y axis scale
g4.font_size=3

subplot(3,2,5)
plot(fv1,20*log10(nyq1),"o-",fv2,20*log10(nyq2),"o-")
legend("1st Nyquist Zone", "2nd Nyquist Zone", 1)
xgrid()
//title("Zero order hold","fontsize",5)
xlabel("Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g5=gca();   //get axis object
g5.data_bounds(:,2)=[20;60];    //y axis scale
g5.font_size=3
e5=gce();
e5.font_size=3

subplot(3,2,6)
plot(fv3,20*log10(nyq3),"o-",fv4,20*log10(nyq4),"o-")
legend("1st Nyquist Zone", "2nd Nyquist Zone", 1)
xgrid()
//title("Zero padding","fontsize",5)
xlabel("Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g6=gca();   //get axis object
g6.data_bounds(:,2)=[20;60];    //y axis scale
g6.font_size=3
e6=gce();
e6.font_size=3
