#!/usr/bin/env python
# coding: utf-8

# In[17]:


lista_notowan=[('CCC',122.55,121.7,123.5,122.4),
('ERG',43,41.2,44.8,43.6),
('IMS',2.99,2.99,3.05,3.05),
('INTROL',5.08,4.84,5.08,4.94),
('PEPCO',47.25,46.945,48.2,48),
('ROPCZYCE',31.4,30.7,31.4,31.3),
('TSGAMES',350.6,348,359.6,352.6),
('WIRTUALNA',151,145.8,155.4,147.8)]


# In[18]:


kursy_walut = {
'1 USD':3.9911,
'1 AUD':2.9424,
'1 HKD':0.5127,
'1 CAD':3.1997,
'1 EUR':4.6065,
'100 HUF':1.28,
'1 CHF':4.362,
'1 GBP':5.3604,
'100 JPY':3.5065,
'10000 IDR':2.7856,
'1 CNY':0.6235}



# In[33]:


def maxZmGPW (notowania,kursy,waluta):
    if(notowania==[]):
        return None
    kurs=0
    zmiennosc=0
    for x in notowania:
        zm =(x[4]+x[3])/(x[1]+x[2])
        if zmiennosc<zm:
            zmiennosc=zm
            papier=(x[0],)
            max_zm=(x[1],x[2],x[3],x[4])
        else:
            continue

    for key,value in kursy_walut.items():
        if(key[-3:]==waluta):
            kurs=value/float(key[:-4])
        else:
            continue
            
    if(kurs==0):
        max_zm_2=(0,0,0,0)
    else:
        max_zm_2=tuple(round(x/kurs,2) for x in max_zm)
    final=papier+max_zm_2
    print(final)


# In[36]:





# In[16]:





# In[ ]:





# In[ ]:




