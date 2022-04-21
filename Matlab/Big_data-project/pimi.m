function p=pimi(a);
%wyznaczenie performance index, dla macierzy a, w przypadku separacji to w*a

b=abs(a);
c=b'; %transpozycja czyli zamiana kolumn na rzędy
[nc,mc]=size(c);
xc=max(c); %największa wartośc w danej kolumnie
o=ones(nc,1);
mcd=kron(o,xc); %iloczyn tensorowy kroneckera
pc=c./mcd; %dzielenie każdej kolumny przez jej największą wartość
spc=sum(pc)-1; %suma każdej kolumny z wyjątkiem 1 wynikających z dzielenia przez największą liczbę z kolumny
p1=sum(spc); %suma sum kolumn bez jedynek

c=b; %powtarzamy to samo tylko tym razem c=b
[nc,mc]=size(c);
xc=max(c);
o=ones(nc,1);
mcd=kron(o,xc);
pc=c./mcd;
spc=sum(pc)-1;
p2=sum(spc);

p=p1+p2;
p=p/(nc*(nc-1));