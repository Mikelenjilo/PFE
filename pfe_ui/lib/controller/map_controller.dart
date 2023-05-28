import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/controller/recommandation_controller.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/auth/auth_services_impl.dart';

import 'package:pfe_ui/src/services/recommandations/recommandations_services_impl.dart';

final RecommandationController recommandationController =
    Get.find<RecommandationController>();
final User? user = Get.find<UserController>().user;

class MapAppController extends GetxController {
  LatLng center = LatLng(28.0339, 1.6596);
  Marker? userLocationMarker;
  bool isLoading = false;
  List<Marker> markers = [];
  double zoom = 5.0;

  @override
  Future<void> onInit() async {
    super.onInit();
    await recommandationController.calculateRecommandations();
    await populateUserMarker();
    await populateMarkers();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.defaultDialog(
        title: 'Bienvenue!',
        content: const Text(
            '''Pour bénéficier des recommandations et statistiques qui sont basées sur votre poition actuelle et votre profil (age, maladies chroniques), il faut que vous activiez votre GPS en cliquant sur le bouton en bas à droite de l'écran.'''),
        textConfirm: 'Okay',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    });
  }

  Future<void> getLocation() async {
    isLoading = true;
    update();

    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      Get.defaultDialog(
        title: 'Erreur',
        content: const Text(
            'Vous devez activer votre GPS pour bénéficier des recommandations et statistiques.'),
        textConfirm: 'Okay',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
      return;
    } else if (permission == LocationPermission.unableToDetermine) {
      Get.defaultDialog(
        title: 'Erreur',
        content: const Text(
            'Vous devez activer votre GPS pour bénéficier des recommandations et statistiques.'),
        textConfirm: 'Okay',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
      return;
    } else {
      Position position;

      try {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
      } on Exception catch (e) {
        Get.defaultDialog(
          title: 'Erreur: ${e.toString()}',
          content: const Text(
              'Vous devez activer votre GPS pour bénéficier des recommandations et statistiques.'),
          textConfirm: 'Okay',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
        return;
      }

      LatLng userLocation = LatLng(position.latitude, position.longitude);
      user?.location = userLocation;

      userLocationMarker = Marker(
        width: 40.0,
        height: 40.0,
        point: userLocation,
        builder: (ctx) =>
            const Icon(Icons.location_on, size: 45, color: Colors.red),
      );
      await DjangoHelper.patchUpdateUserLatitudeAndLongitude(
        userId: user!.userId,
        position: userLocation,
      );

      if (user!.clusterId == 0) {
        await AuthImpl().assignUserToClosestCluster(user!);
        await DjangoHelper.patchAssignUserToClosestCluster(
          userId: user!.userId,
          clusterId: user!.clusterId,
        );
      }

      isLoading = false;
      update();
    }
  }

  Future<void> populateUserMarker() async {
    if (user?.location == null) {
      return;
    } else {
      print(user!.location!);
      userLocationMarker = Marker(
        width: 40.0,
        height: 40.0,
        point: user!.location!,
        builder: (ctx) =>
            const Icon(Icons.location_on, size: 45, color: Colors.red),
      );
    }

    update();
  }

  Future<void> populateMarkers() async {
    isLoading = true;
    update();

    final clustersData = await DjangoHelper.getClusters();

    markers.clear();

    for (var cluster in clustersData) {
      LatLng centroid = cluster.centroidPosition;
      Color color;
      String text;
      if (cluster.spreadRate >= 0.7) {
        color = Colors.red;
        text = 'Taux de propagation très élevé';
      } else if (cluster.spreadRate >= 0.5) {
        color = Colors.deepOrange;
        text = 'Taux de propagation élevé';
      } else if (cluster.spreadRate >= 0.4) {
        color = Colors.orange;
        text = 'Taux de propagation moyen';
      } else if (cluster.spreadRate >= 0.1) {
        color = Colors.yellow;
        text = 'Taux de propagation faible';
      } else if (cluster.spreadRate > 0) {
        color = Colors.green;
        text = 'Taux de propagation très faible';
      } else {
        color = Colors.white;
        text = 'Taux de propagation nul';
      }

      markers.add(
        Marker(
          width: cluster.radius,
          height: cluster.radius,
          point: centroid,
          builder: (ctx) => GestureDetector(
            child: Icon(
              Icons.circle,
              size: cluster.radius,
              color: color.withOpacity(0.4),
            ),
            onTap: () {
              Get.defaultDialog(
                title: text,
                titleStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                content: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cluster ID: ${cluster.clusterId}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Rayon du cluster: ${round(cluster.radius / 1000, decimals: 1)}km',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Nombre des utilisateurs: ${cluster.numberOfUsers}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Nombre des utilisateurs malades: ${cluster.numberOfSickUsers}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Taux de propagation: ${cluster.spreadRate * 100}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                textConfirm: 'Fermer',
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back();
                },
                barrierDismissible: true,
                radius: 10.0,
                contentPadding: const EdgeInsets.only(bottom: 10.0),
              );
            },
          ),
        ),
      );
    }

    isLoading = false;
    update();
  }

  Future<void> populateMarkersWithUsersLocation() async {
    isLoading = true;
    update();

    final clustersData = await DjangoHelper.getClusters();

    markers.clear();

    for (var cluster in clustersData) {
      LatLng centroid = cluster.centroidPosition;
      final List<Map<String, num>> recommandations =
          recommandationController.recommandations;

      for (Map<String, num> recommandation in recommandations) {
        if (recommandation['clusterId'] == cluster.clusterId) {
          cluster.spreadRate = recommandation['recommendation'] as double;
        }
      }
      Color color;
      String text;
      if (cluster.spreadRate >= 0.7) {
        color = Colors.red;
        text = 'Danger très élevé';
      } else if (cluster.spreadRate >= 0.5) {
        color = Colors.deepOrange;
        text = 'Danger élevé';
      } else if (cluster.spreadRate >= 0.4) {
        color = Colors.orange;
        text = 'Danger moyen';
      } else if (cluster.spreadRate >= 0.1) {
        color = Colors.yellow;
        text = 'Danger faible';
      } else if (cluster.spreadRate > 0) {
        color = Colors.green;
        text = 'Danger très faible';
      } else {
        color = Colors.white;
        text = 'Danger nul';
      }

      markers.add(
        Marker(
          width: cluster.radius,
          height: cluster.radius,
          point: centroid,
          builder: (ctx) => GestureDetector(
            child: Icon(
              Icons.circle,
              size: cluster.radius,
              color: color.withOpacity(0.4),
            ),
            onTap: () {
              Get.defaultDialog(
                title: text,
                titleStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                content: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cluster ID: ${cluster.clusterId}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Rayon du cluster: ${round(cluster.radius / 1000, decimals: 1)}km',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Nombre des utilisateurs: ${cluster.numberOfUsers}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Nombre des utilisateurs malades: ${cluster.numberOfSickUsers}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Taux de propagation: ${round(cluster.spreadRate, decimals: 2) * 100}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                textConfirm: 'Fermer',
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back();
                },
                barrierDismissible: true,
                radius: 10.0,
                contentPadding: const EdgeInsets.only(bottom: 10.0),
              );
            },
          ),
        ),
      );
    }

    isLoading = false;
    update();
  }

  Future<void> getRecommandations() async {
    List<Cluster> clusters = await DjangoHelper.getClusters();
    RecommandationServicesImpl().getRecommandations(clusters);
  }
}
