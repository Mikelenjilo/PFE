import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_ui/features/auth/domain/entities/user.dart';

final kTextStyleTitle = GoogleFonts.mada(
  color: const Color(0xFF1273EB),
  fontSize: 46,
);

final kTextStyleEtape = GoogleFonts.averiaLibre(
  fontSize: 30.0,
  color: Colors.black,
);

final kTextStyleLabel = GoogleFonts.averiaLibre(
  fontSize: 16.0,
  color: Colors.grey[800]?.withOpacity(0.5),
);

final kTextStyleTextField = GoogleFonts.averiaLibre(
  fontSize: 15.0,
  color: Colors.black,
);

final kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.grey[200],
  contentPadding: const EdgeInsets.all(10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide.none,
  ),
);

final kAppBarWelcomePage = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back_ios_rounded),
    color: const Color(0xFF1273EB),
    onPressed: () => Get.back(),
  ),
);

const List<Gender> genderOptions = [Gender.homme, Gender.femme];
