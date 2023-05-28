import 'package:get/get.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/main.dart';
import 'package:pfe_ui/src/models/user.dart';

class UserController extends GetxController {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    if (_user != user) {
      _user = user;
      update();
    }
  }

  void rebuild() {
    update();
  }

  Future<void> createUserUsingId() async {
    int userId = prefs!.getInt('id')!;

    User user = await DjangoHelper.getUserById(userId);

    setUser(user);
  }

  void clear(User? user) {
    if (_user == user) {
      _user = null;
      user = null;
      update();
    }
  }
}
