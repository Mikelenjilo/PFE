import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_ui/controller/update_info_controller.dart';

final UpdateInfoController updateInfoController =
    Get.find<UpdateInfoController>();

class UpdateInfo extends StatelessWidget {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _dateNaissanceController = TextEditingController();
  final _ancienMdpController = TextEditingController();
  final _nouveauMdpController = TextEditingController();
  final _confirmMdpController = TextEditingController();

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
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(100),
                            lastDate: DateTime.now(),
                          );

                          if (picked != null) {
                            _dateNaissanceController.text =
                                picked.toString().substring(0, 10);
                          }
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
                          ),
                        ),
                      ),
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
                        obscureText: true,
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
                        obscureText: true,
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
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Confirmer le nouveau mot de passe',
                        style: GoogleFonts.averiaLibre(
                          fontSize: 16.0,
                          color: Colors.grey[800]?.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        obscureText: true,
                        controller: _confirmMdpController,
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
        child: SizedBox(
          height: 50.0,
          child: ElevatedButton(
            onPressed: () async {
              await updateInfoController.setInfo(
                nom: _nomController.text,
                prenom: _prenomController.text,
                dateNaissance: _dateNaissanceController.text,
                ancienMotDePasse: _ancienMdpController.text,
                nouveauMotDePasse: _nouveauMdpController.text,
                confirmationNouveauMotDePasse: _confirmMdpController.text,
              );
            },
            child: const Text('Enregistrer les informations'),
          ),
        ),
      ),
    );
  }
}
