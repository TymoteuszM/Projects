#!/usr/bin/env python
# coding: utf-8

# In[138]:


import json 
import datetime
import numpy as np 

def odsetki (windxxx,lombard,należne):
    
    #Wszytanie plików wind,lombard
    
    lombard=np.loadtxt(lombard,dtype=str)
    with open(windxxx,'r') as e:
        wind=json.load(e)
    #Stworzenie list data[] z adresami z lombardu oraz rate[] z wartością wysokości oprocentowania
    
    data=[]
    rate=[]
    today=datetime.date.today()

    #Zapełnienie list data[] oraz rate[]
    for i in range(len(lombard)):
        data.append(lombard[i][0])
        rate.append(float(lombard[i][1][:-1])/100)

   #Stworzenie listy na podstawie windxxx
    należne1=wind

    #Stworzenie listy w której zostaną zapisane numery powtarzających się starszych spraw
    numbers=[]
    for i in range(len(należne1)):
        try:
            for j in range(len(należne1)):
                if (należne1[i][0] == należne1[j][0] and należne1[i][2] == należne1[j][2]):
                        continue
                elif (należne1[i][0] == należne1[j][0] and należne1[i][2] < należne1[j][2]):
                        numbers.append(i)
        except (TypeError, ValueError):
            continue
            
    #Usunięcie rekordów z nieprawidłowymi komórkami, stworzenie listy final[] z listą delikwentów
    
    final=[]
    for i in range(len(należne1)):
        try:
            numer_sprawy=int(należne1[i][0])
            nazwa_dłużnika=należne1[i][1]
            data2=datetime.datetime.strptime(należne1[i][2],'%Y-%m-%d').date()
            kwota=float(należne1[i][3])
        except(ValueError,TypeError):
            continue
        if(isinstance(numer_sprawy,int)==True and isinstance(nazwa_dłużnika,str)==True and
          isinstance(data2,datetime.date)== True and isinstance(kwota,float)==True
          and i not in numbers):
            final.append(należne1[i])        

    
    #Stworzenie listy days[] oraz odsetki_sum[] w której zapisane zostaną liczby dni 
    # oraz skumulowaną wartość odsetek
    
    rows,cols=(len(final),len(lombard))
    days=[[0 for i in range(cols)] for j in range(rows)]
    odsetki_sum=[0 for i in range(rows)]
    
    #wyliczenie wartości odsetek, dodanie ich do final[]
        
    for i in range(len(final)):
        date=datetime.datetime.strptime(final[i][2], '%Y-%m-%d').date() #pobranie daty zaciagniecia pozyczki
        date1=today
        x=0
        for j in range(len(lombard)):
            date2=datetime.datetime.strptime(data[j], '%Y-%m-%d').date() #pobranie wartosci zmiennej 
            if(date2>date):
                days=((date1-date2).days)
                x=x+final[i][3]*(rate[j]/(365))*days
                date1=date2
            else:
                days=(date1-date).days
                x=x+final[i][3]*(rate[j]/(365))*days
                odsetki_sum[i]=round(x,2)
                break
        final[i][4]=odsetki_sum[i]        

    #Stworzenie pliku należne.json na podstawie final
    with open('należne.json', 'w') as json_file:
        json.dump(final, json_file)    

