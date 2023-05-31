import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/main.dart';
import 'package:pfe_ui/src/models/user.dart';

class UserController extends GetxController {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    update();
  }

  void rebuild() {
    update();
  }

  void updateUserLocation(LatLng location) {
    user!.location = location;
    update();
  }

  // Future<void> createUserUsingId() async {
  //   int userId = prefs!.getInt('id')!;

  //   User? user = await DjangoHelper.getUserById(userId);

  //   if (user != null) {
  //     setUser(user);
  //   } else {
  //     return;
  //   }
  // }

  void clear() {
    _user = null;
    update();
  }
}
