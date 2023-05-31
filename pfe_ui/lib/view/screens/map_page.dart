import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/map_controller.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/view/widgets/custom_loading_indicator.dart';

User user = Get.find<UserController>().user!;

class MapPage extends StatelessWidget {
  final locationTextFieldController = TextEditingController();
  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MapAppController>(
      init: MapAppController(),
      builder: (mapController) {
        return Scaffold(
          body: Stack(
            children: [
              FlutterMap(
                mapController: mapController.mapControllerFlutterMap,
                options: MapOptions(
                  center: mapController.center.value,
                  zoom: mapController.zoom.value,
                  onPositionChanged: (position, hasGesture) {
                    mapController.updateZoom(position.zoom!);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
              ElevatedButton(
                onPressed: () async {
                  // print('user id: ${user.userId}');
                  // print('first name : ${user.firstName}');
                  // print('last name : ${user.lastName}');
                  // print('date of birth: ${user.dateOfBirth}');
                  // print('email : ${user.email}');
                  // print('cronic diseases: ${user.cronicDiseases}');
                  // print('gender: ${user.gender}');
                  // print('cluster id: ${user.clusterId}');
                  // print('user location: ${user.location}');

                  // final RecommandationController recommandationController =
                  //     Get.find<RecommandationController>();

                  // for (var recommandation
                  //     in recommandationController.recommandations) {
                  //   print('recommandation : ${recommandation['recommendation']}');
                  // }
                  // final targetCenter = LatLng(35.611598, -0.624581);
                  // final commune = await placemarkFromCoordinates(
                  //     targetCenter.latitude, targetCenter.longitude);
                  // print(commune.first.locality);
                  // mapController.mapControllerFlutterMap.move(targetCenter, 11);
                },
                child: const Text('test button'),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: locationTextFieldController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Je veux me déplacer à ...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      onSubmitted: (value) {
                        mapController.searchLocation(value);
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: mapController.isLoading.value,
                child: const CustomLoadingIndicator(
                    text:
                        'Entrain de collecter les données de l\'utilisateur...'),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await mapController.getLocation();
              await mapController.populateMarkers();
              await mapController.getRecommandations();
            },
            child: const Icon(Icons.gps_fixed),
          ),
        );
      },
    );
  }
}
