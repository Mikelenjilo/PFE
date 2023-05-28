import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/map/map_services.dart';

class MapServicesImpl implements IMapServices {
  @override
  Future<Map<String, LatLng>> getClusterCentroid() async {
    final List<Cluster> clusters = await DjangoHelper.getClusters();
    Map<String, LatLng> clustersCentroid = {};
    for (var cluster in clusters) {
      clustersCentroid[cluster.clusterId.toString()] = LatLng(
        cluster.centroidPosition.latitude,
        cluster.centroidPosition.longitude,
      );
    }

    return clustersCentroid;
  }
}
