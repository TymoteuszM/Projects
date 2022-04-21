# Zadanie do samodzielnego wykonania.

library(grid)
library('sandwich')
data(Investment, package="sandwich")
Investment <- as.data.frame(Investment)

library(ggplot2movies)
library(ggplot2)
library(tidyverse)
library(scales)
library(dplyr)
library(patchwork)


movies <- as.data.frame(movies)
attach(movies)

#Podzia³ filmów na gatunki

budget_millions <- movies$budget/1000000

budget_millions[is.na(budget_millions)] = 0
movies$budget[is.na(movies$budget)]=0

genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"
movies$genre<-as.factor(genre)



#Podzia³ filmów na dekady powstawania
decade <- rep(NA, nrow(movies))
decade[which(year>=2000& year<2010)]="2010s"
decade[which(year>=1990& year<2000)]="1990s"
decade[which(year>=1980 & year<1990)]="1980s"
decade[which(year>=1970 & year<1980)]="1970s"
decade[which(year>=1960 & year<1970)]="1960s"
decade[which(year>=1950 & year<1960)]="1950s"
decade[which(year>=1940 & year<1950)]="1940s"
decade[which(year>=1930 & year<1940)]="1930s"
decade[which(year>=1920 & year<1930)]="1920s"
decade[which(year>=1910 & year<1920)]="1910s"
decade[which(year>=1900 & year<1910)]="1900s"
decade[which(year>=1890 & year<1900)]="1890s"
movies$decade<-as.factor(decade)
decade<-na.omit(decade)


# Zmodyfikuj wykresy utworzone w pakietach lattice i ggplot2 
# Utworzone w ramach laboratoriów WIZD_6 oraz WIZD_8 w taki sposób aby wykorzystaæ widoki utworzone w pakiecie grid. 

#WIZD6 


trellis.par.set(theme = canonical.theme("postscript", color=TRUE))

#1 
grid.newpage()
vptop <- viewport(x=0, y= .75, height = 0.5, just = 'left', name = "vptop")
pushViewport(vptop)
print(xyplot(Investment ~ seq(1963,1983,1),data = Investment, pch=3 ,
             cex=1, ylab='Wielkoœæ inwestycji', xlab='Rok'),newpage=FALSE)

grid.rect(x = unit(0.68, "npc"), y = unit(0.6, "npc"),
          width = unit(0.18, "npc"), height = unit(0.5, "npc"),
          gp=gpar(col="red",fill = "transparent",lwd=3))


popViewport()



vpbot <- viewport(x=0, y= .25, height = 0.5, just = 'left', name = "vpbot")
pushViewport(vpbot)
print(xyplot(RealInv ~ seq(1963,1983,1),data = Investment, pch=3 , cex=1,
             ylab='Rzeczywista wielkoœæ inwestycji', xlab='Rok'),newpage=FALSE)

grid.rect(x = unit(0.68, "npc"), y = unit(0.6, "npc"),
          width = unit(0.18, "npc"), height = unit(0.5, "npc"),
          gp=gpar(col="red",fill = "transparent",lwd=3))




#2
grid.newpage()



vptop <- viewport(x=0, y= .75, height = 0.5, just = 'left', name = "vptop")
pushViewport(vptop)
print(xyplot(Investment ~ Interest,data = Investment, pch=3 , cex=1, ylab='Wielkoœæ inwestycji'
             , xlab='Wysokoœæ stóp procentowych',
             type=c("p","r")),newpage=FALSE)
print(grid.lines(x = unit(c(0.8, 0.6), "npc"),
                 y = unit(c(0.3, 0.63), "npc"),
                 gp = gpar(fill="black", color = 'black'),
                 arrow = arrow(length = unit(0.2, "inches"), 
                               ends="last", type="closed")))
popViewport()



vpbot <- viewport(x=0, y= 0.25, height = 0.5, just = 'left', name = "vpbot")
pushViewport(vpbot)
print(xyplot(RealInv ~ Interest,data = Investment, pch=3 , cex=1, ylab='Rzeczywista wielkoœæ inwestycji',
             xlab='Wysokoœæ stóp procentowych',
             type=c("p","r")),newpage=FALSE)
print(grid.lines(x = unit(c(0.8, 0.6), "npc"),
                 y = unit(c(0.3, 0.643), "npc"),
                 gp = gpar(fill="black", color = 'black'),
                 arrow = arrow(length = unit(0.2, "inches"), 
                               ends="last", type="closed")))


#3 
grid.newpage()

vptop <- viewport(x=0, y= .75, height = 0.5, just = 'left', name = "vptop")
pushViewport(vptop)
print(xyplot(Investment ~ GNP,data = Investment, pch=3 , cex=1,
             ylab='Wielkoœæ inwestycji', xlab='GNP' ,type=c("p","r")),newpage=FALSE)
print(grid.lines(x = unit(c(0.8, 0.6), "npc"),
                 y = unit(c(0.3, 0.6), "npc"),
                 gp = gpar(fill="black", color = 'black'),
                 arrow = arrow(length = unit(0.2, "inches"), 
                               ends="last", type="closed")))
popViewport()

vpbot <- viewport(x=0, y= .25, height = 0.5, just = 'left', name = "vpbot")
pushViewport(vpbot)
print(xyplot(RealInv ~ RealGNP,data = Investment, pch=3 , cex=1, 
             ylab='Rzeczywista wielkoœæ inwestycji', xlab='Real GNP' ,type=c("p","r")),newpage=FALSE)
print(grid.lines(x = unit(c(0.8, 0.6), "npc"),
                 y = unit(c(0.3, 0.559), "npc"),
                 gp = gpar(fill="black", color = 'black'),
                 arrow = arrow(length = unit(0.2, "inches"), 
                               ends="last", type="closed")))
# 1 wykres movies

grid.newpage()

vptop <- viewport(x=0, y= .75, height = 0.5, just = 'left', name = "vptop")
pushViewport(vptop)
print(ggplot(data = movies, aes(x = rating)) +
        geom_bar()+
        labs(x = "Ocena filmu", y = "Liczba filmów"),newpage=FALSE)

grid.rect(x = unit(0.62, "npc"), y = unit(0.54, "npc"),
          width = unit(0.15, "npc"), height = unit(0.9, "npc"),
          gp=gpar(col="red",fill = "transparent",lwd=3))

popViewport()

vpbot <- viewport(x=0, y= 0.25, height = 0.5, just = 'left', name = "vpbot")
pushViewport(vpbot)
print(ggplot(data = movies, mapping = aes(x = year)) +
        geom_bar()+
        labs(x="Rok",y="Liczba filmów"),newpage=FALSE)
print(grid.lines(x = unit(c(0.6, 0.88), "npc"),
                 y = unit(c(0.7, 0.87), "npc"),
                 gp = gpar(fill="darkblue", color = 'darkblue'),
                 arrow = arrow(length = unit(0.2, "inches"), 
                               ends="last", type="closed")))

grid.rect(x = unit(0.92, "npc"), y = unit(0.54, "npc"),
          width = unit(0.08, "npc"), height = unit(0.88, "npc"),
          gp=gpar(col="red",fill = "transparent",lwd=3))


#2 wykres movies

grid.newpage()

vptop <- viewport(x=0, y= .75, height = 0.5, just = 'left', name = "vptop")
pushViewport(vptop)
print(ggplot(movies %>% filter(length<180, votes>10), aes(x = length, y = rating)) +
        geom_bin2d() +
        labs(x = "D³ugoœæ filmu w minutach",
             y = "Œrednia ocena filmu",fill="Liczba filmów")+
        scale_fill_viridis_c(labels = comma),newpage=FALSE)

grid.rect(x = unit(0.47, "npc"), y = unit(0.58, "npc"),
          width = unit(0.18, "npc"), height = unit(0.32, "npc"),
          gp=gpar(col="red",fill = "transparent",lwd=3))

popViewport()

vpbot <- viewport(x=0, y= 0.25, height = 0.5, just = 'left', name = "vpbot")
pushViewport(vpbot)
print(ggplot(movies %>% filter( length<180,votes >= 10), aes(x = year, y = rating)) +
        geom_bin2d() +
        geom_smooth(color="black") +
        labs(x = "Rok wydania filmu",
             y = "Œrednia ocena filmu",fill="Liczba filmów")+
        scale_x_continuous() +
        scale_y_continuous(breaks = 1:10) +
        scale_fill_viridis_c( labels = comma),newpage=FALSE)


grid.rect(x = unit(0.73, "npc"), y = unit(0.59, "npc"),
          width = unit(0.08, "npc"), height = unit(0.4, "npc"),
          gp=gpar(col="red",fill = "transparent",lwd=3))






#3 wykres Movies
grid.newpage()

vptop <- viewport(x=0, y=0.75, height = 0.5, just = 'left', name = "vptop")
pushViewport(vptop)
print(ggplot(movies, aes(x=decade, y=length,colour=genre,group=genre)) +
        stat_summary(fun.y="mean", geom="smooth")+
        labs(x="Dekada",y="Œrednia d³ugoœæ filmu",colour="Gatunek filmu"),newpage=FALSE)

grid.rect(x = unit(0.62, "npc"), y = unit(0.63, "npc"),
          width = unit(0.32, "npc"), height = unit(0.25, "npc"),
          gp=gpar(col="red",fill = "transparent",lwd=3))

popViewport()
vpbot <- viewport(x=0, y = 0.25 ,height = 0.5, just="left", name = "vpbot")
pushViewport(vpbot)
print(ggplot(movies %>% filter(length>50,length<400), aes(x = length, y = rating)) + geom_point(alpha=0.1) + 
        geom_smooth(method = "lm" )+
        labs( x = "D³ugoœæ filmu", y = "Ocena filmu"),newpage=FALSE)
print(grid.lines(x = unit(c(0.8, 0.6), "npc"),
                 y = unit(c(0.3, 0.76), "npc"),
                 gp = gpar(fill="black", color = 'black'),
                 arrow = arrow(length = unit(0.2, "inches"), 
                               ends="last", type="closed")))


grid.rect(x = unit(0.22, "npc"), y = unit(0.536, "npc"),
          width = unit(0.1, "npc"), height = unit(0.85, "npc"),
          gp=gpar(col="red",fill = "transparent",lwd=3))





# Zmodyfikuj wykresy utworzone w pakietach lattice i ggplot2 
#Utworzone w ramach laboratoriów WIZD_6 oraz WIZD_8 poprzez - dodanie obiektów graficznych w postaci strza³ek i oznaczeñ identyfikuj¹cych kluczowe punkty wykresu oraz obszarów w postaci prostok¹tów obejmuj¹cych te czêœci wykresów na które nale¿y zwróciæ uwagê.
