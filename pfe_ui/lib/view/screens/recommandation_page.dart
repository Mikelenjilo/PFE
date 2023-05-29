import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_ui/controller/recommandation_controller.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/core/utils/ui_constants.dart';
import 'package:pfe_ui/src/models/user.dart';

final RecommandationController recommandationController =
    Get.find<RecommandationController>();

// ignore: must_be_immutable
class RecommendationsPage extends StatelessWidget {
  double recommandationRate = 0;

  RecommendationsPage({super.key});

  double recommandationDetection(int clusterId) {
    final List<Map<String, num>> recommandations =
        recommandationController.recommandations;

    for (Map<String, num> recommandation in recommandations) {
      if (recommandation['clusterId'] == clusterId) {
        return recommandation['recommendation'] as double;
      }
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommandationController>(
      builder: (controller) {
        final User user = Get.find<UserController>().user!;
        final int clusterId = user.clusterId;
        recommandationRate = recommandationDetection(clusterId);

        if (clusterId == 0) {
          return const Center(
            child: Text(
              'Vous n\'êtes pas encore affecté à un cluster, parceque vous n\'avez pas encore partagé votre position',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (recommandationRate >= 0.7) {
          return const DangerTresEleve();
        } else if (recommandationRate >= 0.5) {
          return const DangerEleve();
        } else if (recommandationRate >= 0.4) {
          return const DangerMoyen();
        } else if (recommandationRate >= 0.1) {
          return const DangerFaible();
        } else if (recommandationRate > 0) {
          return const DangerTresFaible();
        } else {
          return const Center(
            child: Text(
              'Recommandation non disponible, veuillez activez votre position et réessayer',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
      },
    );
  }
}

class DangerTresEleve extends StatelessWidget {
  const DangerTresEleve({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 50.0,
          ),
          child: Column(
            children: [
              Text(
                'EpidemicZone',
                style: kTextStyleTitle,
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.red,
                ),
                child: Text(
                  'Taux de propagation est très élevé dans votre zone géographique',
                  style: GoogleFonts.averiaLibre(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30.0,
                  ),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueGrey.shade100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conseils de précaution: ',
                        style: GoogleFonts.mada(
                          color: Colors.blue,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '- Portez un masque facial dans les espaces publics.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Lavez-vous régulièrement les mains avec du savon et de l\'eau pendant au moins 20 secondes.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Évitez les contacts étroits avec les personnes malades ou présentant des symptômes.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DangerEleve extends StatelessWidget {
  const DangerEleve({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 50.0,
          ),
          child: Column(
            children: [
              Text(
                'EpidemicZone',
                style: kTextStyleTitle,
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.deepOrange,
                ),
                child: Text(
                  'Taux de propagation élevé dans votre zone',
                  style: GoogleFonts.averiaLibre(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30.0,
                  ),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueGrey.shade100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conseils de précaution: ',
                        style: GoogleFonts.mada(
                          color: Colors.blue,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '- Limitez les déplacements non essentiels.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Évitez les grands rassemblements et maintenez la distance physique recommandée.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Suivez les consignes des autorités sanitaires locales',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DangerMoyen extends StatelessWidget {
  const DangerMoyen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 50.0,
          ),
          child: Column(
            children: [
              Text(
                'EpidemicZone',
                style: kTextStyleTitle,
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.orange,
                ),
                child: Text(
                  'Taux de propagation est moyen votre zone géographique',
                  style: GoogleFonts.averiaLibre(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30.0,
                  ),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueGrey.shade100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conseils de précaution: ',
                        style: GoogleFonts.mada(
                          color: Colors.blue,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '- Portez un masque facial lorsque la distanciation physique n\'est pas possible.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Pratiquez une bonne hygiène des mains en utilisant du désinfectant à base d\'alcool.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Évitez de toucher votre visage et couvrez votre bouche et votre nez en toussant ou en éternuant.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DangerFaible extends StatelessWidget {
  const DangerFaible({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 50.0,
          ),
          child: Column(
            children: [
              Text(
                'EpidemicZone',
                style: kTextStyleTitle,
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.yellow.shade600,
                ),
                child: Text(
                  'Taux de propagation est faible dans votre zone géographique',
                  style: GoogleFonts.averiaLibre(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30.0,
                  ),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueGrey.shade100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conseils de précaution: ',
                        style: GoogleFonts.mada(
                          color: Colors.blue,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '- Continuez à respecter les mesures de distanciation physique.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Restez informé des dernières directives des autorités sanitaires.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Soyez vigilant face à tout changement dans la situation épidémiologique.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DangerTresFaible extends StatelessWidget {
  const DangerTresFaible({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 50.0,
          ),
          child: Column(
            children: [
              Text(
                'EpidemicZone',
                style: kTextStyleTitle,
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.green,
                ),
                child: Text(
                  'Taux de propagation est très faible dans votre zone géographique',
                  style: GoogleFonts.averiaLibre(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30.0,
                  ),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueGrey.shade100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conseils de précaution: ',
                        style: GoogleFonts.mada(
                          color: Colors.blue,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '- Continuez à suivre les mesures d\'hygiène générales.',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Soutenez les efforts de santé publique en encourageant les autres à se conformer aux recommandations',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Restez informé des mises à jour de santé publique locales',
                        style: GoogleFonts.mada(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
