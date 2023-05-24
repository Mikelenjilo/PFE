import 'package:pfe_ui/src/models/user.dart';

abstract class IAuth {
  Future<User?> registerInWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String gender,
    String? dateOfContamination,
  });

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<bool> signOut(User user);
}
