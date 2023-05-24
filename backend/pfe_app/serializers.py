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
    
class UserPasswordSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['password']

class UserLatitudeAndLongitudeSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['latitude', 'longitude']
