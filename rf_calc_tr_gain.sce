clear
clc
exec("func_rftools.sci",-1)

temp=csvRead("sp.csv")

//ang to complex
for i=1:size(temp)(1)
    data(i,1)=p2c(temp(i,2),temp(i,3));   //s11
    data(i,2)=p2c(temp(i,4),temp(i,5));   //s21
    data(i,3)=p2c(temp(i,6),temp(i,7));   //s12
    data(i,4)=p2c(temp(i,8),temp(i,9));   //s22
end

//(s11,s12,s21,s22)
for i=1:size(temp)(1)
    gain(i,1)=temp(i,1);        //freq
    s=[data(i,1) data(i,3);data(i,2) data(i,4)];    //make s matrix
    h=s2h(s,50);
    gain(i,2)=20*log10(abs(h(2,1)));    //h21
    gains=s2gain(s);    //gains=[mag K msg gt ug];
    gain(i,3)=10*log10(gains(1));   //mag
    gain(i,4)=gains(2);             //K
    gain(i,5)=10*log10(gains(3));   //msg
    gain(i,6)=10*log10(gains(4));   //gt
    gain(i,7)=10*log10(gains(5));   //ug
end

subplot(1,2,1)
plot(log10(gain(:,1)),gain(:,2))
title("h21")

subplot(1,2,2)
plot(log10(gain(:,1)),gain(:,3))
title("mag")
