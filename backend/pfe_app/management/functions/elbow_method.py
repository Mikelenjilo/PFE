import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

from pfe_app.models import User

def elbow_method():
    users = User.objects.exclude(latitude__isnull=True, longitude__isnull=True).values('longitude', 'latitude')

    users_list = list(users)
    users_array = np.array([[user['latitude'], user['longitude']] for user in users_list])

    data = (users_array - np.mean(users_array, axis=0)) / np.std(users_array, axis=0)

    distortions = []
    pourcentage = 0
    for i in range(1, 20):
        pourcentage += 100/20 
        print('Pourcentage de complétion : ', pourcentage, '%')
        kmeans = KMeans(n_clusters=i, init='k-means++', max_iter=300, n_init=10, random_state=0)
        kmeans.fit(data)
        distortions.append(kmeans.inertia_)


    plt.plot(range(1, 20), distortions)
    plt.title('Elbow Method')
    plt.xlabel('Nombre de clusters')
    plt.ylabel('Distortion')
    plt.show()