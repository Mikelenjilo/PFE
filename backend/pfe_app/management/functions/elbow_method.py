import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

from pfe_app.models import User

# TODO: fix the error: TypeErro: unsupported operand type(s) for +: 'dict' and 'dict'
def elbow_method():
    queryset = User.objects.values('latitude', 'longitude')
    data_list = list(queryset)
    data_array = np.array([[d['latitude'], d['longitude']] for d in data_list])

    # normalize the data
    data = (data_array - np.mean(data_array, axis=0)) / np.std(data_array, axis=0)

    # determine the optimal number of clusters using the elbow method
    distortions = []
    for i in range(1, 11):
        kmeans = KMeans(n_clusters=i, init='k-means++', max_iter=300, n_init=10, random_state=0)
        kmeans.fit(data)
        distortions.append(kmeans.inertia_)
    plt.plot(range(1, 11), distortions)
    plt.title('Elbow Method')
    plt.xlabel('Number of Clusters')
    plt.ylabel('Distortion')
    plt.show()
    
