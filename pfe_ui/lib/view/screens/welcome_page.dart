import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_ui/view/screens/connexion_page.dart';
import 'package:pfe_ui/view/screens/inscription_page.dart';
import 'package:pfe_ui/view/widgets/ressources.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        HomePage1(),
        HomePage2(),
        HomePage3(),
      ],
    );
  }
}

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientContainer(),
          Positioned(
            top: 5,
            right: -15,
            child: Container(
              width: 428,
              height: 315,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(99),
                  bottomRight: Radius.circular(99),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/image1.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 376,
            left: 15,
            child: Container(
              width: 351,
              height: 76,
              child: Center(
                child: Opacity(
                  opacity: 1,
                  child: Text(
                    'EpidemicZone',
                    style: GoogleFonts.marcellus(
                      color: const Color(0xFFD9D9D9),
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 460,
            left: 55,
            child: Container(
              width: 272,
              height: 112,
              child: Center(
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 1,
                      child: Text(
                        'Notre application peut vous \n aider à prendre les\n précautions nécessaires pour\n prévenir la propagation d\'une \n épidémie.',
                        style: GoogleFonts.karla(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 633,
            left: 150,
            child: Center(
              child: Container(
                width: 81,
                height: 41,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const BottomWidgets(currentPage: Pages.HomePage1),
        ],
      ),
    );
  }
}

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const GradientContainer(),
        const Positioned(
          top: 50,
          left: 35,
          width: 316,
          height: 64,
          child: Text(
            'Fonctionnalités:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontFamily: 'Jost',
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const Positioned(
          top: 120,
          left: 10,
          child: CustomIcon(top: 120, left: 10),
        ),
        const Positioned(
          top: 117,
          left: 33,
          width: 275,
          height: 24,
          child: Text(
            'Des mises à jour en temps réel.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Averia Libre',
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const Positioned(
          top: 161,
          left: 10,
          child: CustomIcon(top: 161, left: 10),
        ),
        const Positioned(
          top: 159,
          left: 33,
          width: 207,
          height: 98,
          child: Text(
            'Détecter les zones les plus vulnérables à la propagation d\'une épidémie.',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Averia Libre',
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        ),
        clipRRect('assets/images/image2.jpeg', 170, 239),
        const Positioned(
          top: 301,
          left: 10,
          child: CustomIcon(top: 301, left: 10),
        ),
        const Positioned(
          top: 299,
          left: 33,
          width: 224,
          height: 68,
          child: Text(
            'Des notifications  et des recommendations  pour l\'utilisateur.',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Averia Libre',
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        ),
        clipRRect('assets/images/image3.jpg', 302, 251),
        const Positioned(
          top: 415,
          left: 10,
          child: CustomIcon(top: 415, left: 10),
        ),
        const Positioned(
          top: 413,
          left: 33,
          width: 262,
          height: 67,
          child: Text(
            'Aider les utilisateurs à protéger leur vie et celle des autres.',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Averia Libre',
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 505,
          left: 90,
          width: 200,
          height: 170,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: Image.asset(
              'assets/images/image4.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const BottomWidgets(currentPage: Pages.HomePage2),
      ],
    ));
  }
}

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientContainer(),
          const Positioned(
            top: 70,
            left: 60,
            width: 300,
            height: 66,
            child: Text(
              'EpidemicZone',
              style: TextStyle(
                color: Colors.white,
                fontSize: 46,
                fontFamily: 'Mada',
              ),
            ),
          ),
          const Positioned(
            top: 212,
            left: 48,
            width: 305,
            height: 163,
            child: Text(
              'Vous pouvez profiter de toutes les fonctionnalités précédentes en ouvrant un compte ou en vous connectant.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Averia Libre',
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Positioned(
            top: 450,
            left: 45,
            right: 45,
            child: ElevatedButton(
              onPressed: () {
                // action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InscriptionPage1()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffd9d9d9),
                padding:
                    const EdgeInsets.symmetric(horizontal: 19, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Créer',
                style: TextStyle(
                  color: Color(0xff1273eb),
                  fontSize: 26,
                  fontFamily: 'Averia Libre',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Positioned(
            top: 550,
            left: 45,
            right: 45,
            child: ElevatedButton(
              onPressed: () {
                // action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Connexion()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffd9d9d9),
                padding:
                    const EdgeInsets.symmetric(horizontal: 19, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Connexion',
                style: TextStyle(
                  color: Color(0xff1273eb),
                  fontSize: 26,
                  fontFamily: 'Averia Libre',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const BottomWidgets(currentPage: Pages.HomePage3),
        ],
      ),
    );
  }
}
