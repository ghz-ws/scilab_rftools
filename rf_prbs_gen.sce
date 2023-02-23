//PRBS generator
clear
clc

//set n of PRBS
printf('n=2-20 except n=8,12,13,14,16,19\n')
n=input('How long n ?\n');

//n bits shift reg. last=1, others=0
reg=ones(1,n);

//pattern length
pat_length=2^n-1;

//TAP position
tap=[2,3,4,4,6,7,1,6,8,10,1,1,1,15,1,15,12,1,18];

//gen. PRBS
for i=1:pat_length
    out=reg(n);
    for j=0:n-2
        reg(n-j)=reg(n-j-1);
    end
    reg(1)=out<>reg(tap(n-1));
    p(i)=out;
end

//disp.
printf('\nPRBS pattern\nn = %d\nBit length = %d\nPattern\n%s',n,pat_length,strcat(string(p)));
