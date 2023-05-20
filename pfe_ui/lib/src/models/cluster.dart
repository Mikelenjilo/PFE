import 'package:latlong2/latlong.dart';

class Cluster {
  int clusterId;
  int numberOfUsers = 0;
  int numberOfSickUsers = 0;
  LatLng centroidPosition = LatLng(0, 0);
  double radius;
  double spreadRate;

  Cluster({
    required this.clusterId,
    required this.numberOfUsers,
    required this.numberOfSickUsers,
    required this.centroidPosition,
    required this.radius,
    required this.spreadRate,
  });

  @override
  String toString() {
    return 'Cluster(clusterId: $clusterId, numberOfUsers: $numberOfUsers, numberOfSickUsers: $numberOfSickUsers, centroidPosition: $centroidPosition, radius: $radius, spreadRate: $spreadRate)';
  }

  Map<String, dynamic> toJson() {
    return {
      'cluster_id': clusterId,
      'number_of_users': numberOfUsers,
      'number_of_sick_users': numberOfSickUsers,
      'centroid_latitude': centroidPosition.latitude,
      'centroid_longitude': centroidPosition.longitude,
      'radius': radius,
      'spread_rate': spreadRate,
    };
  }

  factory Cluster.fromJson(json) {
    final Cluster cluster = Cluster(
      clusterId: json['cluster_id'],
      numberOfUsers: json['number_of_users'],
      numberOfSickUsers: json['number_of_sick_users'],
      centroidPosition: LatLng(
        json['centroid_latitude'],
        json['centroid_longitude'],
      ),
      radius: json['radius'],
      spreadRate: json['spread_rate'],
    );
    return cluster;
  }
}
