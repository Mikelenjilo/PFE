from math import pi
from pfe_app.models import Cluster


def spread_rate():
    clusters = Cluster.objects.exclude(cluster_id=0)
    
    for cluster in clusters:
        numberOfUsers = cluster.number_of_users
        numberOfSickUsers = cluster.number_of_sick_users
        surface = 2 * pi * (cluster.radius) ** 2 
        facteur_surface = calculate_surface_facteur(surface)
        spreadRate = numberOfSickUsers / (numberOfUsers) * facteur_surface
        cluster.spread_rate = spreadRate
        cluster.save()

def calculate_surface_facteur(surface):
    if surface > 0 and surface <= 1000:
        return 1
    elif surface > 1000 and surface <= 2000:
        return 0.75
    elif surface > 2000 and surface <= 3000:
        return 0.5
    elif surface > 3000 and surface <= 4000:
        return 0.25
    elif surface > 4000:
        return 0.05