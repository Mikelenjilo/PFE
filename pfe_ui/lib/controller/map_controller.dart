import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/controller/inscription_controller.dart';
import 'package:pfe_ui/controller/recommandation_controller.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/map/map_services_impl.dart';

import 'package:pfe_ui/src/services/recommandations/recommandations_services_impl.dart';
import 'package:pfe_ui/view/widgets/error_widget.dart';

final RecommandationController recommandationController =
    Get.find<RecommandationController>();
final User? user = Get.find<UserController>().user;
final InscriptionController inscriptionController =
    Get.find<InscriptionController>();

class MapAppController extends GetxController {
  Rx<LatLng> center = LatLng(36.710865, 3.094955).obs;
  Marker? userLocationMarker;
  RxBool isLoading = false.obs;
  RxList<dynamic> markers = [].obs;
  RxDouble zoom = 10.0.obs;
  final mapControllerFlutterMap = MapController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getLocation();
    await populateMarkers();
    recommandationController.calculateRecommandations();
    if (inscriptionController.isInscriptionDone) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          Get.defaultDialog(
            title: 'Une dernière question',
            content: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''Est-ce que vous avez des symptômes \ndu COVID-19 ?''',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          String dateOfContamination =
                              DateTime.now().toIso8601String().substring(0, 10);
                          await RecommandationServicesImpl()
                              .updateUserDateOfContamination(
                            userId: user!.userId,
                            dateOfContamination: dateOfContamination,
                          );
                        },
                        child: const Text('Oui')),
                    ElevatedButton(
                      onPressed: () {
                        RecommandationServicesImpl()
                            .updateUserDateOfContamination(
                          userId: user!.userId,
                          dateOfContamination: null,
                        );
                      },
                      child: const Text('Non'),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }
  }

  void updateCenter(LatLng newCenter) {
    center.value = newCenter;
  }

  void updateZoom(double newZoom) {
    zoom.value = newZoom;
  }

  double calculateMarkerSize(double zoom) {
    return 150 * (1 / zoom);
  }

  Future<void> getLocation() async {
    isLoading.value = true;

    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      showError(errorText: 'Vous devez activer votre GPS pour continuer.');
      return;
    } else if (permission == LocationPermission.unableToDetermine) {
      showError(errorText: 'Erreur: impossible de déterminer votre position.');
      return;
    } else {
      Position position;

      try {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
      } on Exception catch (e) {
        showError(errorText: 'Erreur: $e');
        return;
      }

      LatLng userLocation = LatLng(position.latitude, position.longitude);
      user?.location = userLocation;

      mapControllerFlutterMap.move(userLocation, 11);

      UserController userController = Get.find<UserController>();
      userController.updateUserLocation(userLocation);

      userLocationMarker = Marker(
        width: 40.0,
        height: 40.0,
        point: userLocation,
        builder: (ctx) => const Icon(
          Icons.location_on,
          size: 45,
          color: Colors.red,
        ),
      );

      await RecommandationServicesImpl().updateUserLatitudeLongitude(
        userId: user!.userId,
        position: userLocation,
      );

      if (user!.clusterId == 0) {
        await MapServicesImpl().assignUserToClosestCluster(user!);
      }

      isLoading.value = false;
    }
  }

  Future<void> populateMarkers() async {
    isLoading.value = true;

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
          width: 150,
          height: 150,
          point: centroid,
          builder: (ctx) => GestureDetector(
            child: Icon(
              Icons.circle,
              size: 150,
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

    isLoading.value = false;
  }

  Future<void> getRecommandations() async {
    List<Cluster> clusters = await DjangoHelper.getClusters();
    RecommandationServicesImpl().getRecommandations(clusters);
  }

  Future<void> searchLocation(String wilaya) async {
    wilaya = wilaya.toLowerCase().capitalizeFirst!;
    final location = await locationFromAddress(wilaya);
    if (location.isNotEmpty) {
      mapControllerFlutterMap.move(
        LatLng(location.first.latitude, location.first.longitude),
        11,
      );
    } else {
      showError(errorText: 'Wilaya introuvable.');
    }
  }
}
