import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/map_controller.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/view/widgets/custom_loading_indicator.dart';

MapAppController mapController = Get.find<MapAppController>();
User user = Get.find<UserController>().user!;

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MapAppController>(
        builder: (controller) => Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: mapController.center,
                zoom: mapController.zoom,
                interactiveFlags: InteractiveFlag.drag,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    if (mapController.userLocationMarker != null)
                      mapController.userLocationMarker!,
                    if (mapController.markers.isNotEmpty)
                      ...mapController.markers,
                  ],
                ),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     print('user id: ${user.userId}');
            //     print('first name : ${user.firstName}');
            //     print('last name : ${user.lastName}');
            //     print('date of birth: ${user.dateOfBirth}');
            //     print('email : ${user.email}');
            //     print('cronic diseases: ${user.cronicDiseases}');
            //     print('gender: ${user.gender}');
            //     print('cluster id: ${user.clusterId}');
            //     print('user location: ${user.location}');

            //     // final RecommandationController recommandationController =
            //     //     Get.find<RecommandationController>();

            //     // for (var recommandation
            //     //     in recommandationController.recommandations) {
            //     //   print('recommandation : ${recommandation['recommendation']}');
            //     // }
            //   },
            //   child: Text('test button'),
            // ),
            Visibility(
              visible: mapController.isLoading,
              child: const CustomLoadingIndicator(
                  text:
                      'Entrain de collecter les données de l\'utilisateur...'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await mapController.getLocation();
          await mapController.getRecommandations();
          await mapController.populateMarkersWithUsersLocation();
        },
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
