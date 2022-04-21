#Wgranie bibliotek dozwolonych w poleceniu
library(ggplot2)
library(dplyr)
#Pobranie pliku csv zawierajacego dane o ofertach oraz przekonwertowanie do obiektu typu tibble
df <-as_tibble( read.csv("http://michal.ramsza.org/lectures/2_r_programming/data/data_2.csv", encoding = 'UTF-8'))

#Stworzenie df1 na podstawie df - wybranie marki oraz objetosci silnika, pogrupowanie na podstawie marki, dodanie kolumny
# ze zsumowana liczba ofert
df1 <- df %>% select("Brand", "Engine_capacity") %>%
  group_by(Brand, Engine_capacity) %>%
  summarize(NumOfOffers = n())
#Stworzenie wykresu na podstawie df1
ggplot(df1, aes(x = Engine_capacity, y = Brand)) +
  geom_point(col = "blue", aes(alpha = NumOfOffers, size = NumOfOffers))+
  labs(x = "EngineCapacity")+
  scale_alpha_continuous()+
  theme_light()


# Stworzenie df2 przy uzyciu funkcji table, która zlicza liczbe danych objetosci silnika dla ka¿dej marki, nastepnie wykorzystanie
#funkcji dist oraz cmdscale, po uzyciu ktorych wystepuje redukcja do 2 wymiarow
df2 <- table(df$Brand, df$Engine_capacity) %>%
  dist() %>% cmdscale() 

#Zapisanie df2 jako dataframe
df2 <- data.frame(df2)

#Narysowanie wykresu na podstawie df2 
ggplot(df2, aes(x=X1, y=X2))+
  geom_point( col = 'blue')+
  theme_light()+
  xlab('X')+
  ylab('Y')+
  geom_text(label = rownames(df2), col = 'blue', alpha =0.35, size = 2.5, vjust = -1, hjust =0)
