import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/core/utils/ui_constants.dart';
import 'package:pfe_ui/controller/inscription_controller.dart';
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
                    text: 'Email',
                    hintText: 'Entrez votre adresse email',
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 13.0),
                  CustomTextField(
                    controller: passwordController,
                    text: 'Mot de passe',
                    hintText: 'Mot de passe',
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 13.0),
                  CustomTextField(
                    controller: passwordConfirmController,
                    text: 'Confirmer mot de passe',
                    hintText: 'Mot de passe',
                    obscureText: true,
                    icon: Icons.lock,
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
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 13.0),
                  CustomTextField(
                    controller: firstNameController,
                    text: 'Prénom',
                    hintText: 'Entrez votre prénom',
                    icon: Icons.person,
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
                        icon: Icons.calendar_today_outlined,
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
  static const List<String> options = ['Oui', 'Non'];

  InscriptionPage3({super.key});
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
          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Est-ce que vous êtes malade du COVID-19 ?',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                  ),
                ),
                Obx(
                  () => SizedBox(
                    height: 50, // Specify a specific height here
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: ListTile(
                            title: const Text('Oui'),
                            leading: Radio<String>(
                              value: 'Oui',
                              groupValue: controller.selectedValue.value,
                              onChanged: (value) {
                                controller.selectedValue.value = value!;
                                print(controller.selectedValue.value);
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: ListTile(
                            title: const Text('Non'),
                            leading: Radio<String>(
                              value: 'Non',
                              groupValue: controller.selectedValue.value,
                              onChanged: (value) {
                                controller.selectedValue.value = value!;
                                print(controller.selectedValue.value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Si vous avez une maladie chronique, veuillez la sélectionner :',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                  ),
                ),
                Obx(
                  () => Column(
                    children: [
                      CheckboxListTile(
                        title: Text('Diabète'),
                        value: controller.diabete.value,
                        controlAffinity: ListTileControlAffinity.platform,
                        onChanged: (bool? value) {
                          controller.diabete.value = value!;
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Cancer'),
                        value: controller.cancer.value,
                        controlAffinity: ListTileControlAffinity.platform,
                        onChanged: (bool? value) {
                          controller.cancer.value = value!;
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Maladies Cardiaques'),
                        value: controller.maladiesCardiaques.value,
                        controlAffinity: ListTileControlAffinity.platform,
                        onChanged: (bool? value) {
                          controller.maladiesCardiaques.value = value!;
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Maladies Rénales'),
                        value: controller.maladiesRenales.value,
                        controlAffinity: ListTileControlAffinity.platform,
                        onChanged: (bool? value) {
                          controller.maladiesRenales.value = value!;
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Maladie Respiratoire'),
                        value: controller.maladieRespiratoire.value,
                        controlAffinity: ListTileControlAffinity.platform,
                        onChanged: (bool? value) {
                          controller.maladieRespiratoire.value = value!;
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: 250,
            child: ElevatedButton(
              onPressed: () {},
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
    );
  }
}
