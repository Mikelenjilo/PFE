import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'dart:math' as math;

import 'package:pfe_ui/src/services/recommandations/recommandations_services_impl.dart';

class MapAppController extends GetxController {
  LatLng center = LatLng(28.0339, 1.6596);
  Marker? userLocationMarker;
  bool isLoading = false;
  List<Marker> markers = [];
  double zoom = 5.0;

  Future<void> getLocation() async {
    isLoading = true;
    update();

    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // TODO: handle the scenario when the user denies location permission
    } else if (permission == LocationPermission.deniedForever) {
      // TODO: handle the scenario when the user denies location permission permanently
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      LatLng userLocation = LatLng(position.latitude, position.longitude);
      center = userLocation;
      userLocationMarker = Marker(
        width: 40.0,
        height: 40.0,
        point: userLocation,
        builder: (ctx) =>
            const Icon(Icons.location_on, size: 45, color: Colors.red),
      );

      isLoading = false;
      update();
    }
  }

  Future<void> populateMarkers() async {
    isLoading = true;
    update();

    final clustersData = await DjangoHelper.getClusters();

    markers.clear();

    for (var cluster in clustersData) {
      LatLng centroid = cluster.centroidPosition;
      Color color;
      if (cluster.spreadRate >= 0.7) {
        color = Colors.red;
      } else if (cluster.spreadRate >= 0.5) {
        color = Colors.deepOrange;
      } else if (cluster.spreadRate >= 0.4) {
        color = Colors.orange;
      } else if (cluster.spreadRate >= 0.1) {
        color = Colors.yellow;
      } else if (cluster.spreadRate > 0) {
        color = Colors.green;
      } else {
        color = Colors.white;
      }

      markers.add(
        Marker(
          width: 100,
          height: 100,
          point: centroid,
          builder: (ctx) => GestureDetector(
            child: Icon(
              Icons.circle,
              size: 100,
              color: color.withOpacity(0.6),
            ),
            onTap: () {
              Get.defaultDialog(
                title: 'Cluster Info',
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
                        'Rayon du cluster: ${round(cluster.radius, decimals: 1)}m',
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
                        'Taux de propagation: ${cluster.spreadRate}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                textConfirm: 'Close',
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back();
                },
                barrierDismissible: true,
                radius: 10.0,
                contentPadding: EdgeInsets.zero,
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
