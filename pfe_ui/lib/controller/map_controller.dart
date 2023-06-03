import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/controller/inscription_controller.dart';
import 'package:pfe_ui/controller/recommandation_controller.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/services/map/map_services_impl.dart';

import 'package:pfe_ui/src/services/recommandations/recommandations_services_impl.dart';
import 'package:pfe_ui/view/widgets/error_widget.dart';

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
    await Get.find<RecommandationController>().calculateRecommandations();
    if (Get.find<InscriptionController>().isInscriptionDone) {
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
                            userId: Get.find<UserController>().user!.userId,
                            dateOfContamination: dateOfContamination,
                          );
                          Get.find<InscriptionController>().isInscriptionDone =
                              false;

                          Get.back();
                        },
                        child: const Text('Oui')),
                    ElevatedButton(
                      onPressed: () {
                        RecommandationServicesImpl()
                            .updateUserDateOfContamination(
                          userId: Get.find<UserController>().user!.userId,
                          dateOfContamination: null,
                        );
                        Get.find<InscriptionController>().isInscriptionDone =
                            false;

                        Get.back();
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

  double calculerDistanceEnPixels(double distanceEnM) {
    double distanceEnPixels = distanceEnM * 1 / 47;
    return distanceEnPixels;
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
      Get.find<UserController>().user!.location = userLocation;

      mapControllerFlutterMap.move(userLocation, 11);

      Get.find<UserController>().updateUserLocation(userLocation);

      userLocationMarker = Marker(
        width: 40.0,
        height: 40.0,
        point: userLocation,
        builder: (ctx) => const Icon(
          FontAwesomeIcons.locationDot,
          size: 45,
          color: Colors.blue,
        ),
      );

      await RecommandationServicesImpl().updateUserLatitudeLongitude(
        userId: Get.find<UserController>().user!.userId,
        position: userLocation,
      );

      if (Get.find<UserController>().user!.clusterId == 0) {
        await MapServicesImpl()
            .assignUserToClosestCluster(Get.find<UserController>().user!);
      }

      isLoading.value = false;
    }
  }

  Future<void> populateMarkers() async {
    isLoading.value = true;

    final clustersData = await DjangoHelper.getClusters();

    final DateTime dateOfBirthInDateTime =
        DateTime.parse(Get.find<UserController>().user!.dateOfBirth);
    final int age = DateTime.now().year - dateOfBirthInDateTime.year;
    final double factorAge = factorAgeFunction(age);

    final double avgFactorDisease = avgCronicFactors();

    markers.clear();

    for (var cluster in clustersData) {
      LatLng centroid = cluster.centroidPosition;
      Color color;
      String text;
      double radius = calculerDistanceEnPixels(cluster.radius * 1000);
      double recommandation =
          cluster.spreadRate * factorAge * avgFactorDisease * 10;

      if (recommandation >= 0.7) {
        color = Colors.red;
        text = 'Danger très élevé pour vous';
      } else if (recommandation >= 0.5) {
        color = Colors.deepOrange;
        text = 'Danger élevé pour vous';
      } else if (recommandation >= 0.4) {
        color = Colors.orange;
        text = 'Danger moyen pour vous';
      } else if (recommandation >= 0.1) {
        color = Colors.yellow;
        text = 'Danger faible pour vous';
      } else if (recommandation > 0) {
        color = Colors.green;
        text = 'Danger très faible pour vous';
      } else {
        color = Colors.white;
        text = 'Danger nul pour vous';
      }
      markers.add(
        Marker(
          width: radius,
          height: radius,
          point: centroid,
          builder: (ctx) => GestureDetector(
            child: Icon(
              Icons.circle,
              size: radius,
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
                        'Rayon du cluster: ${round(cluster.radius, decimals: 1)}km',
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
                        'Taux de propagation: ${round(cluster.spreadRate * 100, decimals: 2)}%',
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
