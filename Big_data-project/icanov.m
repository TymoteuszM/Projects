function [y, w]=icanov(x);

 

[m,n]=size(x);
if m>n, x=x'; end
[n,k]=size(x);

 

w=eye(n);

 

%c1=150;c2=0.012;c3=0.00051
c1=165;c2=0.01173;c3=0.00051
 

g=ones(n,1);f=ones(n,1);

 

for i=1:k
       
         if(i<c1),
         ei=c2;
         else
         %ei=c2*exp(c3*(i-c1));
         ei=c2*(1-atan(c3*(i-c1)));
         end
   

 

   %ei=0.0062;     
   y(:,i)=w*x(:,i);
   f=y(:,i).^3;
   g=y(:,i);
   w=w+ei*[eye(n)-f*g']*w;
   
end