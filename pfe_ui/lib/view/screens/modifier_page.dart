import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateInfo extends StatelessWidget {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _dateNaissanceController = TextEditingController();
  final _ancienMdpController = TextEditingController();
  final _nouveauMdpController = TextEditingController();

  UpdateInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: const Color(0xFF1273EB),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<UpdateInfoController>(
        init: UpdateInfoController(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12.0),
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
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nom',
                        style: GoogleFonts.averiaLibre(
                          fontSize: 16.0,
                          color: Colors.grey[800]?.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        controller: _nomController,
                        style: GoogleFonts.averiaLibre(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Entrez votre nom',
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        // onChanged: (value) => controller.nom = value,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Prénom',
                        style: GoogleFonts.averiaLibre(
                          fontSize: 16.0,
                          color: Colors.grey[800]?.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        controller: _prenomController,
                        style: GoogleFonts.averiaLibre(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Entrez votre prénom',
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        // onChanged: (value) => controller.prenom = value,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Date de naissance',
                        style: GoogleFonts.averiaLibre(
                          fontSize: 16.0,
                          color: Colors.grey[800]?.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      GestureDetector(
                        onTap: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(100),
                            lastDate: DateTime.now(),
                          );
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _dateNaissanceController,
                            style: GoogleFonts.averiaLibre(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'aaaa-mm-jj',
                              contentPadding: const EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            // onChanged: (value) => controller.dateNaissance = value,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const SizedBox(height: 10.0),
                      Text(
                        'Ancien mot de passe',
                        style: GoogleFonts.averiaLibre(
                          fontSize: 16.0,
                          color: Colors.grey[800]?.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        controller: _ancienMdpController,
                        style: GoogleFonts.averiaLibre(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Entrez votre ancien mot de passe',
                          contentPadding: const EdgeInsets.all(10.0),
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
// onChanged: (value) => controller.ancienMotDePasse = value,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Nouveau mot de passe',
                        style: GoogleFonts.averiaLibre(
                          fontSize: 16.0,
                          color: Colors.grey[800]?.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        controller: _nouveauMdpController,
                        style: GoogleFonts.averiaLibre(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Entrez votre nouveau mot de passe',
                          contentPadding: const EdgeInsets.all(10.0),
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
// onChanged: (value) => controller.nouveauMotDePasse = value,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: ElevatedButton(
          onPressed: () {
// Perform update logic here
          },
          child: const Text('Enregistrer les informations'),
        ),
      ),
    );
  }
}

class UpdateInfoController extends GetxController {
  RxString nom = ''.obs;
  RxString prenom = ''.obs;
  RxString dateNaissance = ''.obs;
  RxString numeroTelephone = ''.obs;
  RxString ancienMotDePasse = ''.obs;
  RxString nouveauMotDePasse = ''.obs;
}
