import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/connexion_controller.dart';
import 'package:pfe_ui/core/utils/ui_constants.dart';
import 'package:pfe_ui/view/screens/app_page.dart';
import 'package:pfe_ui/view/screens/inscription_page.dart';

final connexionController = Get.find<ConnexionController>();

class Connexion extends StatelessWidget {
  const Connexion({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: kAppBarWelcomePage,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                'EpidemicZone',
                style: kTextStyleTitle,
              ),
            ),
            const SizedBox(height: 20.0),
            Icon(
              Icons.account_circle_outlined,
              color: Colors.grey[900],
              size: 150,
            ),
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 30.0, right: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 13.0),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: "Entrez votre adresse email",
                          ),
                        ),
                        const SizedBox(height: 13.0),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            hintText: "Mot de passe",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              connexionController
                                  .setEmail(emailController.text);
                              connexionController
                                  .setPassword(passwordController.text);
                              await connexionController.signIn();

                              Get.to(() => const AppPage());
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            child: const Text('Connexion'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const InscriptionPage1());
                            },
                            child: const Text(
                              'Vous n\'avez pas de compte ?',
                              style: TextStyle(
                                color: Colors.blue,
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
          ],
        ),
      ),
    );
  }
}
