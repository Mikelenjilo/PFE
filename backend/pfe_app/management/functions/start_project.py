from pfe_app.management.functions.elbow_method import elbow_method
from pfe_app.management.functions.generate_users import generateUsers
from pfe_app.management.functions.k_means import kmeans
from pfe_app.management.functions.remove_infos import removeInfos
from pfe_app.management.functions.spread_rate import spread_rate

regionAlger = {
    'Ain Benian': { # 68 354
        'lat_range': (36.787231, 36.806338),
        'lon_range': (2.896973, 2.944005)
    },
    'Cheraga': { # 80 824 
        'lat_range': (36.766205, 36.773355),
        'lon_range': (2.874874, 2.980017)
    },
    'Bab Ezzouar': { # 96 597 
        'lat_range': (36.704927, 36.741411),
        'lon_range': (3.167161, 3.195322)
    },
    'Bab El Oued': { # 214 900
        'lat_range': (36.786962, 36.795443),
        'lon_range': (3.045044, 3.054087)
    },
    'Bachdjerrah': { # 93 289 
        'lat_range': (36.713697, 36.732238),
        'lon_range': (3.093078, 3.124621)
    },
    'Baraki': { # 116 375 
        'lat_range': (36.639466, 36.702939),
        'lon_range': (3.066335, 3.115945)
    },
    'Bir Mourad Rais': { # 45 345 
        'lat_range': (36.724024, 36.738367),
        'lon_range': (3.025036, 3.064046)
    },
    'Birkhadem': { # 82 000 
        'lat_range': (36.703506, 36.726004),
        'lon_range': (3.032373, 3.058252)
    },
    'Birtouta': { # 66 428 
        'lat_range': (36.617683, 36.667957),
        'lon_range': (2.947907, 3.063778)
    },
    'Bordj El Bahri': { # 27 900
        'lat_range': (36.777490, 36.799946),
        'lon_range': (3.231529, 3.271342)
    }
}
poidsAlger = [7, 8, 10, 23, 10, 13, 5, 9, 7, 3]

regionOran = {
    'Oran': { # 
        'lat_range': (35.651916, 35.768999),
        'lon_range': (-0.717916, -0.556701)
    },
    'Gdyel': { # 39 129	
        'lat_range': (35.777885, 35.616),
        'lon_range': (-0.512843, -0.583)
    },
    'Bir El Djir': { # 171 883
        'lat_range': (35.699519, 35.774251),
        'lon_range': (-0.602275, -0.515923)
    },
    'Hassi Bounif': { # 70 852
        'lat_range': (35.697018, 35.712909),
        'lon_range': (-0.536909, -0.453997)
    },
    'Es Senia': {  # 97 500
        'lat_range': (35.605518, 35.673827),
        'lon_range': (-0.689922, -0.597118)
    },
    'Arzew': { # 70 951
        'lat_range': (35.810590, 35.887396),
        'lon_range': (-0.376597, -0.309993)
    },
    'Bethioua': { # 18 215
        'lat_range': (35.735459, 35.802315),
        'lon_range': (-0.261643, -0.203278)
    },
    'Mersat El Hadjadj': { # 14 167
        'lat_range': (35.724614, 35.788838),
        'lon_range': (-0.206780, -0.122783)
    },
    'Aïn El Turk': { # 37 010
        'lat_range': (35.709250, 35.742951),
        'lon_range': (-0.821527, -0.704999)
    },
    'El Ançor': { # 7 929
        'lat_range': (35.634424, 35.715024),
        'lon_range': (-0.922209, -0.840155)
    },
    'Oued Tlelat': {
        'lat_range': (35.512959, 35.615266),
        'lon_range': (-0.523335, -0.403230)
    }, 
    'Tafraoui': {
        'lat_range': (35.334358, 35.551229),
        'lon_range': (-0.619994, -0.466480)
    },
    'Sidi Chami': { #
        'lat_range': (35.632134, 35.688029),
        'lon_range': (-0.587482, -0.447849)
    },
    'Boufatis': { #
        'lat_range': (35.598484, 35.719287),
        'lon_range': (-0.451046, -0.302944)
    },
    'Mers El Kébir': { # 
        'lat_range': (35.583336, 35.642229),
        'lon_range': (-0.546011, -0.431513)
    },
    'Bousfer': {
        'lat_range': (35.679893, 35.749442),
        'lon_range': (-0.846636, -0.804922)
    },
    'El Kerma': { # 
        'lat_range': (35.519858, 35.634903),
        'lon_range': (-0.634423, -0.536576)
    },
    'El Braya': {
        'lat_range': (35.581521, 35.639996),
        'lon_range': (-0.544294, -0.432886)
    },
    'Hassi Ben Okba': {
        'lat_range': (35.713768, 35.774654),
        'lon_range': ( -0.514531, -0.460801)
    },
    'Ben Freha': {
        'lat_range': (35.772763, 35.817736),
        'lon_range': (-0.392402, -0.364593)
    },
    'Hassi Mefsoukh': {
        'lat_range': (35.760923, 35.818989),
        'lon_range': (-0.399612, -0.359615)
    },
    'Sidi Benyebka': { #
        'lat_range': (35.815407, 35.879755),
        'lon_range': (-0.471500, -0.371237)
    },
    'Misserghin': { #  
        'lat_range': (35.737000, 35.710759),
        'lon_range': (-0.206780, -0.718586)
    },
    'Boutlelis': { #
        'lat_range': (35.546708, 35.669524),
        'lon_range': (-0.989864, -0.822666)
    },
    'Ain El Kerma': { # , 
        'lat_range': (35.604800, 35.682531),
        'lon_range': (-1.046055, -0.938267)
    },
    'Ain El Bia': { #
        'lat_range': (35.764227, 35.819507),
        'lon_range': (-0.353972, -0.262476)
    }
}
poidsOran = [100, 6, 26, 10, 15, 13, 3, 2, 5, 2, 4, 2, 19, 2, 3, 3, 4, 1, 3, 5, 3, 2, 5, 5, 2, 7]


def start_project():
    nombreDesUtilisateursAlger = 1000
    nombreDesUtilisateursOran = 1000
    nombreDeClusterOptimalAlger = 0
    nombreDeClusterOptimalOran = 0
    numberOfClustersAlreadyCreated = 0

    # Netoyage de la base de données
    print('Lancement du script qui permet de nettoyer la base de données...')
    removeInfos()
    print('Nettoyage terminé !')

    # Génération des utilisateurs qui se situe à Alger
    print('Lancement du script qui permet de générer ', nombreDesUtilisateursAlger, 'des utilisateurs qui se situe à Alger...')
    generateUsers(nombreDesUtilisateursAlger, regionAlger, poidsAlger, 'Alger')
    print('Génération terminée !')

    # Détermination du nombre optimal des clusters
    print('Lancement de la fonction qui permet de déterminer le nombre optimal des clusters (elbow method) dans la région d\'Alger ...')
    elbow_method()
    print('Détermination terminée !')
    nombreDeClusterOptimalAlger = int(input('Entrez le nombre optimal des clusters : '))

    # Lancement du k-means
    print('Lancement du k-means pour la région d\'Alger...')
    kmeans(nombreDeClusterOptimalAlger, 'Alger', numberOfClustersAlreadyCreated)
    numberOfClustersAlreadyCreated += nombreDeClusterOptimalAlger
    print('k-means terminé pour la région d\'Alger !')


    # Génération des utilisateurs qui se situe à Oran
    print('Lancement du script qui permet de générer ', nombreDesUtilisateursOran, 'des utilisateurs qui se situe à Oran...')
    generateUsers(nombreDesUtilisateursOran, regionOran, poidsOran, 'Oran')

    # Détermination du nombre optimal des clusters
    print('Lancement de la fonction qui permet de déterminer le nombre optimal des clusters (elbow method)...')
    elbow_method()
    print('Détermination terminée !')
    nombreDeClusterOptimalOran = int(input('Entrez le nombre optimal des clusters : '))

    # Lancement du k-means
    print('Lancement du k-means pour la région d\'Oran...')
    kmeans(nombreDeClusterOptimalOran, 'Oran', numberOfClustersAlreadyCreated)
    numberOfClustersAlreadyCreated += nombreDeClusterOptimalOran
    print('k-means terminé pour la région d\'Oran !')

     # Lancement de la fonction qui permet de calculer le taux de propagation
    print('Lancement de la fonction qui permet de calculer le taux de propagation...')
    spread_rate()
    print('Calcul terminé !')



    



