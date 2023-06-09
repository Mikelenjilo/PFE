import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/src/models/user.dart';

class Cluster {
  int clusterId;
  List<User> users;
  int numberOfUsers = 0;
  int numberOfSickUsers = 0;
  LatLng centroidPosition = LatLng(0, 0);
  double radius;
  double spreadRate;
  String region;

  Cluster(
      {required this.clusterId,
      required this.numberOfUsers,
      required this.numberOfSickUsers,
      required this.centroidPosition,
      required this.radius,
      required this.spreadRate,
      this.users = const [],
      required this.region});

  @override
  String toString() {
    return 'Cluster(clusterId: $clusterId, numberOfUsers: $numberOfUsers, numberOfSickUsers: $numberOfSickUsers, centroidPosition: $centroidPosition, region: $region, radius: $radius, spreadRate: $spreadRate, users: $users)';
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
      region: json['region'],
    );
    return cluster;
  }
}
