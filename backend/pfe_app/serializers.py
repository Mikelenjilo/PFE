from rest_framework import serializers
from .models import User, Cluster

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class ClusterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cluster
        fields = '__all__'

class CreateUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'date_of_birth', 'email', 'password', 'gender', 'date_of_contamination', 'cluster_id']

class UserOnlineStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['online']
    

class UserLatitudeAndLongitudeSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['user_id', 'latitude', 'longitude']

class UserCronicDiseasesSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['user_id', 'cronic_disease_1', 'cronic_disease_2', 'cronic_disease_3', 'cronic_disease_4', 'cronic_disease_5']

class UserToClosestCluster(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['user_id', 'cluster_id']


class UserPasswordSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['email', 'password']

class UserUpdateInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['user_id', 'first_name', 'last_name', 'date_of_birth', 'password']