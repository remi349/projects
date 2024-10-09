""" Telecom Paris 2021/2022
    Groupe PACT 7.3 : Module Algorithme et IA
    Remi, Valerio et Cilia
    
    
    Class permettant de calculer le poids de l'affluence et de la météo en utilisant des gaussiennes et des écarts types, elle sera implémenté par d'autres classes
"""
# remarque, l'affluence ne fonctionne pas encore


class Gauss_distribution(object):
    def __init__(self, parametre, standard_deviation, expectation):
        self.set_parametre(parametre)  # parametre
        self.set_standard_deviation(standard_deviation)  # ecart type
        self.set_expectation(expectation)  # espérance

    def get_parametre(self):
        return self.parametre

    def set_parametre(self, parametre):
        self.parametre = parametre

    def set_standard_deviation(self, standard_deviation):
        self.standard_deviation = standard_deviation

    def get_standard_deviation(self):
        return self.standard_deviation

    def get_expectation(self):
        return self.expectation

    def set_expectation(self, expectation):
        self.expectation = expectation

# poids qui sera utilisé pour l'affluence et la météo, mais l'on a pas les données pour l'affluence...
    def gaussian_weight(self):
        return 0.72*(((self.get_parametre()-self.get_expectation())/self.get_standard_deviation())**2)

# dataclass package
