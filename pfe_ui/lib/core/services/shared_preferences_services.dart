import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserId(int userId) async =>
      await _preferences.setInt('userId', userId);

  static Future setFirstName(String firstName) async =>
      await _preferences.setString('firstName', firstName);

  static Future setLastName(String lastName) async =>
      await _preferences.setString('lastName', lastName);

  static Future setDateOfBirth(String dateOfBirth) async =>
      await _preferences.setString('dateOfBirth', dateOfBirth);

  static Future setEmail(String email) async =>
      await _preferences.setString('email', email);

  static Future setCronicDiseases(List<String> cronicDiseases) async =>
      await _preferences.setStringList('cronicDiseases', cronicDiseases);

  static Future setGender(String gender) async =>
      await _preferences.setString('gender', gender);

  static Future setOnline(bool online) async =>
      await _preferences.setBool('online', online);

  static Future setClusterId(int clusterId) async =>
      await _preferences.setInt('clusterId', clusterId);

  /////////////////////////////////////////////////////////////////////////////////////////////////

  static int getUserId() => _preferences.getInt('userId') ?? 0;

  static String getFirstName() => _preferences.getString('firstName') ?? '';

  static String getLastName() => _preferences.getString('lastName') ?? '';

  static String getDateOfBirth() => _preferences.getString('dateOfBirth') ?? '';

  static String getEmail() => _preferences.getString('email') ?? '';

  static List<String>? getCronicDiseases() =>
      _preferences.getStringList('cronicDiseases');

  static String getGender() => _preferences.getString('gender') ?? '';

  static int getClusterId() => _preferences.getInt('clusterId') ?? 0;

  static void clear() {
    _preferences.clear();
  }
}
