""" Telecom Paris 2021/2022
    Groupe PACT 7.3 : Module Algorithme et IA
    Remi, Valerio et Cilia
    
    
    Class calculant les distances entre les lieux 
"""

from math import acos
from math import sin
from math import cos
from math import log2


class Localisation:
    def __init__(self, latitude, longitude):
        self.longitude = 0
        self.set_latitude(latitude)
        self.set_longitude(longitude)

    AVG_DISTANCE = 7882  # average distance between 2 points in Paris
    EARTH_RADIUS = 6378137  # The radius of earth

    def get_longitude(self):
        return self.longitude

    def set_longitude(self, longitude):
        self.longitude = longitude

    def get_latitude(self):
        return self.latitude

    def set_latitude(self, latitude):
        self.latitude = latitude

    def distance_to(self, activity):
        lat = activity.localisation.get_latitude()
        long = activity.localisation.get_longitude()
        
        
        d_lambda = long - self.longitude

        # distance as a function of attitude and longitude
        temp = sin(self.latitude)*sin(lat) +  cos(self.latitude) * cos(lat)*cos(d_lambda)

        distance = acos(temp)*self.EARTH_RADIUS
        return distance
    
    
    
    

    def Weight_distance(self, activity, b):
        distance = self.distance_to(activity)

        # Desire of the distance
        desire_weight = log2((distance)/(self.AVG_DISTANCE))

        # Surprise of distance
        surprise_weight = 2*log2((distance)/(activity.dimension))

        return b*(desire_weight+surprise_weight)
