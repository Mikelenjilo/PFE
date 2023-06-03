from django.shortcuts import render
from django.http import HttpResponse
from rest_framework import viewsets
from rest_framework.decorators import action, api_view
from rest_framework.response import Response
from rest_framework import status
from haversine import haversine, Unit

from pfe_app.management.functions.prefiltrage_method import prefiltrageMethod, prefiltrageMethodOneUser


from .models import User, Cluster
from .serializers import CreateUserSerializer, UserCronicDiseasesSerializer, UserSerializer, ClusterSerializer, UserOnlineStatusSerializer, UserPasswordSerializer, UserLatitudeAndLongitudeSerializer, UserToClosestCluster, UserUpdateDateOfContamination, UserUpdateInfoSerializer


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class ClusterViewSet(viewsets.ModelViewSet):
    queryset = Cluster.objects.all()
    serializer_class = ClusterSerializer
        
@api_view(['GET'])
def get_user_by_email(request):
    email = request.query_params.get('email', None)
    if not email:
        return Response({'email': 'This field is required.'}, status=status.HTTP_400_BAD_REQUEST)
    user = User.objects.filter(email=email).first()
    if not user:
        return Response({'detail': 'User not found.'}, status=status.HTTP_404_NOT_FOUND)
    serializer = UserSerializer(user)
    return Response(serializer.data)


@api_view(['POST'])
def create_user(request):
    serializer = CreateUserSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
@api_view(['PATCH'])
def update_user_latitude_and_longitude(request):
    user_id = request.data.get('user_id')
    user = User.objects.get(user_id=user_id)

        
    serializer = UserLatitudeAndLongitudeSerializer(user, data=request.data, partial=True)
    
    if serializer.is_valid():
        user.latitude = request.data.get('latitude')
        user.longitude = request.data.get('longitude')
    
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    

@api_view(['PATCH'])
def update_user_cronic_diseases(request):
    user_id = request.data.get('user_id')
    user = User.objects.get(user_id=user_id)
    serializer = UserCronicDiseasesSerializer(user, data=request.data, partial=True)
    if serializer.is_valid():
        user.cronic_disease_1 = request.data.get('cronic_disease_1')
        user.cronic_disease_2 = request.data.get('cronic_disease_2')
        user.cronic_disease_3 = request.data.get('cronic_disease_3')
        user.cronic_disease_4 = request.data.get('cronic_disease_4')
        user.cronic_disease_5 = request.data.get('cronic_disease_5')
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    



@api_view(['PATCH'])
def assign_user_to_cluster(request):
    user_id = request.data.get('user_id')
    cluster_id = request.data.get('cluster_id')
    user = User.objects.get(user_id=user_id)
    cluster = Cluster.objects.get(cluster_id=cluster_id)
    serializer = UserToClosestCluster(user, data=request.data, partial=True)

    if serializer.is_valid():
        user.cluster_id = cluster
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    

@api_view(['PATCH'])
def update_user_password(request):
    user_email = request.data.get('email')
    user_password = request.data.get('password')
    user = User.objects.get(email=user_email)
    serializer = UserPasswordSerializer(user, data=request.data, partial=True)
    if serializer.is_valid():
        user.password = user_password
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['PATCH'])
def update_user_infos(request):
    user_id = request.data.get('user_id')
    user_first_name = request.data.get('first_name')
    user_last_name = request.data.get('last_name')
    user_date_of_birth = request.data.get('date_of_birth')
    user_password = request.data.get('password')

    user = User.objects.get(user_id=user_id)

    serializer = UserUpdateInfoSerializer(user, data=request.data, partial=True)    
    if serializer.is_valid():
        user.first_name = user_first_name
        user.last_name = user_last_name
        user.date_of_birth = user_date_of_birth
        user.password = user_password
        serializer.save()
        prefiltrageMethodOneUser(user_id)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
@api_view(['PATCH'])
def update_user_date_of_contamination(request):
    user_id = request.data.get('user_id')
    user_date_of_contamination = request.data.get('date_of_contamination')
    user_if_transmit = request.data.get('if_transmit')
    user = User.objects.get(user_id=user_id)
    serializer = UserUpdateDateOfContamination(user, data=request.data, partial=True)
    if serializer.is_valid():
        user.date_of_contamination = user_date_of_contamination
        user.if_transmit = user_if_transmit
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)