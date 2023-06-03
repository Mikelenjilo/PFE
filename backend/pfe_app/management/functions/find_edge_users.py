import numpy as np
from pfe_app.models import Cluster, User
from haversine import haversine, Unit

def findEdgeUsers(cluster):
    users = User.objects.all().filter(cluster_id=cluster.cluster_id)
    edge_users = {}
    distances = {}
    k = 5

    for user in users:
        centroid = (cluster.centroid_latitude, cluster.centroid_longitude)
        distance = haversine((user.latitude, user.longitude), centroid, unit=Unit.KILOMETERS)
        distances[user] = distance

    sorted_users = sorted(distances, key=distances.get, reverse=True)[:k] # type: ignore
    for user in sorted_users:
        edge_users[user.user_id] = {"user_id": user.user_id, "location": (user.latitude, user.longitude)}
   
   
    print(centroid)
    print(edge_users)



