from datetime import datetime, timedelta
import random

from pfe_app.models import Cluster, User


regions = {
    'Zone 1': {'lat_range': (19.0, 24.5), 'lon_range': (-8.0, 3.0)},
    'Zone 2': {'lat_range': (27.0, 37.0), 'lon_range': (-9.0, 12.0)},
    'Zone 3': {'lat_range': (34.0, 37.0), 'lon_range': (2.0, 9.0)},
    'Zone 4': {'lat_range': (35.0, 37.0), 'lon_range': (1.0, 7.0)},
    'Zone 5': {'lat_range': (32.0, 36.0), 'lon_range': (-2.0, 4.0)},
    'Zone 6': {'lat_range': (26.0, 27.0), 'lon_range': (0.0, 8.0)},
    'Zone 7': {'lat_range': (26.0, 30.0), 'lon_range': (2.0, 6.0)},
    'Zone 8': {'lat_range': (28.0, 32.0), 'lon_range': (0.0, 4.0)}
}

# Alger
regionAlger = {
    'Alger-Centre': { # 75 541	
        'lat_range': (36.756819, 36.783496),
        'lon_range': (3.043763, 3.063332),
    },
    'Sidi M Hamed': { # 67 873	
        'lat_range': (36.749753, 36.769832),
        'lon_range': (3.052245, 3.058511),
    },
    'El Madania': { # 51 301
        'lat_range': (36.739934, 36.749701),
        'lon_range': (3.056593, 3.069382),     
    },
    'Belouizdad': { # 58 050
        'lat_range': (36.742267, 36.757259),
        'lon_range': (3.065792, 3.067852),
    }, 
    'Bab El Oued': { # 64 732
        'lat_range': (36.784718, 36.796919),
        'lon_range': (3.048253, 3.052501),
    },
    'Bologhine': { # 43 835	
        'lat_range': (36.794227, 36.810377),
        'lon_range': (3.033280, 3.039030),
    },
    'Casbah': { # 36 762	
        'lat_range': (36.778985, 36.790361),
        'lon_range': (3.048756, 3.064677),
    },
    'Oued Koriche': { # 46 182
        'lat_range': (36.772361, 36.796676),
        'lon_range': (3.041484, 3.044176),
    },
    'Bir Mourad Raïs': { # 55 345
        'lat_range': (36.723816, 36.739775),
        'lon_range': (3.023791, 3.063702),
    },
    'El Biar': { # 57 332
        'lat_range': (36.758474, 36.779239),
        'lon_range': (3.019506, 3.044311),
    },
    'Bouzareah': { # 102 670
        'lat_range': (36.770459, 36.809763),
        'lon_range': (2.995609, 3.017695),
    },
    'Birkhadem': { # 97 749
        'lat_range': (36.701157, 36.731224),
        'lon_range': (3.033811, 3.054668),
    },
    'El Harrach': { # 53 869
        'lat_range': (36.698243, 36.730599),
        'lon_range': (3.116721, 3.150855),         
    },
    'Baraki': { # 126 375
        'lat_range': (36.638960, 36.704853),
        'lon_range': (3.065488, 3.123476),
    },
    'Oued Smar': { # 42 062	
        'lat_range': (36.697875, 36.726350),
        'lon_range': (3.150212, 3.184507),
    },
    'Bachdjerrah': { # 103 289
        'lat_range': (36.714491, 36.732447),
        'lon_range': (3.093360, 3.125289), 
    },
    'Hussein Dey': { # 52 698
        'lat_range': (36.736136, 36.743564),
        'lon_range': (3.084950, 3.129410),
    },
    'Kouba': { # 104 708	
        'lat_range': (36.704383, 36.739539),
        'lon_range': (3.067386, 3.094508),
    },
    'Bourouba': { # 81 661
        'lat_range': (36.706827, 36.724065),
        'lon_range': (3.099020, 3.132480),     
    },
    'Dar El Beïda': { # 102 033
        'lat_range': (36.670800, 36.732183),
        'lon_range': (3.183627, 3.250231),
    },
    'Bab Ezzouar': { # 101 657
        'lat_range': (36.702513, 36.742015),
        'lon_range': (3.168344, 3.196262),
    },
    'Bab Aknoun': { # 33 838
        'lat_range': (36.749260, 36.768920),
        'lon_range': (2.996169, 3.020203),     
    },
    'Dely Ibrahim': { # 50 230
        'lat_range': (36.743028, 2.956219),
        'lon_range': (36.769890, 3.005599),
    },
    'El Hammamet': { # 34 790
        'lat_range': (36.789119, 36.815547),
        'lon_range': (2.954083, 2.999400),
    },
    'Rais Hamidou' : { # 38 451
        'lat_range': (36.794604, 36.816801),
        'lon_range': (3.002659, 3.024631),
    },
    'Djasr Kasentina': { # 133 247
        'lat_range': (36.675657, 36.712684),
        'lon_range': (3.052030, 3.099752),    
    },
    'El Mouradia': { # 38 013
        'lat_range': (36.741368, 36.757625), 
        'lon_range': (3.045533, 3.046143),    
    },
    'Hydra': { # 45 133
        'lat_range': (36.725101, 36.756578),
        'lon_range': (3.017545, 3.034369),    
    },
    'Mohammadia': { # 72 543
        'lat_range': (36.725751, 36.745149),
        'lon_range': (3.130377, 3.176725),
    },
    'Bordj El Kiffan': { # 151 950	
        'lat_range': (36.727393, 36.779795),
        'lon_range': (3.186136, 3.258748),
    },
    'El Magharia': { # 41 453
        'lat_range': (36.723632, 36.737534), 
        'lon_range': (3.101585, 3.120853),
    },
    'Beni Messous': { # 39 191
        'lat_range': (36.770446, 36.799348),
        'lon_range': (2.960610, 2.992945),
    },
    'Les Eucalyptus': { # 126 107
        'lat_range': (36.641295, 36.694444),
        'lon_range': (3.135688, 3.191993),
    },
    'Birtouta': { # 30 575	
        'lat_range': (36.616184, 36.670851),
        'lon_range': (2.952460,  3.060145), 
    },
    'Tessala El Merdja': { # 29 847
        'lat_range': (36.600450, 36.653076),
        'lon_range': (2.892256, 2.956629),     
    },
    'Ouled Chebel': { # 37 196
        'lat_range': (36.576953, 36.633080),
        'lon_range': (2.965764, 3.054616),
    },
    'Sidi Moussa': { # 40 750
        'lat_range': (36.580122, 36.652419),
        'lon_range': (3.057650, 3.144837),     
    },
    'Ain Taya': { # 39 501
        'lat_range': (36.776475, 36.789192),
        'lon_range': (3.268180, 3.322167),     
    },
    'Bordj El Bahri': { # 52 816
        'lat_range': (36.775614, 36.801871),
        'lon_range': (3.234097, 3.268858), 
    },
    'El Marsa': { # 26 100
        'lat_range': (36.799920, 3.231509),
        'lon_range': (36.813211, 3.259585),    
    },
    'Hraoua': { # 37 565
        'lat_range': (36.755721, 3.286808),
        'lon_range': (36.785377, 3.342401),
    },
    'Rouiba': { # 61 984
        'lat_range': (36.702051, 36.765088),
        'lon_range': (3.256457, 3.326131),
    },
    'Reghaïa': { # 85 452
        'lat_range': (36.718193, 36.777702),
        'lon_range': (3.313250, 3.381417),
    },
    'Aïn Benian': { # 68 354
        'lat_range': (36.781223, 36.808029),
        'lon_range': (2.893560, 2.949693),    
    },
    'Staoueli': { # 47 664
        'lat_range': (36.723279, 36.763936),
        'lon_range': (2.842107, 2.902556),
    },
    'Zeralda': { # 51 552
        'lat_range': (36.663835, 36.730809),
        'lon_range': (2.815598, 2.882951),
    },
    'Mahelma': { # 28 758	
        'lat_range': (36.642416, 36.702849),
        'lon_range': (2.805946, 2.898256),    
    },
    'Rahmania': { # 19 396
        'lat_range': (36.660759, 36.701922),
        'lon_range': (2.892074, 2.934989),
    },
    'Souidania': { # 29 105
        'lat_range': (36.690241, 36.736616),
        'lon_range': (2.886935, 2.919207),
    },
    'Cheraga': { # 96 824
        'lat_range': (36.743778, 36.777142),
        'lon_range': (2.886255, 2.981180),    
    },
    'Ouled Fayet': { # 47 604
        'lat_range': (36.702671, 36.746149),
        'lon_range': (2.922533, 2.970426),
    },
    'El Achour': { # 41 070
        'lat_range': (36.708213, 36.747287),
        'lon_range': (2.960876, 3.012031),
    },
    'Draria': { # 44 141
        'lat_range': (36.699190, 36.730702),
        'lon_range': (2.980412, 3.025388),
    },
    'Douera': { # 56 998
        'lat_range': (36.634689, 36.703258),
        'lon_range': (2.874795, 2.968865),
    },
    'Baba Hassen': { # 33 756
        'lat_range': (36.687911, 36.702036),
        'lon_range': (2.943946, 3.005916),
    },
    'Khraicia': { # 37 910
        'lat_range': (36.652381, 36.691483),
        'lon_range': (2.971801, 3.019866),
    },
    'Saoula': { # 41 690
        'lat_range': (36.659297, 36.721007),
        'lon_range': (3.014590, 3.041294),
    },
}

poidsAlger = [76, 68, 52, 59, 65, 44, 37, 47, 56, 58, 103, 98, 54, 126, 42, 104, 53, 105, 82, 102, 102, 34, 50, 35, 39, 134, 38, 46, 73, 152, 41, 39, 126, 31, 30, 37, 41, 40, 40, 52, 26, 38, 62, 86, 69, 68, 41, 45, 57, 34, 47, 52]

diseases = ['maladies renales', 'cancer', 'diabete', 'maladies respiratoires', 'maladies cardiaques', None]

def generateUsers(numberOfUsers, region, poids, regionName):
    for i in range(numberOfUsers):
        first_name = ''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=5))
        last_name = ''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=5))
        
        today = datetime.now()
        min_age = today - timedelta(days=2 * 365)
        max_age = today - timedelta(days=120 * 365)
        random_days = random.randint((today - min_age).days, (min_age - max_age).days)
        date_of_birth = (today - timedelta(days=random_days)).strftime('%Y-%m-%d')


        email = f'{first_name}.{last_name}@example.com'
        password = 'password123'

        diseases = ['maladies renales', 'cancer', 'diabete', 'maladies respiratoires', 'maladies cardiaques', None, None, None]
        
        cronic_disease_1 = random.choice(diseases)
        if cronic_disease_1 != None:
            diseases.remove(cronic_disease_1)

        cronic_disease_2 = random.choice(diseases)
        if cronic_disease_2 != None:
            diseases.remove(cronic_disease_2)

        cronic_disease_3 = random.choice(diseases)
        if cronic_disease_3 != None:    
            diseases.remove(cronic_disease_3)

        cronic_disease_4 = random.choice(diseases)
        if cronic_disease_4 != None:
            diseases.remove(cronic_disease_4)

        cronic_disease_5 = random.choice(diseases)
        if cronic_disease_5 != None:
            diseases.remove(cronic_disease_5)

        diseases = ['maladies renales', 'cancer', 'diabete', 'maladies respiratoires', 'maladies cardiaques', None, None, None]
        gender = random.choice(['Homme', 'Femme'])


        commune = random.choices(list(region.keys()), poids, k=1)[0]


        latitude = random.uniform(*region[commune]['lat_range'])
        longitude = random.uniform(*region[commune]['lon_range'])

        cluster_id = Cluster.objects.get(pk=0)

        if_transmit = random.choice([True, False])
        

        if if_transmit:
            date_of_contamination = (datetime.now() - timedelta(days=random.randint(0, 6))).strftime('%Y-%m-%d')
        else:
            date_of_contamination = None

        recommandation = None
        user = User(first_name=first_name,
                    last_name=last_name,
                    date_of_birth=date_of_birth,
                    email=email,
                    password=password,
                    cronic_disease_1=cronic_disease_1,
                    cronic_disease_2=cronic_disease_2,
                    cronic_disease_3=cronic_disease_3,
                    cronic_disease_4=cronic_disease_4,
                    cronic_disease_5=cronic_disease_5,
                    gender=gender,
                    latitude=latitude,
                    longitude=longitude,
                    cluster_id=cluster_id,
                    if_transmit=if_transmit,
                    date_of_contamination=date_of_contamination,
                    recommandation=recommandation,
                    region=regionName)
        user.save()
    


