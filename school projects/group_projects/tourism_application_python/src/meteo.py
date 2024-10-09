""" Telecom Paris 2021/2022
    Groupe PACT 7.3 : Module Algorithme et IA
    Remi, Valerio et Cilia
    
    
    Class permettant de calculer l'impact de l'ensoleillement et de la pluie sur l'int�r�t apport� � une visite
"""

from dataAlgory import get_sun_percent_from_api
from math import log2

import sys
sys.path.append('../routes/')
#from dataAlgory import get_rain_percent_from_api
# pas encore implémenté


class Meteo():

    def __init__(self):

        # fonction qui renvoie le pourcentage d'ensoleillement
        self.sun_percent = get_sun_percent_from_api()

    def Weight_meteo(self, b):
        # poids du désir pour un lieu, selon l'ensoleillement

        return b*(log2(1 + self.sun_percent))

    def get_sun_percent(self):
        return self.sun_percent

    def set_sun_percent(self, sun_percent):
        self.sun_percent = sun_percent
