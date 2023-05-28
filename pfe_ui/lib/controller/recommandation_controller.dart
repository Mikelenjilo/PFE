import 'package:get/get.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/services/recommandations/recommandations_services_impl.dart';

class RecommandationController extends GetxController {
  List<Map<String, num>> recommandations = [];

  void getRecommandations() {
    update();
  }

  Future<void> calculateRecommandations() async {
    List<Cluster> clusters = await DjangoHelper.getClusters();

    RecommandationServicesImpl().getRecommandations(clusters);
    update();
  }
}
