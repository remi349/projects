""" Telecom Paris 2021/2022
    Groupe PACT 7.3 : Module Algorithme et IA
    Remi, Valerio et Cilia
    
    
    Class Main
"""

from popularity import Popularity
from temperature import Temperature
from price import Price
from localisation import Localisation
from activity import Activity
from numpy import string_
from time import sleep
import sys  # nopep8
from os import path  # nopep8
SCRIPT_DIR = path.dirname(path.abspath(__file__))  # nopep8
sys.path.append(path.join(SCRIPT_DIR, "..", "routes"))  # nopep8
from dataAlgory import get_temperatures_from_api
from dataAlgory import get_sun_percent_from_api
from dataAlgory import get_number_of_day
# nous n'avons pas réussi à faire fonctionner l'affluence
#from dataAlgory import get_affluence_from_api
#from dataAlgory import get_avg_affluence_from_api
from dataAlgory import get_is_open_response_from_api


# Test
import traceback
import logging

from meteo import Meteo


def main():
    # tout d'abord nous créons artificiellement une liste d'activités, une activité étant composée de son id, son nom, un prix, une localisation, sa popularité (nombre de hit google), sa dimension, si elle est en intérieur ou non, une description, un boolean qui indique si on l'a déjà visité ou non, le poids de l'activité, un lien qui renvoie à l'image décrivant l'activité
    # remarque : pour l'instant, certains artibuts de l'activité (comme le booléen indiquant si on l'a déjà visité) n'ont pas encore été implémenté
    list_of_activities = [Activity("ChIJLU7jZClu5kcR4PcOOO6p3I0", "Tour Eiffel", Price(10.7), Localisation(48.858370, 2.294481), Popularity(78200000), 125, False, "Tour en fer de Gustave Eiffel (1889), terrasses panoramiques accessibles par escaliers et ascenseurs.", False, 0, "https://vivreparis.fr/wp-content/uploads/2022/01/tour-eiffel.jpg"),
                          Activity("ChIJe2jeNttx5kcRi_mJsGHdkQc", "Jardin du Luxembourg", Price(0), Localisation(48.846870, 2.337170), Popularity(
                              23700000), 500, False, "Parc du XVIIe sicle comprenant des arbres et des jardins soigneusement agences, ainsi que des statues.", False, 0, "https://storage.lebonguide.com/crop-1600x700/65/15/78DE9183-D0A6-4DFA-AA04-8BCEC27E1869.png"),
                          Activity("ChIJG5Qwtitu5kcR2CNEsYy9cdA", "Musée d'Orsay", Price(16), Localisation(48.859961, 2.326561), Popularity(14900000), 188, True, "Le musée d’Orsay (officiellement « établissement public du musée d'Orsay et du musée de l'Orangerie – Valéry Giscard d'Estaing » depuis 2021) est un musée national inauguré en 1986. , Forteresse medivale et residence royale du XIVe sicle abritant aujourd'hui le celebre muse du Louvre.",
                                   False, 0, "https://www.visitmons.be/sites/visitmons/files/styles/gallery_lightbox/public/content/images/facade_musre_d_orsay_p_schmidt.jpg?itok=sCm0fXxC"),
                          Activity("ChIJD3uTd9hx5kcR1IQvGfr8dbk", "Musée du Louvre", Price(17), Localisation(48.864824, 2.334595), Popularity(
                              29200000), 600, True, "Super musée, je recommande", False, 0, "https://vivreparis.fr/wp-content/uploads/2019/07/musee-du-louvre-pyramide-.jpg"),
                          Activity("ChIJr0jUneNx5kcRQ_b6LMiOXek", "Notre-Dame de Paris", Price(0), Localisation(48.852968, 2.349902), Popularity(2040000000), 128, True,
                                   "Un peu brûlée mais toujours debout", False, 0, "https://static.nationalgeographic.fr/files/styles/image_3200/public/Notre-Dame_west-facade.jpg?w=1900&h=2595"),
                          Activity("ChIJjx37cOxv5kcRPWQuEW5ntdk", "Arc de Triomphe", Price(13), Localisation(48.8737793, 2.2950155999999424), Popularity(
                              28500000), 31, True, "Tombe du soldat inconnu", False, 0, "https://upload.wikimedia.org/wikipedia/commons/a/a5/Front_left_views_of_the_Arc_de_Triomphe%2C_Paris_21_October_2010.jpg"),
                          Activity("ChIJAQAAMCxu5kcRx--_4QnbGcI", "Jardin des Tuileries", Price(0), Localisation(48.864344, 2.324654), Popularity(4270000), 505, False,
                                   "Le jardin des Tuileries, parfois appelé jardins des Tuileries au pluriel, est un parc grillagé parisien du 1ᵉʳ arrondissement créé au XVIᵉ siècle, à l'emplacement d'anciennes tuileries qui lui ont donné son nom.", False, 0, "https://www.familiscope.fr/assets/fiches/51000/51311-jardin-des-tuileries-paris-musee-du-louvre.jpg"),
                          Activity("ChIJ7xwB9TJu5kcRtsJIlPxT918", "Eglise de la Madeleine", Price(0), Localisation(48.868663192, 2.321165382), Popularity(
                              3450000), 68, True, "L’église de la Madeleine se situe sur la place de la Madeleine dans le 8ᵉ arrondissement de Paris.", False, 0, "https://www.district-immo.com/wp-content/uploads/2019/11/madeleine_paris_08-1.jpg"),
                          Activity("ChIJVUrgmz5u5kcRWPSN-T8a730", "Musée Grévin", Price(22), Localisation(48.8718378, 2.3422204), Popularity(2260000), 60, True, "Le musée Grévin est un musée de cire privé, inauguré le 5 juin 1882, propriété de Grévin & Cie, situé dans le 9ᵉ arrondissement de Paris, et dans lequel sont regroupées des reproductions en cire de personnages célèbres.",
                                   False, 0, "https://i0.wp.com/www.hisour.com/wp-content/uploads/2022/03/Guide-Tour-of-Grevin-Museum-Paris-France.jpg?fit=1200%2C800&ssl=1"),
                          Activity("ChIJAflt_zxy5kcRmeE4zjXi9ig", "Bibliothèque François-Mittérand", Price(0), Localisation(48.8308, 2.3592), Popularity(2140000), 274, True, "La Bibliothèque nationale de France, ainsi dénommée depuis 1994, est la bibliothèque nationale de la République française, inaugurée sous cette nouvelle appellation le 30 mars 1995 par le président de la République, François Mitterrand.",
                                   False, 0, "https://www.leparisien.fr/resizer/hfcFkyR-gUDiRmtIDCInUF8G3fM=/932x582/cloudfront-eu-central-1.images.arcpublishing.com/leparisien/NRNYWM2AFVBTNSBBGUAGMVBOAA.jpg"),
                          Activity("ChIJdbbQwbZx5kcRs7Qu5nPw18g", "Les catacombes de Paris", Price(15), Localisation(48.8337349984, 2.32605869576), Popularity(1460000), 105, True, "Les catacombes de Paris, terme utilisé pour nommer l'ossuaire municipal, sont à l'origine une partie des anciennes carrières souterraines situées dans le 14ᵉ arrondissement de Paris, reliées entre elles par des galeries d'inspection.",
                                   False, 0, "https://www.sncf-connect.com/assets/styles/ratio_2_1_max_width_961/public/media/2021-09/croix-tombe-catacombes-paris.jpg?h=7cb206bd&itok=rOa3b80w"),
                          Activity("ChIJc8mX0udx5kcRWKcjTwDr5QA", "Panthéon", Price(11.5), Localisation(48.846222, 2.346414), Popularity(
                              27600000), 96, True, "Le Panthéon est un monument de style néo-classique situé dans le 5ᵉ arrondissement de Paris.", False, 0, "https://cdn.sortiraparis.com/images/80/86947/463600-l-histoire-silencieuse-des-sourds-l-exposition-au-pantheon.jpg"),
                          Activity("ChIJUzCPuddv5kcRasGAnEUUWkU", "Hôtel des Invalides", Price(14), Localisation(48.854677, 2.312461), Popularity(
                              4240000), 77, True, "L’hôtel des Invalides est un monument parisien, situé dans le 7ᵉ arrondissement, dont la construction fut ordonnée par Louis XIV par l'édit royal du 24 février 1670, pour accueillir les invalides de ses armées.", False, 0, "https://vivreparis.fr/wp-content/uploads/2019/09/hotel-des-invalides-a-paris.jpg"),
                          Activity("ChIJAYa7ntNx5kcRcmJxXPZ7m9k", "Le Bon Marché", Price(0), Localisation(48.8506082642, 2.32128704818), Popularity(
                              119000000), 88, True, "Le Bon Marché est un grand magasin français, situé dans un quadrilatère encadré par la rue de Sèvres, la rue de Babylone, la rue du Bac et la rue Velpeau dans le 7ᵉ arrondissement de Paris.", False, 0, "https://cdn.sortiraparis.com/images/80/96058/697038-photos-les-vitrines-et-decorations-de-noel-du-bon-marche-2021.jpg")
                          ]
    # tout d'abord on récupére la météo ewtérieur et la température par scrapping, ainsi que la localisation de l'utilisateur
    TEMPERATURE = Temperature(0, 0, 0)
    meteo = Meteo()
    # les coefficients sys.argv[] sont les valeurs renvoyées par le serveur
    self_localisation = Localisation(float(str(sys.argv[1])), float(
        str(sys.argv[2])))  # Localisation de l'utilisateur
    # nous pouvons également pour faire des tests fixer hypothétiquement l'utilisateur à certains lieux
    # self_localisation = Localisation(48.873792, 2.295028)  # Test : Arc de Triomphe
    # self_localisation = Localisation(48.852968, 2.349902)  # Test : Notre-Dame

    # ici, l'ion vient tenir en compte du fait que l'activité soit en intérieur ou en extérieur
    for activity in list_of_activities:
        if activity.indoor:
            activity_indoor = -1
        else:
            activity_indoor = 1
    # on vient ensuite calculer le poids de l'activité, et l'on vient modifier le paramètre poids de chaque activité
    # ce poids est composé du poids du prix, du poids de la popularité.... l'on a mis en argument des fonctions les coefficients proportionnels "b", revoyés par le serveur (ce sont les sys.argv[i])
        total_Weight = activity.get_price().Weight_price(activity, float(sys.argv[8])) + self_localisation.Weight_distance(activity, float(sys.argv[6])) + activity_indoor*(
            meteo.Weight_meteo(float(sys.argv[4]))) + activity.get_popularity().Weight_popularity(activity, float(sys.argv[3])) + TEMPERATURE.Weight_temperature(float(sys.argv[5]))
        activity.weight_of_place = total_Weight
    # appel à la fonction de tri des activités
    sorted = sort_activities(list_of_activities)
    string_to_return = ""  # string que l'on renverra au serveur
    for activity in sorted:
        string_to_return += activity.get_name() + ";"
        string_to_return += activity.get_description() + ";"
        string_to_return += activity.get_link() + ";"
    print(string_to_return)
    return string_to_return  # le serveur reçoit une string avec le nom de l'activité, sa description et sa photo, pour qu'il puisse l'afficher convenablement

# fonction effectuant un tri rapide en fonction du poids des activités, pour mettre en prémière place l'activité la plus intéressant


def sort_activities(list_of_activities):
    left = []
    equal = []
    right = []

    if len(list_of_activities) > 1:
        pivot = list_of_activities[0].get_weight_of_place()
        for activity in list_of_activities:
            weight_to_sort = activity.get_weight_of_place()
            if weight_to_sort < pivot:
                left.append(activity)
            elif weight_to_sort == pivot:
                equal.append(activity)
            elif weight_to_sort > pivot:
                right.append(activity)
        # appel recursif à la fonction sort_activities
        left = sort_activities(left)
        right = sort_activities(right)
        return left + equal + right
    return list_of_activities


if __name__ == '__main__':
    main()
