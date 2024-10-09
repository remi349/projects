""" Telecom Paris 2021/2022
    Groupe PACT 7.3 : Module Algorithme et IA
    Remi, Valerio et Cilia
    
    
    Class permettant de specifier si l'activite est a l'interieur
"""

from activity import Activity


class IndoorActivity(Activity):
    def __init__(self, id, name, price, localisation, popularity, dimension, description, done, weight_of_places, link):
        super().__init__(name, price, localisation, popularity,
                         dimension, True, description, done, weight_of_places, link)
