from datetime import datetime
from pfe_app.models import Cluster, User

def recommandations():
    for user in User.objects.all():
        spreadRate = user.cluster_id.spread_rate
        avgFactorDisease = avg_cronic_factors(user.user_id)
        age = datetime.now().year - user.date_of_birth.year
        factorAge = factor_age(age)

        if spreadRate != None and avgFactorDisease != None and factorAge != None:
            recommandation = round(spreadRate * avgFactorDisease * factorAge, 2)
            user.recommandation = recommandation
            user.save()


def avg_cronic_factors(user_id):
    cronicDisease1 = User.objects.values('cronic_disease_1').get(pk=user_id)
    cronicDisease2 = User.objects.values('cronic_disease_2').get(pk=user_id)
    cronicDisease3 = User.objects.values('cronic_disease_3').get(pk=user_id)
    cronicDisease4 = User.objects.values('cronic_disease_4').get(pk=user_id)
    cronicDisease5 = User.objects.values('cronic_disease_5').get(pk=user_id)

    factorDisease1 = factor_disease(cronicDisease1['cronic_disease_1'])
    factorDisease2 = factor_disease(cronicDisease2['cronic_disease_2'])
    factorDisease3 = factor_disease(cronicDisease3['cronic_disease_3'])
    factorDisease4 = factor_disease(cronicDisease4['cronic_disease_4'])
    factorDisease5 = factor_disease(cronicDisease5['cronic_disease_5'])

    factorDiseasesWithNullValues = [factorDisease1, factorDisease2, factorDisease3, factorDisease4, factorDisease5,]

    factorDiseases = []

    for factor in factorDiseasesWithNullValues:
        if factor != None:
            factorDiseases.append(factor)

    avgFactorDiseases = sum(factorDiseases) / len(factorDiseases)
    
    return avgFactorDiseases

def factor_disease(disease): 
    if disease == 'maladies respiratoires':
        return 0.9
    elif disease == 'diabète':
        return 0.8
    elif disease == 'maladies cardiaques':
        return 0.7
    elif disease == 'cancer':
        return 0.6
    elif disease == 'maladies rénales':
        return 0.4
    elif disease == None:
        return 0.05
    else:
        print('disease not found')
    
def factor_age(age):
    if age > 0 and age <= 15:
        return 0.1
    elif age > 15 and age <= 30:
        return 0.3
    elif age > 30 and age <= 60:
        return 0.5
    elif age > 60 and age <= 120:
        return 0.9
