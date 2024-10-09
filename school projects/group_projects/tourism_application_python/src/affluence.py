""" Telecom Paris 2021/2022
    Groupe PACT 7.3 : Module Algorithme et IA
    Remi, Valerio et Cilia
    
    
    Class permettant de calculer le poids de l'affluence
"""

# CETTE CLASSE N EST PAS FONCTIONNELLE####################################""""
from dataAlgory import get_is_open_response_from_api
from dataAlgory import get_avg_affluence_from_api
from dataAlgory import get_affluence_from_api
from dataAlgory import get_number_of_day
from dataAlgory import get_sun_percent_from_api
from dataAlgory import get_temperatures_from_api
from gauss_distribution import Gauss_distribution

from math import log2

import sys
sys.path.append('../routes/')


class Affluence(Gauss_distribution):
    def __init__(self, affluence, affluence_sd, affluence_exp):
        super(self, affluence, affluence_sd, affluence_exp)
