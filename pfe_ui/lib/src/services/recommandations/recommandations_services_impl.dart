import 'package:get/get.dart';
import 'package:pfe_ui/controller/user_info_controller.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/services/recommandations/recommandations_services.dart';

final UserInfoController userInfoController = Get.find<UserInfoController>();

class RecommandationServicesImpl implements IRecommandationsServices {
  @override
  void getRecommandations(List<Cluster> clusters) {
    userInfoController.recommandation = [];
    for (final cluster in clusters) {
      final double spreadRate = cluster.spreadRate;
      print('spread rate: $spreadRate');
      final double avgFactorDisease = _avgCronicFactors();
      print('avg factor disease: $avgFactorDisease');
      int age = DateTime.now().year - userInfoController.dateOfBirth!.year;
      print('age: $age');
      double factorAge = _factorAge(age);
      print('factor age: $factorAge');

      double recommendation = (spreadRate * avgFactorDisease * factorAge);

      Map<String, num> recommandationMap = {
        'clusterId': cluster.clusterId,
        'recommendation': recommendation,
      };
      userInfoController.recommandation?.add(recommandationMap);
    }
    print('recommandations: ${userInfoController.recommandation}');
  }
}

double _avgCronicFactors() {
  String? cronicDisease1 = userInfoController.cronicDisease1;
  String? cronicDisease2 = userInfoController.cronicDisease2;
  String? cronicDisease3 = userInfoController.cronicDisease3;
  String? cronicDisease4 = userInfoController.cronicDisease4;
  String? cronicDisease5 = userInfoController.cronicDisease5;

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
    case null:
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
