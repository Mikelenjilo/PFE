import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/user_info_controller.dart';
import 'package:pfe_ui/view/screens/update_info_page.dart';
import 'package:pfe_ui/view/widgets/profile_info_item.dart';

final userInfoController = Get.find<UserInfoController>();

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              value: userInfoController.firstName!,
            ),
            ProfileInfoItem(
              label: 'Prénom :',
              value: userInfoController.lastName!,
            ),
            ProfileInfoItem(
              label: 'Date de naissance :',
              value: userInfoController.dateOfBirth.toString().split(' ')[0],
            ),
            ProfileInfoItem(
              label: 'Genre: ',
              value: userInfoController.gender!,
            ),
            ProfileInfoItem(
              label: 'Email :',
              value: userInfoController.email!,
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
            const Text(
              'Déconnexion',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(value),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
