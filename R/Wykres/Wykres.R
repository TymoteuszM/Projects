
#Zdefiniowanie wykorzystanych zbiorow danych do wizualizacji
d1<-abs(rnorm(5,mean=1,sd=0.5))
names(d1)<-c("Size","Value","Height","Width","Depth")
# Statystylo Roberta Lewandowskiego w FIFIE22
d2<-c(78,86,92,44,79,82)
names(d2)<-c("PAC","DRI","SHO","DEF","PAS","PHY")
#Statystyki Cristiano Ronaldo w FIFIE22
d3<-c(89,89,93,35,81,77)
names(d3)<-c("PAC","DRI","SHO","DEF","PAS","PHY")
#Przyklady ze strony przedmiotu
d4 <- 1:10
names(d4) <- LETTERS[1:10]

d5 <- abs(rnorm(20, mean = 1, sd = .3))
names(d5) <- LETTERS[1:20]

d6 <- 1:23
names(d6) <- LETTERS[1:23]

#Zdefiniowanie funkcji Radar chart, z bazowymi ustawieniami
radarChart<-function(data, col=rgb(1, 0, 0, .2), lty="dashed", border="red")
{
#zdefiniowanie zmiennej a zawierajacej liczbe elementow danych wejsciowych (liczbe Promieni)
a=length(data)
#Zdefiniowanie katow alfa potrzebnych do narysowania punktow oraz opisow na obszarze najwiekszego okregu
alfa_punkty<-c(0,2*pi*(1:a)/a)  

#Przesortowanie danych od najwiekszego r do najmniejszego (potrzebne do narysowania obszaru rysowania wykresu)
R=sort(data,decreasing=T)

#Zdefiniowanie liczby krokow potrzebnych do narysowania okregu przy pomocy wspolrzednych biegunowych
n=500
#Zdefiniowanie obszaru rysowania wykresu
x=c(-R[1],-R[1],R[1],R[1])
y=c(-R[1],R[1],-R[1],R[1])
par(pty="s") #zachowanie skali wykresow
plot(x,y,type="n",asp=1)

#Narysowanie okregow z przerywanymi liniami dla zadanych wartosci promienia, rysowanie okregow od zewnatrz
for (i in R)
{
  alfa<-c(0,2*pi*(1:n)/n)
  x1<-i*cos(alfa)
  y1<-i*sin(alfa)
  lines(x1,y1,type="l",lty="dashed",col="gray")
}

#Opisanie punktow znajdujacych sie na najwiekszym okregu,narysowanie linii pomocniczych laczacych srodek z 
#tymi punktami
for(i in 1:a )
{
  x_p<-c(0,R[1]*cos(alfa_punkty[i]))
  y_p<-c(0,R[1]*sin(alfa_punkty[i]))
  lines(x_p,y_p,lty="dashed",col="gray")
  x_lab<-R[1]*cos(alfa_punkty[i])
  y_lab<-R[1]*sin(alfa_punkty[i])
  text(x=x_lab,y=y_lab,labels=names(data[i]))
}
#Wyznaczenie wspolrzednych potrzebnych do narysowania wielokata
x_polygon<-data*cos(alfa_punkty)
y_polygon<-data*sin(alfa_punkty)
#Narysowanie wielokata
polygon(x=x_polygon,y=y_polygon,lty=lty,border=border,col=col)
  
}
#Wywolanie funkcji radarChart dla przykladowych zbiorow danych

radarChart(d1)
radarChart(d2)
radarChart(d3)

radarChart(
  data = d4,
  col = rgb(0, 0, 1, .2),
  lty = "solid",
  border = "blue"
)

radarChart(
  data = d5,
  col = rgb(0, 0, 1, .2),
  lty = "solid",
  border = "blue"
)

radarChart(
  data = d6,
  col = rgb(0, 0, 1, .2),
  lty = "solid",
  border = "blue"
)

