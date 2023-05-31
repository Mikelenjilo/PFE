import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/src/models/cluster.dart';

abstract class IRecommandationsServices {
  void getRecommandations(List<Cluster> clusters);
  Future<void> updateUserLatitudeLongitude({
    required int userId,
    required LatLng position,
  });
  Future<void> updateUserDateOfContamination({
    required int userId,
    required String dateOfContamination,
  });
}
