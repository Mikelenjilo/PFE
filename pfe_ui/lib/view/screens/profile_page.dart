import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/main.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/view/screens/modifier_page.dart';
import 'package:pfe_ui/view/screens/welcome_page.dart';
import 'package:pfe_ui/view/widgets/profile_page_info.dart';

final User? user = Get.find<UserController>().user;
final userController = Get.find<UserController>();

class ProfilePage2 extends StatelessWidget {
  const ProfilePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          prefs!.clear();
          userController.clear();
          Get.offAll(const HomePage());
        },
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
              height: MediaQuery.of(context).size.height * 0.28,
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
                  GetBuilder<UserController>(builder: (context) {
                    return Text(
                      '${user?.lastName} ${user?.firstName}',
                      style: const TextStyle(
                        fontSize: 38,
                        color: Colors.white,
                      ),
                    );
                  }),
                  GetBuilder<UserController>(builder: (context) {
                    return Text(
                      '#${user?.userId}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              child: GetBuilder<UserController>(
                builder: (context) {
                  return Column(
                    children: [
                      ProfilePageInfo(
                        text: user!.lastName,
                        icon: Icons.person,
                      ),
                      ProfilePageInfo(
                        text: user!.firstName,
                        icon: Icons.person,
                      ),
                      ProfilePageInfo(
                        text: user!.dateOfBirth,
                        icon: Icons.date_range,
                      ),
                      ProfilePageInfo(
                        text: user!.gender,
                        icon: FontAwesomeIcons.venusMars,
                      ),
                      ProfilePageInfo(
                        text: user!.email,
                        icon: Icons.email,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
