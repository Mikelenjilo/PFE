from django.shortcuts import render
from django.http import HttpResponse
from rest_framework import viewsets
from rest_framework.decorators import action, api_view
from rest_framework.response import Response
from rest_framework import status

from .models import User, Cluster
from .serializers import CreateUserSerializer, UserSerializer, ClusterSerializer, UserOnlineStatusSerializer, UserPasswordSerializer, UserLatitudeAndLongitudeSerializer


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
def login_user(request):
    email = request.data.get('email')
    user = User.objects.get(email=email)
    serializer = UserOnlineStatusSerializer(user, data=request.data, partial=True)
    if serializer.is_valid():
        user.online = True
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['PATCH'])
def logout_user(request):
    email = request.data.get('email')
    user = User.objects.get(email=email)
    serializer = UserOnlineStatusSerializer(user, data=request.data, partial=True)
    if serializer.is_valid():
        user.online = False
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    
@api_view(['PATCH'])
def update_user_password(request):
    email = request.data.get('email')
    user = User.objects.get(email=email)
    serializer = UserPasswordSerializer(user, data=request.data, partial=True)
    if serializer.is_valid():
        user.password = request.data.get('password')
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    
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