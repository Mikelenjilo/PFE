import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/connexion_controller.dart';
import 'package:pfe_ui/core/utils/ui_constants.dart';
import 'package:pfe_ui/view/screens/app_page.dart';
import 'package:pfe_ui/view/widgets/custom_text_field.dart';

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
                      top: 20.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 13.0),
                        CustomTextField(
                          text: 'Email',
                          hintText: 'Entrez votre adresse email',
                          controller: emailController,
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 13.0),
                        CustomTextField(
                          text: 'Mot de passe',
                          hintText: 'Entrez votre mot de passe',
                          controller: passwordController,
                          obscureText: true,
                          icon: Icons.lock,
                        ),
                        // TextFormField(
                        //   keyboardType: TextInputType.emailAddress,
                        //   controller: emailController,
                        //   decoration: const InputDecoration(
                        //     hintText: "Entrez votre adresse email",
                        //   ),
                        // ),
                        // const SizedBox(height: 13.0),
                        // TextFormField(
                        //   obscureText: true,
                        //   controller: passwordController,
                        //   decoration: const InputDecoration(
                        //     hintText: "Mot de passe",
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: () async {
                                final bool isSignedIn =
                                    await connexionController.setSignInInfo(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                if (isSignedIn) {
                                  Get.to(() => const AppPage());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: const Text('Se connecter'),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                color: Colors.black,
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
