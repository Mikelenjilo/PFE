import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/src/models/user.dart';

abstract class IMapServices {
  Future<Map<String, LatLng>> getClusterCentroid();
  Future<void> assignUserToClosestCluster(User user);
}
