//modulation simulation
clear
clc
clf

Fs = 10000;             //Sampling frequency
T = 1/Fs;               //Sampling period
L = 10000;              //Length of signal
t = 0:1/Fs:1;           //Time vector
f = Fs*(0:(L/2))/L;     //Freq vector

f1=10;      //signal
f2=300;     //carrier
m=0.1;      //AM mod. depth
dev=10;     //FM dev. freq

wave1=sin(2*%pi*f1*t);
wave2=sin(2*%pi*f2*t);

X1 = sin(2*%pi*f1*t)+sin(2*%pi*f2*t);   //signal added
for i=1:L
    X2(1,i)=wave1(i)*wave2(i);            //signal multiplier
end
for i=1:L
    X3(1,i)=(1+m*wave1(i))*wave2(i);        //AM
end
for i=1:L
    X4(1,i)=sin(2*%pi*f2*t(i)+dev/f1*sin(2*%pi*f1*t(i)));   //FM
end

subplot(4,2,1)
plot(1000*t(1:500),X1(1:500))
title('Signal Added')
xlabel('t (ms)')
ylabel('X(t)')

subplot(4,2,3)
plot(1000*t(1:500),X2(1:500))
title('Signal Multiplied')
xlabel('t (ms)')
ylabel('X(t)')

subplot(4,2,5)
plot(1000*t(1:500),X3(1:500))
title('Signal AM DSB-SC')
xlabel('t (ms)')
ylabel('X(t)')

subplot(4,2,7)
plot(1000*t(1:500),X4(1:500))
title('Signal FM')
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
