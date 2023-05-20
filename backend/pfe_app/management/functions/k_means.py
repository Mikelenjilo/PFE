import random
import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
from haversine import haversine, Unit
from pfe_app.management.functions.remove_clusters import removeCluster

from pfe_app.models import User, Cluster

def kmeans(numberOfClusters):
    removeCluster()
    users = User.objects.values('longitude', 'latitude')
    data = np.array([(x['longitude'], x['latitude']) for x in users])


    kmeans = KMeans(n_clusters=numberOfClusters, init='k-means++', random_state=0).fit(data)

    
    create_clusters(kmeans, numberOfClusters)
    assign_cluster(kmeans, numberOfClusters)

    return kmeans


def create_clusters(kmeans, numberOfClusters):
    labels = kmeans.labels_
    
    for i in range(numberOfClusters):
        users_in_cluster = []
        sick_users_in_cluster = []
        distances = []
        number_of_users = 0
        number_of_sick_users = 0
        centroid = (0, 0)
        radius = 0

        for j, user in enumerate(User.objects.all()):
            if labels[j] == i:
                users_in_cluster.append(user)

        for user in users_in_cluster:
            if user.if_transmit:
                sick_users_in_cluster.append(user)

        number_of_users = len(users_in_cluster)
        number_of_sick_users = len(sick_users_in_cluster)


        centroid = kmeans.cluster_centers_[i]

        
        for user in users_in_cluster:
            user_loc = (user.latitude, user.longitude)
            centroid_loc = (centroid[0], centroid[1])
            distance = haversine(user_loc, centroid_loc, unit=Unit.METERS)
            distances.append(distance)

        radius = max(distances)

        spread_rate = None
        
        cluster = Cluster(cluster_id=i+1, number_of_users=number_of_users, number_of_sick_users=number_of_sick_users,
                          centroid_latitude=centroid[1], centroid_longitude=centroid[0], color=color,
                          radius=radius, spread_rate=spread_rate)
        cluster.save()


def assign_cluster(kmeans, numberOfClusters):
    labels = kmeans.labels_
    users = User.objects.all()
    for i, user in enumerate(User.objects.all()):
        user_cluster_id = Cluster.objects.get(cluster_id=0)
        for j in range(numberOfClusters):
            if labels[i] == j:
                user_cluster_id = Cluster.objects.get(cluster_id=j+1)
                break
        user.cluster_id = user_cluster_id
        user.save()



