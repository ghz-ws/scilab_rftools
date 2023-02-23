clc
clear
clf

Fs=1000;        //sample freq.
L=1000;
baud=100;    //data rate
pn=7//PRBS n. n=2-20 except n=8,12,13,14,16,19

t=0:1/Fs:(L-1)/Fs;  //time vector. 0-1
f=Fs*(0:(L/2))/L; //freq vector. freq res.=Fs/L*n. n=0-N/2
n=length(f); //length of freq
rate=Fs/baud; //oversample rate

//1 pulse
x1=zeros(1,L);
x1(1,1:rate+1)=1; 

//rect
for i=1:L
    if sin(2*%pi*baud*1/2*t(i))>=0  //rect
        x2(1,i)=1;
    else
        x2(1,i)=0;
    end
end

//prbs
prbs_lfsr=ones(1,pn);
prbs_tap=[2,3,4,4,6,7,1,6,8,10,1,1,1,15,1,15,12,1,18];  //tap position
for i=1:L/rate
    out=bitxor(prbs_lfsr(pn),prbs_lfsr(prbs_tap(pn-1)-1));
    prbs_lfsr=cat(2,out,prbs_lfsr(1:pn-1));
    for j=1:rate
        if out==0
            x3(1,rate*(i-1)+j)=0;
        else
            x3(1,rate*(i-1)+j)=1;
        end
    end
end
if size(x3)(1)!=L
    x3(L)=0;
end

//fft
y1=fft(x1);
y2=fft(x2);
y3=fft(x3);

subplot(2,3,1)
plot(t,x1)
xgrid()
title("One pulse","fontsize",5)
xlabel("Time [s]","fontsize",5)
ylabel("Amplitude","fontsize",5)
g1=gca();   //get axis object
g1.data_bounds(:,1)=[0;20/baud];   //y axis scale
g1.data_bounds(:,2)=[0;1.2];   //y axis scale
g1.font_size=3

subplot(2,3,2)
plot(t,x2)
xgrid()
title("Rect.","fontsize",5)
xlabel("Time [s]","fontsize",5)
ylabel("Amplitude","fontsize",5)
g2=gca();   //get axis object
g2.data_bounds(:,1)=[0;20/baud];   //y axis scale
g2.data_bounds(:,2)=[0;1.2];   //y axis scale
g2.font_size=3

subplot(2,3,3)
plot(t,x3)
xgrid()
title("PRBS","fontsize",5)
xlabel("Time [s]","fontsize",5)
ylabel("Amplitude","fontsize",5)
g3=gca();   //get axis object
g3.data_bounds(:,1)=[0;20/baud];   //y axis scale
g3.data_bounds(:,2)=[0;1.2];   //y axis scale
g3.font_size=3

subplot(2,3,4)
plot(f,20*log10(abs(y1(1:n))))
xgrid()
xlabel("Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g4=gca();   //get axis object
g4.data_bounds(:,2)=[0;60];    //y axis scale
g4.font_size=3

subplot(2,3,5)
plot(f,20*log10(abs(y2(1:n))))
xgrid()
xlabel("Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g5=gca();   //get axis object
g5.data_bounds(:,2)=[0;60];    //y axis scale
g5.font_size=3

subplot(2,3,6)
plot(f,20*log10(abs(y3(1:n))))
xgrid()
xlabel("Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g6=gca();   //get axis object
g6.data_bounds(:,2)=[0;60];    //y axis scale
g6.font_size=3
