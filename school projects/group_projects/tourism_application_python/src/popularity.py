from math import log2
""" Telecom Paris 2021/2022
    Groupe PACT 7.3 : Module Algorithme et IA
    Remi, Valerio et Cilia
    
    
    Class permettant de specifier la popularité d'une activité
"""


class Popularity:
    def __init__(self, popularity):
        self.set_popularity(popularity)

    AVG_PRICE = 11  # prix moyen d'une activité dans Paris

    def get_popularity(self):
        return self.popularity

    def set_popularity(self, popularity):
        self.popularity = popularity

    def Weight_popularity(self, activity, b):

        desire_weight_popularity = log2(1+(self.popularity)/(self.AVG_PRICE))

        return b*desire_weight_popularity
