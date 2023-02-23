//RF tools

//from z
function s=z2s(z,z0)
    zd=1/((z(1,1)+z0)*(z(2,2)+z0)-z(1,2)*z(2,1));
    s=zd*[(z(1,1)-z0)*(z(2,2)+z0)-z(1,2)*z(2,1) 2*z0*z(1,2);2*z0*z(2,1) (z(1,1)+z0)*(z(2,2)-z0)-z(1,2)*z(2,1)];
endfunction

function h=z2h(z)
    h=1/z(2,2)*[z(1,1)*z(2,2)-z(1,2)*z(2,1) z(1,2);-z(2,1) 1];
endfunction

function k=z2k(z)
    k=1/z(2,1)*[z(1,1) z(1,1)*z(2,2)-z(1,2)*z(2,1); 1 z(2,2)];
endfunction

//from y
function s=y2s(y,z0)
    sd=1/((z0*y(1,1)+1)*(z0*y(2,2)+1)-z0^2*y(1,2)*y(2,1));
    s=sd*[(1-z0*y(1,1))*(1+z0*y(2,2))+z0^2*y(1,2)*y(2,1) -2*z0*y(1,2);-2*z0*y(2,1) (1+z0*y(1,1))*(1-z0*y(2,2))+z0^2*y(1,2)*y(2,1)];
endfunction

function h=y2h(y)
    h=1/y(1,1)*[1 -y(1,2);y(2,1) y(1,1)*y(2,2)-y(1,2)*y(2,1)];
endfunction

function k=y2k(y)
    k=1/y(2,1)*[-y(2,2) -1;-y(1,1)*y(2,2)+y(1,2)*y(2,1) -y(1,1)];
endfunction

//from h
function s=h2s(h,z0)
    sd=1/((h(1,1)+z0)*(h(2,2)+1/z0)-h(1,2)*h(2,1));
    s=sd*[(h(1,1)-z0)*(h(2,2)+1/z0)-h(1,2)*h(2,1) 2*h(1,2);-2*h(2,1) (h(1,1)+z0)*(1/z0-h(2,2))+h(1,2)*h(2,1)];
endfunction

function z=h2z(h)
    z=1/h(2,2)*[h(1,1)*h(2,2)-h(1,2)*h(2,1) h(1,2);-h(2,1) 1];
endfunction

function y=h2y(h)
    y=1/h(1,1)*[1 -h(1,2);h(2,1) h(1,1)*h(2,2)-h(1,2)*h(2,1)];
endfunction

function k=h2k(h)
    k=1/h(2,1)*[-h(1,1)*h(2,2)+h(1,2)*h(2,1) -h(1,1);-h(2,2) -1];
endfunction

//from k
function s=k2s(k,z0)
    a=k(1,1);
    b=k(1,2);
    c=k(2,1);
    d=k(2,2);
    sd=1/(a+b/z0+c*z0+d);
    s=sd*[a+b/z0-c*z0-d 2*(a*d-b*c);2 -a+b/z0-c*z0+d];
endfunction

function z=k2z(k)
    a=k(1,1);
    b=k(1,2);
    c=k(2,1);
    d=k(2,2);
    z=1/c*[a a*d-b*c;1 d];
endfunction

function y=k2y(k)
    a=k(1,1);
    b=k(1,2);
    c=k(2,1);
    d=k(2,2);
    y=1/b*[d b*c-a*d;-1 a];
endfunction

function h=k2h(k)
    a=k(1,1);
    b=k(1,2);
    c=k(2,1);
    d=k(2,2);
    h=1/d*[b a*d-b*c;-1 c];
endfunction

//from s
function z=s2z(s,z0)
    zd=z0/((1-s(1,1))*(1-s(2,2))-s(1,2)*s(2,1));
    z=zd*[(1+s(1,1))*(1-s(2,2))+s(1,2)*s(2,1) 2*s(1,2);2*s(2,1) (1-s(1,1))*(1+s(2,2))+s(1,2)*s(2,1)];
endfunction

function y=s2y(s,z0)
    yd=1/z0*1/((1+s(1,1))*(1+s(2,2))-s(1,2)*s(2,1));
    y=yd*[(1-s(1,1))*(1+s(2,2))+s(1,2)*s(2,1) -2*s(1,2);-2*s(2,1) (1+s(1,1))*(1-s(2,2))+s(1,2)*s(2,1)];
endfunction

function h=s2h(s,z0)
    hd=1/((1-s(1,1))*(1+s(2,2))+s(1,2)*s(2,1));
    h=hd*[z0*((1+s(1,1))*(1+s(2,2))-s(1,2)*s(2,1)) 2*s(1,2);-2*s(2,1) 1/z0*((1-s(1,1))*(1-s(2,2))-s(1,2)*s(2,1))];
endfunction

function k=s2k(s,z0)
    k=1/(2*s(2,1))*[(1+s(1,1))*(1-s(2,2))+s(1,2)*s(2,1) ((1+s(1,1))*(1+s(2,2))-s(1,2)*s(2,1))*z0;
        ((1-s(1,1))*(1-s(2,2))-s(1,2)*s(2,1))/z0 (1-s(1,1))*(1+s(2,2))+s(1,2)*s(2,1)];
endfunction

//gain calc
function gains=s2gain(s)
    K=(1-abs(s(1,1))^2-abs(s(2,2))^2+abs(s(1,1)*s(2,2)-s(1,2)*s(2,1))^2)/(2*abs(s(1,2))*abs(s(2,1)));
    mag=abs(s(2,1)/s(1,2))*(K-sqrt(K^2-1));
    msg=abs(s(2,1)/s(1,2));
    gt=abs(s(2,1))^2;
    ug=abs(s(2,1)/s(1,2)-1)^2/(2*K*abs(s(2,1)/s(1,2))-2*real(s(2,1)/s(1,2)));
    gains=[mag K msg gt ug];
endfunction

//polar to complex
function comp=p2c(mag,ang)
    comp=mag*cos(ang*%pi/180)+%i*mag*sin(ang*%pi/180);
endfunction

//draw smith
function draw_smith
    //Draw outer circle
    t = linspace(0, 2*%pi, 100);
    x = cos(t);
    y = sin(t);
    plot2d(x, y,style=1);
    
    //Draw circles along horizontal axis
    k = [.25 .5 .75];
    for i = 1 : length(k)
        x(i,:) = k(i) + (1 - k(i)) * cos(t);
        y(i,:) = (1 - k(i)) * sin(t);
        plot2d(x(i,:), y(i,:),style=1);
    end 
    
    //Draw partial circles along vertical axis
    kt = [2.5 %pi 3.79 4.22];
    k = [.5 1 2 4];
    for i = 1 : length(kt)
        t = linspace(kt(i), 1.5*%pi, 50);
        a(i,:) = 1 + k(i) * cos(t);
        b(i,:) = k(i) + k(i) * sin(t);
        plot2d(a(i,:), b(i,:),style=1);
        plot2d(a(i,:), -b(i,:),style=1);
    end
    
    //Draw horizontal line
    t=[-1,1];
    s=[0,0];
    plot2d(t,s,style=1);
    a=gca();
    a.data_bounds(:,1)=[-1;1];
    a.data_bounds(:,2)=[-1;1];
    a.isoview = 'on';
    b=get("current_axes");
    b.axes_visible="off";
endfunction
