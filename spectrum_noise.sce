//noise simulation
clear
clc
clf

Fs = 10000;             //Sampling frequency
T = 1/Fs;               //Sampling period
L = 10000;              //Length of signal
t = 0:1/Fs:1;           //Time vector
f = Fs*(0:(L/2))/L;     //Freq vector

n=2;                    //Noise amplitude
fc=200;                  //freq

z=zeros(1,L);
noise=n*rand(1,length(t));

freq=fc+noise;          //freq noise
X1 =sin(2*%pi*fc*t);     //pure signal
for i=1:L
    X2(1,i)=sin(2*%pi*freq(i)*t(i));   //freq noise
end
X3=sin(2*%pi*fc*t+noise);             //phase noise
for i=1:length(t)
    pfreq(1,i)=(2*%pi*fc*t(i)+noise(i))/(2*%pi*t(i));    //freq deviation
end
for i=1:L
    np(1,i)=2*%pi*freq(i)*t(i)-2*%pi*200*t(i);          //phase deviation
end
X4 =sin(2*%pi*fc*t)+noise;            //voltage noise


subplot(4,2,1)
plot(1000*t(1:500),X1(1:500))
title('Pure Signal')
xlabel('t (ms)')
ylabel('X(t)')

subplot(4,2,3)
plot(1000*t(1:500),X2(1:500))
title('Freq Noise')
xlabel('t (ms)')
ylabel('X(t)')

subplot(4,2,5)
plot(1000*t(1:500),X3(1:500))
title('Phase Noise')
xlabel('t (ms)')
ylabel('X(t)')

subplot(4,2,7)
plot(1000*t(1:500),X4(1:500))
title('Voltage Noise')
xlabel('t (ms)')
ylabel('X(t)')

//show spectrum
subplot(4,2,2)
y=fft(X1);
plot(f(1:500),abs(y(1:500)))

subplot(4,2,4)
y=fft(X2);
plot(f(1:500),abs(y(1:500)))

subplot(4,2,6)
y=fft(X3);
plot(f(1:500),abs(y(1:500)))

subplot(4,2,8)
y=fft(X4);
plot(f(1:500),abs(y(1:500)))
