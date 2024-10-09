import json
import requests
import importlib.util
from time import localtime
from time import time

### Date

def todayIs():
    date_day = localtime(time())
    number_day = 0
    if (date_day[1] == 1):
        number_day = date_day[2]
    if (date_day[1] == 2):
        number_day = 31 + date_day[2]
    if (date_day[1] == 3):
        number_day = 59 + date_day[2]
    if (date_day[1] == 4):
        number_day = 90 + date_day[2]
    if (date_day[1] == 5):
        number_day = 120 + date_day[2]
    if (date_day[1] == 6):
        number_day = 151 + date_day[2]
    if (date_day[1] == 7):
        number_day = 181 + date_day[2]
    if (date_day[1] == 8):
        number_day = 212 + date_day[2]
    if (date_day[1] == 9):
        number_day = 243 + date_day[2]
    if (date_day[1] == 10):
        number_day = 273 + date_day[2]
    if (date_day[1] == 11):
        number_day = 304 + date_day[2]
    if (date_day[1] == 12):
        number_day = 334 + date_day[2]
    return(number_day)

### Météo

def temperatureNow():
    api_address='http://api.openweathermap.org/data/2.5/weather?appid=0c42f7f6b53b244c78a418f4f181282a&q='
    url = api_address + 'Paris'
    json_data = str(requests.get(url).json())
    position = json_data.rfind("'temp'")
    tempK = json_data[position+8 : position+11]
    tempC = int(tempK) - 273
    return(tempC)

def ensoleillementNow():
    api_address='http://api.openweathermap.org/data/2.5/weather?appid=0c42f7f6b53b244c78a418f4f181282a&q='
    url = api_address + 'Paris'
    json_data = str(requests.get(url).json())
    position = json_data.rfind("'all'")
    pourcent_nuage = json_data[position+7 : position+9]
    if ("}" in pourcent_nuage):
        pourcent_soleil = 100 - int(pourcent_nuage[0 : 1])
    else:
        pourcent_soleil = 100 - int(pourcent_nuage)
    return(pourcent_soleil)

### Affluence

def populartimesNow(Place_Id):
    spec = importlib.util.spec_from_file_location("populartimes", "/home/ubuntu/git/populartimes/populartimes/__init__.py")
    pt = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(pt)

    json_data = str(pt.get_id("AIzaSyBqWv05nNDyQGDH2st9VtY-wbBO5RVCmRA", Place_Id))
    position = json_data.rfind("'current_popularity'")
    popularityNow = int(json_data[position+21 : position+24]) #J'AI CHANGE LA ! (21-24 avant)
    return(popularityNow)

def populartimesAverage(Place_Id, hour):
    spec = importlib.util.spec_from_file_location("populartimes", "/home/ubuntu/git/populartimes/populartimes/__init__.py")
    pt = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(pt)

    mean = 0
    compteur = 0

    json_data = str(pt.get_id("AIzaSyBqWv05nNDyQGDH2st9VtY-wbBO5RVCmRA", Place_Id))
    
    position = json_data.rfind("'Monday'")
    popularityDay = json_data[position+17 : position+100]
    popularityHours = popularityDay.split(',')
    if (int(popularityHours[hour]) != 0):
        compteur += 1
        mean += int(popularityHours[hour])
    
    position = json_data.rfind("'Tuesday'")
    popularityDay = json_data[position+18 : position+100]
    popularityHours = popularityDay.split(',')
    if (int(popularityHours[hour]) != 0):
        compteur += 1
        mean += int(popularityHours[hour])
    
    position = json_data.rfind("'Wednesday'")
    popularityDay = json_data[position+20 : position+100]
    popularityHours = popularityDay.split(',')
    if (int(popularityHours[hour]) != 0):
        compteur += 1
        mean += int(popularityHours[hour])
    
    position = json_data.rfind("'Thursday'")
    popularityDay = json_data[position+19 : position+100]
    popularityHours = popularityDay.split(',')
    if (int(popularityHours[hour]) != 0):
        compteur += 1
        mean += int(popularityHours[hour])

    position = json_data.rfind("'Friday'")
    popularityDay = json_data[position+17 : position+100]
    popularityHours = popularityDay.split(',')
    if (int(popularityHours[hour]) != 0):
        compteur += 1
        mean += int(popularityHours[hour])

    position = json_data.rfind("'Saturday'")
    popularityDay = json_data[position+19 : position+100]
    popularityHours = popularityDay.split(',')
    if (int(popularityHours[hour]) != 0):
        compteur += 1
        mean += int(popularityHours[hour])

    position = json_data.rfind("'Sunday'")
    popularityDay = json_data[position+17 : position+100]
    popularityHours = popularityDay.split(',')
    if (int(popularityHours[hour]) != 0):
        compteur += 1
        mean += int(popularityHours[hour])

    if (compteur != 0):
        mean = mean//compteur

    return(mean)

def populartimesOpenClose(Place_Id, day):
    spec = importlib.util.spec_from_file_location("populartimes", "/home/ubuntu/git/populartimes/populartimes/__init__.py")
    pt = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(pt)

    json_data = str(pt.get_id("AIzaSyBqWv05nNDyQGDH2st9VtY-wbBO5RVCmRA", Place_Id))
    
    position = json_data.rfind(day)
    popularityDay = json_data[position+17 : position+100]
    popularityHours = popularityDay.split(',')
    for i in range(1,23):
        if (int(popularityHours[i]) != 0):
            return True
    return False