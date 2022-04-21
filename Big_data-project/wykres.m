function wykres(x);



[m,n]=size(x);
if m>n, x=x'; end

[m,n]=size(x); 

clf

 

for i=1:m,
    subplot(m,1,i), plot(x(i,:));
end

 

figure(gcf)