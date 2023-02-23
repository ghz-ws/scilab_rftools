clear
clc

function [z]=calc_zl(z1,z2,z3,w)
    z=(z1+z2)*z3/((z1+z2)+z3)
endfunction

function [z]=calc_zc(z1,z2,z3,w)
    z=z1*z2/(z1+z2)+z3
endfunction

R=1;
L=1e-3;
C=1e-9;
f=logspace(1,8,1000);
w=2*%pi*f;
//L
for i=1:size(f)(2)
    data(i,1)=f(i);
    data(i,2)=abs(calc_zl(%i*w(i)*L,R,1/(%i*w(i)*C),w(i)));
end
subplot(1,2,1)
plot(log10(data(:,1)),log10(data(:,2)))
title("L")


R1=1e9;
L1=0.1e-6;
C1=1e-6;
//C
for i=1:size(f)(2)
    data(i,3)=f(i);
    data(i,4)=abs(calc_zc(1/(%i*w(i)*C1),R1,%i*w(i)*L1,w(i)));
end
subplot(1,2,2)
plot(log10(data(:,3)),log10(data(:,4)))
title("C")
