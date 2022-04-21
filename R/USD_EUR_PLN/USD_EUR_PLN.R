library(ggplot2)

#Zdefiniowanie funkcji getNBPRates. Na samym poczatku pobrano dane w formacie csv. Nastepnie zachowano tylko 3 kolumny (data oraz kursy)
#dodatkowo usunieto pierwszy wiersz. Nastepnie zmiana nazwy kolumn na date, USD oraz EUR. Nastepnie zamieniono przecinki na kropki w 
# obu kolumnach. Usunieto 3 ostatnie wiersze, gdyz nie zawieraja interesujacych nas informacji. Nastepnie zamieniono kolumne date na
#typ date oraz kolumny USD oraz EUR na numeric. Nastepnie poprawnie ponumerowano wiersze.
getNBPRates <- function(year){
  data <- read.csv(file = sprintf("https://www.nbp.pl/kursy/Archiwum/archiwum_tab_a_%s.csv", year), header = T, sep = ';')
  data <- data[-1, c('data', 'X1USD', 'X1EUR')]
  colnames(data) <- c('date', 'USD', 'EUR')
  data$USD <- sub(",", ".", data$USD)
  data$EUR <- sub(",", ".", data$EUR)
  data<-head(data,-3)
  data$date <- as.Date(data$date , format = "%Y%m%d")
  data$USD <- as.numeric(data$USD)
  data$EUR <- as.numeric(data$EUR)
  rownames(data) <- 1:nrow(data)
  return (data)
                            }
#Testowanie czy funkcja dziala
#a<-getNBPRates(2015)
#head(as.data.frame(a))

#Stworzenie ramki danych w ktorej zapisano kursy na przestrzeni lat
df<-data.frame()
#Petla wczytujaca dane kursu z lat 2013 oraz 2020
for (year in seq(2013,2020)) {
  data1 <- getNBPRates(year)
  colnames(data1) <- c('date', 'USD', 'EUR')
  df<-rbind(df,data1)
}

#Narysowanie wykresu
ggplot(df, aes(x=date)) + geom_line(aes(y = EUR), color = "blue")+ 
        geom_line(aes(y = USD), color="red")+
        labs(title="Wykaz kursow srednich NBP dla EUR i USD na przestrzeni lat",x="Data",y="Cena")
        +theme_minimal()



















