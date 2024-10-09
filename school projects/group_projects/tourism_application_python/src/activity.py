""" Telecom Paris 2021/2022
    Groupe PACT 7.3 : Module Algorithme et IA
    Remi, Valerio et Cilia
    
    
    Class contenant les caracteristiques de chaque activite
"""
# activity herite de pleins de classes
# appelle le constructeur de la classe parent

from os import link
from localisation import Localisation
from price import Price
from popularity import Popularity


class Activity:
    def __init__(self, id, name, price, localisation, popularity, dimension, indoor, description, done, weight_of_place, link):
        self.set_id(id)
        self.set_price(price)  # prix de l'activité
        self.set_localisation(localisation)  # localisation de l'activité

        # nombre de hit de l'activité sur google
        self.set_popularity(popularity)

        self.indoor = indoor  # boolean qui indique si l'activité est dedans ou dehors
        self.set_dimension(dimension)  # dimension de l'activité
        self.set_description(description)  # description  de l'activité
        # boolean qui indique si on a déjà visité l'activité, pas encore implémenté
        self.set_done(done)
        self.set_name(name)  # nom de l'avitivité
        # poids que l'on attriue à l'activité, il est initialement artificiellement fixé à zéro
        self.set_weight_of_place(0)
        self.set_link(link)  # photo de l'activité

# getters et setters
    def get_price(self):
        return self.price

    def set_price(self, price):
        self.price = price

    def get_popularity(self):
        return self.popularity

    def set_popularity(self, popularity):
        self.popularity = popularity

    def get_id(self):
        return self.id

    def set_id(self, id):
        self.id = id

    def get_weight_of_place(self):
        return self.weight_of_place

    def set_weight_of_place(self, weight_of_place):
        self.weight_of_place = weight_of_place

    def get_name(self):
        return self.name

    def set_name(self, name):
        self.name = name

    def get_done(self):
        return self.done

    def set_done(self, done):
        self.done = done

    def get_description(self):
        return self.description

    def set_description(self, description):
        self.description = description

    def get_localisation(self):
        return self.localisation

    def set_localisation(self, localisation):
        self.localisation = localisation

    def get_dimension(self):
        return self.dimension

    def set_dimension(self, dimension):
        self.dimension = dimension

    def get_indoor(self):
        return self.indoor

    def get_link(self):
        return self.link

    def set_link(self, link):
        self.link = link
