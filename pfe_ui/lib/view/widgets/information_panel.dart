import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationPanelController extends GetxController {
  //TODO  data
  var totalPeople = ''.obs;
  var infectedCount = ''.obs;
  var transmissionRate = ''.obs;
  var explanationMessage = ''.obs;

  void updateInformation({
    required String totalPeople,
    required String infectedCount,
    required String transmissionRate,
    required String explanationMessage,
  }) {
    this.totalPeople.value = totalPeople;
    this.infectedCount.value = infectedCount;
    this.transmissionRate.value = transmissionRate;
    this.explanationMessage.value = explanationMessage;
  }
}

void showInformationPanel(BuildContext context) {
  final InformationPanelController _controller =
      Get.put(InformationPanelController());

  Get.bottomSheet(
    Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Panneau d\'information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 50),
            //  informations
            Obx(() => Text(
                  'Nombre total de personnes: ${_controller.totalPeople.value}',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                )),
            const SizedBox(height: 10),
            Obx(() => Text(
                  'Nombre de malades: ${_controller.infectedCount.value}',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                )),
            const SizedBox(height: 10),
            Obx(() => Text(
                  'Taux de propagation: ${_controller.transmissionRate.value}',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                )),
            const SizedBox(height: 10),
            Obx(() => Text(
                  'msgg....... ${_controller.explanationMessage.value}',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                )),
          ],
        ),
      ),
    ),
  );
}
