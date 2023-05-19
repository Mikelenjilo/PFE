import 'package:pfe_ui/src/models/cluster.dart';

abstract class IRecommandationsServices {
  void getRecommandations(List<Cluster> clusters);
}
