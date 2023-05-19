import 'package:pfe_ui/src/models/user.dart';

abstract class IAuth {
  Future<bool> registerInWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String gender,
    DateTime? dateOfContamination,
  });

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<bool> signOut(User user);
}
