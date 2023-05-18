import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/features/auth/domain/entities/cluster.dart';

class ClusterModel extends Cluster {
  ClusterModel({
    required super.clusterId,
    required super.numberOfUsers,
    required super.numberOfSickUsers,
    required super.centroidPosition,
    required super.color,
    required super.radius,
    required super.spreadRate,
  });

  Map<String, dynamic> toJson() {
    return {
      'cluster_id': clusterId,
      'number_of_users': numberOfUsers,
      'number_of_sick_users': numberOfSickUsers,
      'centroid_latitude': centroidPosition.latitude,
      'centroid_longitude': centroidPosition.longitude,
      'color': color.toStringValue(),
      'radius': radius,
      'spread_rate': spreadRate,
    };
  }

  factory ClusterModel.fromJson(Map<String, dynamic> json) {
    final ClusterModel cluster = ClusterModel(
      clusterId: json['cluster_id'],
      numberOfUsers: json['number_of_users'],
      numberOfSickUsers: json['number_of_sick_users'],
      centroidPosition: LatLng(
        json['centroid_latitude'],
        json['centroid_longitude'],
      ),
      color: EnumParsingColor.fromString(json['color']),
      radius: json['radius'],
      spreadRate: json['spread_rate'],
    );
    return cluster;
  }
}
