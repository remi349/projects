""" Telecom Paris 2021/2022
    Groupe PACT 7.3 : Module Algorithme et IA
    Remi, Valerio et Cilia
    
    
    Class permettant de specifier si l'activite est a l'exterieur
"""

from activity import Activity


class OutdoorActivity(Activity):
    def __init__(self, id, name, price, localisation, dimension, popularity, description, done, weight_of_places, link):
        super().__init__(id, name, price, localisation, popularity,
                         dimension, False, description, done, weight_of_places, link)
