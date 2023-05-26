import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pfe_ui/controller/app_page_controller.dart';
import 'package:pfe_ui/view/screens/map_page.dart';
import 'package:pfe_ui/view/screens/profile_page_2.dart';
import 'package:pfe_ui/view/screens/recommandation_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppPageController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.currentIndex,
            children: [
              MapPage(),
              RecommendationsPage(),
              ProfilePage2(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: controller.changePage,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Recommendations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
