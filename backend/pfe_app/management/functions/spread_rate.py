from math import pi
from pfe_app.models import Cluster


def spread_rate():
    clusters = Cluster.objects.exclude(cluster_id=0)
    spreadRates = []

    for cluster in clusters:
        numberOfUsers = cluster.number_of_users
        numberOfSickUsers = cluster.number_of_sick_users
        surface = 2 * pi * cluster.radius ** 2 
        spreadRate = numberOfSickUsers / (numberOfUsers * surface)
        spreadRates.append(spreadRate)

    maxSpreadRate = max(spreadRates)

    for i, cluster in enumerate(clusters):
        cluster.spread_rate = round(spreadRates[i] / maxSpreadRate, 2)
        cluster.save()
    
