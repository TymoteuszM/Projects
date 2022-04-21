function [s,x,a]=mixgen
i=0:0.0001:0.3-0.0001;
k=max(size(i));
s1=sin((300*i)+30*cos(60*i));
s2=sin(350*i);
s3=sign(sin(700*i));
s4=sin(60*i).*sin(700*i);
s5=randn(1,k);
s6=sign(sin(700*i)).*sin(350*i);
s7=sin((200*i)+20*cos(160*i));
s8=2*rand(1,k)-1;
s=[s2;s5;s7;s8];
[m,n]=size(s);
a =[
    1.7942    0.6628    0.7962   -0.4314
    1.0246    0.4001    1.6649   -1.1915
    0.9813    1.0369   -1.4186   -0.4034
    0.6131   -0.2976   -0.4456   -0.288]

%a=randn(m,m);
%cond(a)
x=a*s;