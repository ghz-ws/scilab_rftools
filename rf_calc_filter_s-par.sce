clear
clc
//exec("func_rc_lpf_spara.sce",-1)

R=100;
L=11.25e-6;
C=4.502e-9;
Z0=50;
f=logspace(2,8,100);
w=2*%pi*f;

function [s11]=calc_s11(R,C,Z0,w)
    s11=(R+%i*w*C*Z0*(R-Z0))/(R+2*Z0+%i*w*C*Z0*(R+Z0))
endfunction

function [s22]=calc_s22(R,C,Z0,w)
    s22=(R-%i*w*C*Z0*(R+Z0))/(R+2*Z0+%i*w*C*Z0*(R+Z0))
endfunction

function [s12]=calc_s12(R,C,Z0,w)
    s12=(2*Z0)/(R+2*Z0+%i*w*C*Z0*(R+Z0))
endfunction

function [s21]=calc_s21(R,C,Z0,w)
    s21=(2*Z0)/(R+2*Z0+%i*w*C*Z0*(R+Z0))
endfunction

//RC
for i=1:size(f)(2)
src(i,1)=f(i);
src(i,2)=calc_s11(R,C,Z0,w(i));
src(i,3)=calc_s12(R,C,Z0,w(i));
src(i,4)=calc_s21(R,C,Z0,w(i));
src(i,5)=calc_s22(R,C,Z0,w(i));
end

for i=1:size(f)(2)
srcdb(i,1)=f(i);
srcdb(i,2)=20*log10(abs(calc_s11(R,C,Z0,w(i))));
srcdb(i,3)=20*log10(abs(calc_s12(R,C,Z0,w(i))));
srcdb(i,4)=20*log10(abs(calc_s21(R,C,Z0,w(i))));
srcdb(i,5)=20*log10(abs(calc_s22(R,C,Z0,w(i))));
end


//LC
for i=1:size(f)(2)
slc(i,1)=f(i);
slc(i,2)=calc_s11(%i*w(i)*L,C,Z0,w(i));
slc(i,3)=calc_s12(%i*w(i)*L,C,Z0,w(i));
slc(i,4)=calc_s21(%i*w(i)*L,C,Z0,w(i));
slc(i,5)=calc_s22(%i*w(i)*L,C,Z0,w(i));
end

for i=1:size(f)(2)
slcdb(i,1)=f(i);
slcdb(i,2)=20*log10(abs(calc_s11(%i*w(i)*L,C,Z0,w(i))));
slcdb(i,3)=20*log10(abs(calc_s12(%i*w(i)*L,C,Z0,w(i))));
slcdb(i,4)=20*log10(abs(calc_s21(%i*w(i)*L,C,Z0,w(i))));
slcdb(i,5)=20*log10(abs(calc_s22(%i*w(i)*L,C,Z0,w(i))));
end

for i=1:size(f)(2)
slcang(i,1)=f(i);
slcang(i,2)=abs(calc_s11(%i*w(i)*L,C,Z0,w(i)));
slcang(i,3)=phasemag(calc_s11(%i*w(i)*L,C,Z0,w(i)));
slcang(i,4)=abs(calc_s22(%i*w(i)*L,C,Z0,w(i)));
slcang(i,5)=phasemag(calc_s22(%i*w(i)*L,C,Z0,w(i)));
end

subplot(1,2,1)
plot(log10(slcdb(:,1)),slcdb(:,2))
title("LC S11")
subplot(1,2,2)
plot(log10(slcdb(:,1)),slcdb(:,4))
title("LC S21")
