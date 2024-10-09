import pandas as pd
from gauss_distribution import Gauss_distribution

from math import log2

import sys  # nopep8
from os import path  # nopep8
SCRIPT_DIR = path.dirname(path.abspath(__file__))  # nopep8
sys.path.append(path.join(SCRIPT_DIR, "..", "routes"))  # nopep8

from dataAlgory import get_temperatures_from_api
from dataAlgory import get_sun_percent_from_api
from dataAlgory import get_number_of_day
#from dataAlgory import get_affluence_from_api
#from dataAlgory import get_avg_affluence_from_api
from dataAlgory import get_is_open_response_from_api


class Temperature(Gauss_distribution):

    def __init__(self, temperature, standard_deviation, expectation):

        super().__init__(temperature, standard_deviation, expectation)

        self.surprise_temperature()

    T_CONF = 22

    def get_temperature(self):
        return self.get_parametre()

    def surprise_temperature(self):
        self.set_parametre(get_temperatures_from_api())
        #file = path.join(SCRIPT_DIR, "exceptation_standard_deviation.xlsx")
        file = "/home/ubuntu/git/pact73/src/exceptation_standard_deviation.xlsx"
        df = pd.read_excel(file)

        # expectation temperature [column,line]
        temperature_exp = df.iloc[get_number_of_day(), 0]
        self.set_expectation(temperature_exp)

        # standard deviation of temperature
        temperature_sd = df.iloc[get_number_of_day(), 1]
        self.set_standard_deviation(temperature_sd)

        return self.gaussian_weight()

    def Weight_temperature(self, b):

        self.set_parametre(get_temperatures_from_api())

        df = pd.read_excel("/home/ubuntu/git/pact73/src/exceptation_standard_deviation.xlsx")

        # expectation temperature [column,line]
        temperature_exp = df.iloc[get_number_of_day(), 0]
        self.set_expectation(temperature_exp)

        # standard deviation of temperature
        temperature_sd = df.iloc[get_number_of_day(), 1]
        self.set_standard_deviation(temperature_sd)

        temperature = get_temperatures_from_api()

        #temperature = 20

        # Desire of the distance
        desire_temperature = log2(1+(temperature-self.T_CONF)/(self.T_CONF))

        # Surprise of distance
        surprise_temperature = self.surprise_temperature()

        return b*(desire_temperature+surprise_temperature)
