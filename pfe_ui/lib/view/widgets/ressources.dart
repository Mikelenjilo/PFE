import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF88B9F5),
            Color(0xFF4D78AD),
            Color(0xFF335D92),
            Color(0xFF244771),
            // Color(0xFF1F3A5C),
            //Color(0xFF1D2126),
          ],
        ),
      ),
    );
  }
}

//liste des pages
enum Pages {
  HomePage1,
  HomePage2,
  HomePage3,
}

class BottomWidgets extends StatelessWidget {
  final Pages currentPage;

  const BottomWidgets({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    double opacity1 = 0.5;
    double opacity2 = 0.5;
    double opacity3 = 0.5;

    switch (currentPage) {
      case Pages.HomePage1:
        opacity1 = 1.0;
        break;
      case Pages.HomePage2:
        opacity2 = 1.0;
        break;
      case Pages.HomePage3:
        opacity3 = 1.0;
        break;
    }

    return Stack(
      children: [
        Positioned(
          top: 745,
          left: 150,
          child: Opacity(
            opacity: opacity1,
            child: Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
            ),
          ),
        ),
        Positioned(
          top: 745,
          left: 180,
          child: Opacity(
            opacity: opacity2,
            child: Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
            ),
          ),
        ),
        Positioned(
          top: 745,
          left: 210,
          child: Opacity(
            opacity: opacity3,
            child: Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomIcon extends StatelessWidget {
  final double top;
  final double left;

  const CustomIcon({super.key, required this.top, required this.left});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.arrow_forward,
      color: Colors.white,
    );
  }
}

Widget clipRRect(String imagePath, double top, double left) {
  return Positioned(
    top: top,
    left: left,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Image.asset(
        imagePath,
        width: 99,
        height: 99,
        fit: BoxFit.cover,
      ),
    ),
  );
}
