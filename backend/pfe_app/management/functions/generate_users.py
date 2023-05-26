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

diseases = ['maladies renales', 'cancer', 'diabete', 'maladies respiratoires', 'maladies cardiaques', None]

def generateUsers():
    for i in range(1000):
                first_name = ''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=5))
                last_name = ''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=5))
                date_of_birth = (datetime.now() - timedelta(days=random.randint(0, 15000))).strftime('%Y-%m-%d')
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

                region = random.choices(list(regions.keys()), weights=[5, 2, 20, 15, 8, 5, 5, 5], k=1)[0]

                latitude = random.uniform(*regions[region]['lat_range'])
                longitude = random.uniform(*regions[region]['lon_range'])

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
                            recommandation=recommandation)
                user.save()
