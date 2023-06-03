import random
import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
from haversine import haversine, Unit
from pfe_app.management.functions.remove_clusters import removeCluster
from pfe_app.management.functions.spread_rate import spread_rate

from pfe_app.models import User, Cluster

def kmeans(numberOfClusters, regionName, numberOfClustersAlreadyCreated):
    users = User.objects.exclude(latitude__isnull=True, longitude__isnull=True).filter(region=regionName).values('latitude', 'longitude')

    users_location = np.array([(user['latitude'], user['longitude']) for user in users])

    kmeans = KMeans(n_clusters=numberOfClusters, init='k-means++', random_state=0).fit(users_location)

    plt.scatter(users_location[:, 1], users_location[:, 0])
    plt.xlabel('Longitude')
    plt.ylabel('Latitude')
    plt.title('Localisation des utilisateurs')
    plt.show()

    
    create_clusters(kmeans, numberOfClusters, regionName, numberOfClustersAlreadyCreated)
    assign_cluster(kmeans, numberOfClusters, regionName, numberOfClustersAlreadyCreated)
    spread_rate()

    plot_data(kmeans, users_location)
    
    return kmeans


def create_clusters(kmeans, numberOfClusters, regionName, numberOfClustersAlreadyCreated):
    labels = kmeans.labels_
    users = User.objects.exclude(latitude__isnull=True, longitude__isnull=True).filter(region=regionName)
    
    for i in range(numberOfClusters): # i = 0
        users_in_cluster = []
        sick_users_in_cluster = []
        distances = []
        number_of_users = 0
        number_of_sick_users = 0
        centroid = (0, 0)
        radius = 0

        for j, user in enumerate(users):
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
            distance = haversine(user_loc, centroid_loc, unit=Unit.KILOMETERS)
            distances.append(distance)

        radius = max(distances)

        spread_rate = None
        
        cluster = Cluster(cluster_id=i+1+numberOfClustersAlreadyCreated, number_of_users=number_of_users, number_of_sick_users=number_of_sick_users,
                          centroid_latitude=centroid[0], centroid_longitude=centroid[1], radius=radius, spread_rate=spread_rate, region=regionName)
        cluster.save()



def assign_cluster(kmeans, numberOfClusters, regionName, numberOfClustersAlreadyCreated):
    labels = kmeans.labels_
    users = User.objects.exclude(latitude__isnull=True, longitude__isnull=True).filter(region=regionName)
    for i, user in enumerate(users):
        user_cluster_id = Cluster.objects.get(cluster_id=0)
        for j in range(numberOfClusters):
            if labels[i] == j:
                user_cluster_id = Cluster.objects.get(cluster_id=j + 1 + numberOfClustersAlreadyCreated)
                break
        user.cluster_id = user_cluster_id
        user.save()



def plot_data(kmeans, data):
    labels = kmeans.labels_
    
    for i in range(len(np.unique(labels))):
        cluster_data = data[labels == i]
        plt.scatter(cluster_data[:, 1], cluster_data[:, 0],label=f'Cluster {i+1}')
    
    plt.scatter(kmeans.cluster_centers_[:, 1], kmeans.cluster_centers_[:, 0], color='red', marker='x', label='Centroids') # type: ignore
    
    plt.title('K-means Clustering')
    plt.xlabel('Latitude')
    plt.ylabel('Longitude')
    plt.legend()
    plt.show()