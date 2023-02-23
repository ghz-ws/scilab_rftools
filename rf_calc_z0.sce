clear
clc
clf

R=0.001;
L=0.00000025;
C=0.0000000001;
G=0.00000001;//100Mohm
f=logspace(0,9,200);
w=2*%pi*f;

//RC
for i=1:size(f)(2)
    z0(i,1)=f(i);
    z0(i,2)=sqrt((R*+%i*w(i)*L)/(G+%i*w(i)*C));
    z0(i,3)=abs(sqrt((R+%i*w(i)*L)/(G+%i*w(i)*C)))
    temp(i)=sqrt((R+%i*w(i)*L)/(G+%i*w(i)*C));
    z0(i,4)=real(temp(i));      //alpha
    z0(i,5)=imag(temp(i));
end

plot(log10(z0(:,1)),z0(:,3))
