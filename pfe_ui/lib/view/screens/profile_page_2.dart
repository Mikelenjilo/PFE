import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/core/services/shared_preferences_services.dart';
import 'package:pfe_ui/view/screens/modifier_page.dart';

class ProfilePage2 extends StatelessWidget {
  const ProfilePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.to(() => UpdateInfo());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    '${SharedPreferencesService.getLastName()} ${SharedPreferencesService.getFirstName()}',
                    style: const TextStyle(
                      fontSize: 38,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    SharedPreferencesService.getUserId().toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                children: [
                  ProfilePageInfo(
                    text: SharedPreferencesService.getLastName(),
                    icon: Icons.person,
                  ),
                  ProfilePageInfo(
                    text: SharedPreferencesService.getFirstName(),
                    icon: Icons.person,
                  ),
                  ProfilePageInfo(
                    text: SharedPreferencesService.getDateOfBirth(),
                    icon: Icons.date_range,
                  ),
                  ProfilePageInfo(
                    text: SharedPreferencesService.getGender(),
                    icon: FontAwesomeIcons.venusMars,
                  ),
                  ProfilePageInfo(
                    text: SharedPreferencesService.getEmail(),
                    icon: Icons.email,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePageInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  const ProfilePageInfo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.2),
                radius: 30.0,
                child: Icon(
                  icon,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 10.0),
              Text(text, style: const TextStyle(fontSize: 15.0)),
            ],
          ),
        ),
      ),
    );
  }
}
