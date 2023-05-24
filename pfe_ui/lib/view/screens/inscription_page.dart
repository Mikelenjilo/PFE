import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/core/utils/ui_constants.dart';
import 'package:pfe_ui/controller/inscription_controller.dart';
import 'package:pfe_ui/view/screens/app_page.dart';
import 'package:pfe_ui/view/widgets/custom_drop_downbuttom_field.dart';
import 'package:pfe_ui/view/widgets/custom_text_field.dart';

final controller = Get.put(InscriptionController());

class InscriptionPage1 extends StatelessWidget {
  const InscriptionPage1({super.key});

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
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  'Etape 1/3',
                  style: kTextStyleEtape,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 13.0),
                  CustomTextField(
                    controller: emailController,
                    text: 'email',
                    hintText: 'Entrez votre adresse email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 13.0),
                  CustomTextField(
                    controller: passwordController,
                    text: 'Mot de passe',
                    hintText: 'Mot de passe',
                    obscureText: true,
                  ),
                  const SizedBox(height: 13.0),
                  CustomTextField(
                    controller: passwordConfirmController,
                    text: 'Confirmer mot de passe',
                    hintText: 'Mot de passe',
                    obscureText: true,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 120, bottom: 10.0, left: 20.0, right: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  final bool isInfosSet1 = await controller.setInfoPage1(
                    email: emailController.text,
                    password: passwordController.text,
                    passwordConfrimation: passwordConfirmController.text,
                  );

                  if (isInfosSet1) {
                    Get.to(() => const InscriptionPage2());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1273EB),
                  minimumSize: const Size(double.infinity, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Suivant'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InscriptionPage2 extends StatelessWidget {
  const InscriptionPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final dateOfBirthController = TextEditingController();
    String gender = '';
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
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  'Etape 2/3',
                  style: kTextStyleEtape,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: lastNameController,
                    text: 'Nom',
                    hintText: 'Entrez votre nom',
                  ),
                  const SizedBox(height: 13.0),
                  CustomTextField(
                    controller: firstNameController,
                    text: 'Prénom',
                    hintText: 'Entrez votre prénom',
                  ),
                  const SizedBox(height: 13.0),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(100),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        dateOfBirthController.text =
                            picked.toString().substring(0, 10);
                      }
                    },
                    child: AbsorbPointer(
                      child: CustomTextField(
                        controller: dateOfBirthController,
                        text: 'Date de naissance',
                        hintText: 'aaaa-mm-jj',
                      ),
                    ),
                  ),
                  const SizedBox(height: 13.0),
                  CustomDropDownButtomField(
                    genderLogic: (value) {
                      gender = value!;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 82, bottom: 10.0, left: 20.0, right: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  final bool isInfosSet2 = controller.setInfoPage2(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    dateOfBirth: dateOfBirthController.text,
                    gender: gender,
                  );

                  if (isInfosSet2) {
                    Get.to(() => InscriptionPage3());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1273EB),
                  minimumSize: const Size(double.infinity, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Suivant'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InscriptionPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: kAppBarWelcomePage,
      body: Column(
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
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                'Etape 3/3',
                style: kTextStyleEtape,
              ),
            ),
          ),
          const SizedBox(height: 100.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Est-ce que vous êtes malade du COVID-19 ?',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 60.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await controller.setInfoPage3(
                            dateOfContamination:
                                DateTime.now().toString().split(' ')[0]);
                        Get.to(() => const AppPage());
                      },
                      child: Text('Oui',
                          style: kTextStyleTitle.copyWith(
                              color: Colors.white, fontSize: 30.0)),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        controller.setInfoPage3();
                        Get.to(() => const AppPage());
                      },
                      child: Text('Non',
                          style: kTextStyleTitle.copyWith(
                              color: Colors.white, fontSize: 30.0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
