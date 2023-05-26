import 'package:get/get.dart';
import 'package:pfe_ui/controller/recommandation_controller.dart';
import 'package:pfe_ui/core/services/shared_preferences_services.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/services/recommandations/recommandations_services.dart';

final RecommandationController recommandationController =
    Get.find<RecommandationController>();

class RecommandationServicesImpl implements IRecommandationsServices {
  @override
  void getRecommandations(List<Cluster> clusters) {
    final double avgFactorDisease = _avgCronicFactors();
    final DateTime dateOfBirthInDateTime =
        DateTime.parse(SharedPreferencesService.getDateOfBirth());
    int age = DateTime.now().year - dateOfBirthInDateTime.year;
    double factorAge = _factorAge(age);

    for (final cluster in clusters) {
      final double spreadRate = cluster.spreadRate;

      double recommendation = (spreadRate * avgFactorDisease * factorAge);

      Map<String, num> recommandationMap = {
        'clusterId': cluster.clusterId,
        'recommendation': recommendation,
      };
      recommandationController.recommandation.add(recommandationMap);
    }
  }
}

double _avgCronicFactors() {
  String? cronicDisease1 = SharedPreferencesService.getCronicDisease1();
  String? cronicDisease2 = SharedPreferencesService.getCronicDisease2();
  String? cronicDisease3 = SharedPreferencesService.getCronicDisease3();
  String? cronicDisease4 = SharedPreferencesService.getCronicDisease4();
  String? cronicDisease5 = SharedPreferencesService.getCronicDisease5();

  double? factorDisease1 = _factorDisease(cronicDisease1);
  double? factorDisease2 = _factorDisease(cronicDisease2);
  double? factorDisease3 = _factorDisease(cronicDisease3);
  double? factorDisease4 = _factorDisease(cronicDisease4);
  double? factorDisease5 = _factorDisease(cronicDisease5);

  List<double> factorDiseases = [
    factorDisease1,
    factorDisease2,
    factorDisease3,
    factorDisease4,
    factorDisease5,
  ];

  double avgFactorDiseases = factorDiseases.isNotEmpty
      ? factorDiseases.reduce((a, b) => a + b) / factorDiseases.length
      : 0.0;

  return avgFactorDiseases;
}

double _factorDisease(String? disease) {
  switch (disease) {
    case 'maladies respiratoires':
      return 0.9;
    case 'diabete':
      return 0.8;
    case 'maladies cardiaques':
      return 0.7;
    case 'cancer':
      return 0.6;
    case 'maladies renales':
      return 0.4;
    case '':
      return 0.05;
    default:
      throw Exception('Disease not found');
  }
}

double _factorAge(int age) {
  if (age > 0 && age <= 15) {
    return 0.1;
  } else if (age > 15 && age <= 30) {
    return 0.3;
  } else if (age > 30 && age <= 60) {
    return 0.5;
  } else if (age > 60 && age <= 120) {
    return 0.9;
  } else {
    throw Exception('Invalid age');
  }
}
