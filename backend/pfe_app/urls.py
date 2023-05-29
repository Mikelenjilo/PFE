from django.urls import path, include
from rest_framework import routers
from .views import UserViewSet, ClusterViewSet
from . import views

router = routers.DefaultRouter()
router.register(r'users', UserViewSet, basename='users')
router.register(r'clusters', ClusterViewSet, basename='clusters')


urlpatterns = [
    path('', include(router.urls)),
    path('get_user_by_email/', views.get_user_by_email, name='get_user_by_email'),
    path('create_user/', views.create_user, name='create_user'),
    path('update_user_password/', views.update_user_password, name='update_user_password'),
    path('update_user_latitude_and_longitude/', views.update_user_latitude_and_longitude, name='update_user_latitude_and_longitude'),
    path('update_user_cronic_diseases/', views.update_user_cronic_diseases, name='update_user_cronic_diseases'),
    path('assign_user_to_cluster/', views.assign_user_to_cluster, name='assign_user_to_cluster'),
    path('update_user_password/', views.update_user_password, name='update_user_password'),
    path('update_user_infos/', views.update_user_infos, name='update_user_infos'),
]

