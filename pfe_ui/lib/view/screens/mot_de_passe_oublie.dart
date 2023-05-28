import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/mot_de_passe_oublie_controller.dart';
import 'package:pfe_ui/core/utils/ui_constants.dart';
import 'package:pfe_ui/view/widgets/custom_text_field.dart';

final MotDePasseOublieController motDePasseOublieController =
    Get.find<MotDePasseOublieController>();

class MotDePasseOublie extends StatelessWidget {
  const MotDePasseOublie({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordConfirmController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: kAppBarWelcomePage,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Center(
                child: Text(
                  'EpidemicZone',
                  style: kTextStyleTitle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 60.0, left: 30.0, right: 30.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Center(
                      child: Text(
                        'Rénitialiser votre mot de passe',
                        style: kTextStyleEtape.copyWith(fontSize: 25.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 13.0),
                  CustomTextField(
                    controller: emailController,
                    text: 'Email',
                    hintText: 'Entrez votre adresse email',
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 13.0),
                  CustomTextField(
                    controller: passwordController,
                    text: 'Nouveau mot de passe',
                    hintText: 'Nouveau mot de passe',
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 13.0),
                  CustomTextField(
                    controller: passwordConfirmController,
                    text: 'Confirmer le nouveau mot de passe',
                    hintText: 'Nouveau mot de passe',
                    obscureText: true,
                    icon: Icons.lock,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 30.0, left: 20.0, right: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  await motDePasseOublieController.setInfo(
                    email: emailController.text,
                    password: passwordController.text,
                    passwordConfirm: passwordConfirmController.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1273EB),
                  minimumSize: const Size(double.infinity, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Enregistrer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
