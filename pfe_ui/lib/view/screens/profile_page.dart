import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/core/services/shared_preferences_services.dart';
import 'package:pfe_ui/view/screens/connexion_page.dart';
import 'package:pfe_ui/view/screens/update_info_page.dart';
import 'package:pfe_ui/view/widgets/profile_info_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70.0),
              const Center(
                child: Text(
                  'EpidemicZone',
                  style: TextStyle(
                    color: Color(0xFF1273EB),
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    fontFamily: 'Mada',
                  ),
                ),
              ),
              const SizedBox(height: 90.0),
              ProfileInfoItem(
                label: 'Nom :',
                value: SharedPreferencesService.getLastName(),
              ),
              ProfileInfoItem(
                label: 'Prénom :',
                value: SharedPreferencesService.getFirstName(),
              ),
              ProfileInfoItem(
                label: 'Date de naissance :',
                value: SharedPreferencesService.getDateOfBirth(),
              ),
              ProfileInfoItem(
                label: 'Genre: ',
                value: SharedPreferencesService.getGender(),
              ),
              ProfileInfoItem(
                label: 'Email :',
                value: SharedPreferencesService.getEmail(),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => UpdateInfo());
                  },
                  child: const Text('Modifier les informations'),
                ),
              ),
              const SizedBox(height: 42.0),
              TextButton(
                onPressed: () {
                  SharedPreferencesService.clear();
                  Get.off(() => const Connexion());
                },
                child: const Text(
                  'Déconnexion',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 18.0,
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
