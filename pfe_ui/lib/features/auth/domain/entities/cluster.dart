import 'package:latlong2/latlong.dart';

enum Color {
  red,
  orange,
  yellow,
  green,
  blue,
  purple,
  pink,
  brown,
  grey,
  black
}

extension EnumParsingColor on Color {
  toStringValue() {
    return toString().split('.').last;
  }

  static Color fromString(String value) {
    return Color.values
        .firstWhere((element) => element.toStringValue() == value);
  }
}

class Cluster {
  int clusterId;
  int numberOfUsers;
  int numberOfSickUsers;
  LatLng centroidPosition;
  Color color;
  double radius;
  double spreadRate;

  Cluster({
    required this.clusterId,
    required this.numberOfUsers,
    required this.numberOfSickUsers,
    required this.centroidPosition,
    required this.color,
    required this.radius,
    required this.spreadRate,
  });
}
