#!/usr/bin/env python
# coding: utf-8

# In[1]:


from datetime import datetime

class Konto:
    def __init__(self,_nr,_klient):
        self._nr=_nr
        self._klient=_klient
        self._stan=0.0
        self._historia=[]
        self._historia.append({"Kwota": 0.0,
                               "Data": datetime.now().strftime("%d-%m-%Y, %H:%M:%S"),
                               "Stan" : self._stan,
                               "Konto": self._nr})

    def wpłata(self,kwota):
        kwota=float(kwota)
        self._stan=self._stan+kwota
        self._historia.append( {"Kwota": kwota,
                                "Data": datetime.now().strftime("%d-%m-%Y, %H:%M:%S"),
                                "Stan" : self._stan,
                                "Konto": self._nr})
    def wypłata(self,kwota):
        kwota=float(kwota)
        self._stan=self._stan-kwota
        self._historia.append( {"Kwota": kwota,
                                "Data": datetime.now().strftime("%d-%m-%Y, %H:%M:%S"),
                                "Stan" : self._stan,
                                "Konto": self._nr})

    def stan(self,termin):
        for i in range(1,len(self._historia)):
            data=self._historia[i]["Data"]
            data=datetime.strptime(data,"%d-%m-%Y, %H:%M:%S").date()
            if (termin<=data):
                stan=self._historia[i-1]["Stan"]
                return stan
                break

                
    def drukHistorii(self,termin):
        print(f'Konto: {self._nr} Stan: {self.stan(termin)}')
        for przelew in self._historia:
            data=przelew["Data"]
            data=datetime.strptime(data,"%d-%m-%Y, %H:%M:%S").date()
            if (termin<=data):
                kwota=przelew["Kwota"]
                stan=przelew["Stan"]
                print(f" {kwota} {data} {stan}")


# In[78]:


from datetime import datetime
class KontoLimitowane:
    def __init__(self,_nr,_klient):
        self._nr=_nr
        self._klient=_klient
        self._stan=0.0
        self._historia=[]
        self._limit=0.0
        self._historia.append({"Kwota": 0.00,
                               "Data": datetime.now().strftime("%d-%m-%Y, %H:%M:%S"),
                               "Stan" : self._stan,
                               "Konto": self._nr})

    def wpłata(self,kwota):
        kwota=float(kwota)
        self._stan=self._stan+kwota
        self._historia.append( {"Kwota": kwota,
                                "Data": datetime.now().strftime("%d-%m-%Y, %H:%M:%S"),
                                "Stan" : self._stan,
                                "Konto": self._nr})
        
    def wypłata(self,kwota):
        kwota=float(kwota)
        if(self._stan-kwota< -self._limit):
            print(f'Brak środków na koncie {self._nr} na wypłatę {kwota}')
        else:
            self._stan=self._stan-kwota
            self._historia.append( {"Kwota": -kwota,
                                "Data": datetime.now().strftime("%d-%m-%Y, %H:%M:%S"),
                                "Stan" : self._stan,
                                "Konto": self._nr})
    def stan(self,termin):
        for i in range(1,len(self._historia)):
            data=self._historia[i]["Data"]
            data=datetime.strptime(data,"%d-%m-%Y, %H:%M:%S").date()
            if (termin<=data):
                stan=self._historia[i-1]["Stan"]
                return stan
                break
                
    def drukHistorii(self,termin):
        print(f'Konto: {self._nr} Stan: {self.stan(termin)}')
        for przelew in range(len(self._historia)):
            data=self._historia[przelew]["Data"]
            data=datetime.strptime(data,"%d-%m-%Y, %H:%M:%S").date()
            if (termin<=data):
                kwota=self._historia[przelew]["Kwota"]
                stan=self._historia[przelew]["Stan"]
                print(f'{kwota} {data} {stan}')       

