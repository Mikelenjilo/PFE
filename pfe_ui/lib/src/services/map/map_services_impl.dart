import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/core/utils/database_constants.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/map/map_services.dart';
import 'package:pfe_ui/view/widgets/error_widget.dart';

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

  @override
  Future<void> assignUserToClosestCluster(User user) async {
    LatLng userLocation =
        LatLng(user.location!.latitude, user.location!.longitude);
    List<Cluster> clusters = await DjangoHelper.getClusters();

    double distance1 = 1000000000.0;
    for (var cluster in clusters) {
      LatLng clusterCentroidLocation = LatLng(cluster.centroidPosition.latitude,
          cluster.centroidPosition.longitude);

      double distance2 = const Distance()
          .as(LengthUnit.Meter, userLocation, clusterCentroidLocation);

      if (distance2 < distance1) {
        distance1 = distance2;
        user.clusterId = cluster.clusterId;
      }
    }

    final Map<String, dynamic> data = {
      'user_id': user.userId,
      'cluster_id': user.clusterId,
    };

    final encodedData = jsonEncode(data);

    final Uri uri =
        Uri.parse(DjangoConstants.patchAssignUserToClosestClusterUrl);

    final http.Response response = await http.patch(
      uri,
      body: encodedData,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return;
    } else {
      showError(
          errorText:
              'Erreur lors de l\'assignation de l\'utilisateur au cluster le plus proche');
    }
  }
}
