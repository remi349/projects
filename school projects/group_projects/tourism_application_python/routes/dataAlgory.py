from dataPreparation import temperatureNow
from dataPreparation import ensoleillementNow
from dataPreparation import populartimesNow
from dataPreparation import populartimesAverage
from dataPreparation import populartimesOpenClose
from dataPreparation import todayIs

def get_temperatures_from_api(): #Renvoie un entier
    data = temperatureNow()
    #print(data) #Pour le test
    return(data)

#get_temperatures_from_api()

def get_sun_percent_from_api(): #Renvoie un entier
    data = ensoleillementNow()
    #print(data) #Pour le test
    return(data)

#get_sun_percent_from_api()

def get_number_of_day(): #Renvoie un entier
    data = todayIs()
    #print(data) #Pour le test
    return(data)

#get_number_of_day()

def get_affluence_from_api(place_Id): #Renvoie un entier
    data = populartimesNow(place_Id)
    #print(data) #Pour le test
    return(data)

#CA MARCHE PAS

#get_affluence_from_api("ChIJD3uTd9hx5kcR1IQvGfr8dbk")

def get_avg_affluence_from_api(place_Id, hour): #Renvoie un entier
    data = populartimesAverage(place_Id, hour) #Ne pas demander avant 1h et après 23h svp
    #print(data) # Pour le test
    return(data)

#get_avg_affluence_from_api("ChIJdbbQwbZx5kcRs7Qu5nPw18g", 13)

def get_is_open_response_from_api(place_Id, day): #Renvoie un booléen
    data = populartimesOpenClose(place_Id, day)
    #print(data) #Pour le test
    return(data)

#get_is_open_response_from_api("ChIJdbbQwbZx5kcRs7Qu5nPw18g","Monday")
#get_is_open_response_from_api("ChIJdbbQwbZx5kcRs7Qu5nPw18g","Tuesday")
#get_is_open_response_from_api("ChIJdbbQwbZx5kcRs7Qu5nPw18g","Friday")