import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/controller/recommandation_controller.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/core/utils/database_constants.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/recommandations/recommandations_services.dart';
import 'package:pfe_ui/view/widgets/error_widget.dart';

final RecommandationController recommandationController =
    Get.find<RecommandationController>();

final User? user = Get.find<UserController>().user;

class RecommandationServicesImpl implements IRecommandationsServices {
  @override
  void getRecommandations(List<Cluster> clusters) {
    recommandationController.recommandations.clear();

    final DateTime dateOfBirthInDateTime = DateTime.parse(user!.dateOfBirth);
    final int age = DateTime.now().year - dateOfBirthInDateTime.year;
    final double factorAge = _factorAge(age);

    final double avgFactorDisease = _avgCronicFactors();

    for (final cluster in clusters) {
      final double spreadRate = cluster.spreadRate;

      double recommendation = (spreadRate * avgFactorDisease * factorAge);

      Map<String, num> recommandationMap = {
        'clusterId': cluster.clusterId,
        'recommendation': recommendation,
      };
      recommandationController.recommandations.add(recommandationMap);
    }
  }

  @override
  Future<void> updateUserLatitudeLongitude({
    required int userId,
    required LatLng position,
  }) async {
    final Map<String, dynamic> data = {
      'user_id': userId,
      'latitude': position.latitude,
      'longitude': position.longitude,
    };

    final encodedData = jsonEncode(data);

    final Uri uri =
        Uri.parse(DjangoConstants.patchUpdateUserLatitudeAndLongitudeUrl);

    final http.Response response = await http.patch(
      uri,
      body: encodedData,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return;
    } else {
      showError(errorText: 'Error updating user position');
    }
  }

  @override
  Future<void> updateUserDateOfContamination({
    required int userId,
    required String? dateOfContamination,
  }) async {
    final bool ifTransmit;
    if (dateOfContamination == null) {
      ifTransmit = false;
    } else {
      ifTransmit = true;
    }
    final Map<String, dynamic> data = {
      'user_id': userId,
      'date_of_contamination': dateOfContamination,
      'if_transmit': ifTransmit,
    };

    final encodedData = jsonEncode(data);

    final Uri uri =
        Uri.parse(DjangoConstants.patchUpdateUserDateOfContaminationUrl);

    final http.Response response = await http.patch(
      uri,
      body: encodedData,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return;
    } else {
      showError(errorText: 'Error updating user date of contamination');
    }
  }
}

double _avgCronicFactors() {
  switch (user?.cronicDiseases?.length) {
    case 0:
      return 0.05;
    case 1:
      String? cronicDisease1 = user?.cronicDiseases?[0];

      double factorDisease1 = _factorDisease(cronicDisease1);

      return factorDisease1;

    case 2:
      String? cronicDisease1 = user?.cronicDiseases?[0];
      String? cronicDisease2 = user?.cronicDiseases?[1];

      double factorDisease1 = _factorDisease(cronicDisease1);
      double factorDisease2 = _factorDisease(cronicDisease2);

      List<double> factorDiseases = [
        factorDisease1,
        factorDisease2,
      ];

      double avgFactorDiseases = factorDiseases.isNotEmpty
          ? factorDiseases.reduce((a, b) => a + b) / factorDiseases.length
          : 0.0;

      return avgFactorDiseases;

    case 3:
      String? cronicDisease1 = user?.cronicDiseases?[0];
      String? cronicDisease2 = user?.cronicDiseases?[1];
      String? cronicDisease3 = user?.cronicDiseases?[2];

      double factorDisease1 = _factorDisease(cronicDisease1);
      double factorDisease2 = _factorDisease(cronicDisease2);
      double factorDisease3 = _factorDisease(cronicDisease3);

      List<double> factorDiseases = [
        factorDisease1,
        factorDisease2,
        factorDisease3,
      ];

      double avgFactorDiseases = factorDiseases.isNotEmpty
          ? factorDiseases.reduce((a, b) => a + b) / factorDiseases.length
          : 0.0;

      return avgFactorDiseases;

    case 4:
      String? cronicDisease1 = user?.cronicDiseases?[0];
      String? cronicDisease2 = user?.cronicDiseases?[1];
      String? cronicDisease3 = user?.cronicDiseases?[2];
      String? cronicDisease4 = user?.cronicDiseases?[3];

      double factorDisease1 = _factorDisease(cronicDisease1);
      double factorDisease2 = _factorDisease(cronicDisease2);
      double factorDisease3 = _factorDisease(cronicDisease3);
      double factorDisease4 = _factorDisease(cronicDisease4);

      List<double> factorDiseases = [
        factorDisease1,
        factorDisease2,
        factorDisease3,
        factorDisease4,
      ];

      double avgFactorDiseases = factorDiseases.isNotEmpty
          ? factorDiseases.reduce((a, b) => a + b) / factorDiseases.length
          : 0.0;

      return avgFactorDiseases;

    case 5:
      String? cronicDisease1 = user?.cronicDiseases?[0];
      String? cronicDisease2 = user?.cronicDiseases?[1];
      String? cronicDisease3 = user?.cronicDiseases?[2];
      String? cronicDisease4 = user?.cronicDiseases?[3];
      String? cronicDisease5 = user?.cronicDiseases?[4];

      double factorDisease1 = _factorDisease(cronicDisease1);
      double factorDisease2 = _factorDisease(cronicDisease2);
      double factorDisease3 = _factorDisease(cronicDisease3);
      double factorDisease4 = _factorDisease(cronicDisease4);
      double factorDisease5 = _factorDisease(cronicDisease5);

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

    default:
      return 0.0;
  }
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
    case null:
      return 0.05;
    default:
      throw Exception('Maladie non trouvée');
  }
}

double _factorAge(int age) {
  if (age > 0 && age <= 15) {
    return 0.1;
  } else if (age > 15 && age <= 30) {
    return 0.3;
  } else if (age > 30 && age <= 60) {
    return 0.5;
  } else if (age > 60 && age <= 80) {
    return 0.8;
  } else if (age > 80 && age <= 120) {
    return 0.9;
  } else {
    throw Exception('Invalid age');
  }
}
