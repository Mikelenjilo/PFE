import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

abstract class IMapServices {
  Future<Map<String, LatLng>> getClusterCentroid();
}
