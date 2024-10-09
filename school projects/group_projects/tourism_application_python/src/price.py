from math import log2
""" Telecom Paris 2021/2022
    Groupe PACT 7.3 : Module Algorithme et IA
    Remi, Valerio et Cilia
    
    
    Class permettant de specifier le prix d'une activité
"""


class Price:
    def __init__(self, price):
        self.set_price(price)

    AVG_PRICE = 11
    

    def get_price(self):
        return self.price

    def set_price(self, price):
        self.price = price

    def Weight_price(self, activity, b):

        # Desire of the price
        desire_weight_price = log2(1+(self.price)/(self.AVG_PRICE))

        return b*desire_weight_price
