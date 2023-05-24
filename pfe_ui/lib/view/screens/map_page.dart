import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/inscription_controller.dart';
import 'package:pfe_ui/controller/map_controller.dart';
import 'package:pfe_ui/view/widgets/custom_loading_indicator.dart';

final mapController = Get.find<MapAppController>();
final userInfoController = Get.find<InscriptionController>();

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

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
          await mapController.populateMarkers();
          await mapController.getRecommandations();
        },
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}






/*
GestureDetector(
      onTap: () => showInformationPanel(context),
      child: Container(
        color: Colors.transparent,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 45.0, left: 18, right: 18),
              child: SearchBar(),
            ),
            Expanded(
              child: Center(
                  // Replace Placeholder with your content
                  ),
            ),
          ],
        ),
      ),
    );
*/