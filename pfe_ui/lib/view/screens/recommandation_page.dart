import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 40.0, right: 30),
          child: Text(
            'EpidemicZone',
            style: TextStyle(
              color: Color(0xFF1273EB),
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              fontFamily: 'Mada',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recommandation',
                style: GoogleFonts.averiaLibre(
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) {
                return Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildNotification(
                            'Taux de propagation élevé',
                            'La situation est critique, veuillez prendre des mesures strictes de prévention.',
                            Colors.red,
                          ),
                          const SizedBox(height: 16.0),
                          _buildNotification(
                            'Taux de propagation élevé',
                            'Il est fortement recommandé de limiter les déplacements et les rassemblements.',
                            Colors.deepOrange,
                          ),
                          const SizedBox(height: 16.0),
                          _buildNotification(
                            'Taux de propagation moyen',
                            'Soyez prudent et respectez les mesures de précaution recommandées.',
                            Colors.orange,
                          ),
                          const SizedBox(height: 16.0),
                          _buildNotification(
                            'Taux de propagation faible',
                            'La situation est sous contrôle, mais restez vigilant et suivez les directives.',
                            Colors.yellow[400]!,
                          ),
                          const SizedBox(height: 16.0),
                          _buildNotification(
                            'Taux de propagation très faible',
                            'La situation est favorable, mais continuez à prendre les précautions nécessaires.',
                            Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotification(String title, String message, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.averiaLibre(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            message,
            style: GoogleFonts.averiaLibre(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeController extends GetxController {
  // Simulated values for demonstration purposes
  RxDouble propagationRate = 0.75.obs;

  String getRecommendation() {
    double rate = propagationRate.value;
    if (rate >= 0.7 && rate <= 1.0) {
      return 'La situation est critique, veuillez prendre des mesures strictes de prévention.';
    } else if (rate >= 0.5 && rate < 0.7) {
      return 'Il est fortement recommandé de limiter les déplacements et les rassemblements.';
    } else if (rate >= 0.4 && rate < 0.5) {
      return 'Soyez prudent et respectez les mesures de précaution recommandées.';
    } else if (rate >= 0.1 && rate < 0.4) {
      return 'La situation est sous contrôle, mais restez vigilant et suivez les directives.';
    } else if (rate >= 0 && rate < 0.1) {
      return 'La situation est favorable, mais continuez à prendre les précautions nécessaires.';
    } else {
      return 'Aucune recommandation disponible.';
    }
  }
}
