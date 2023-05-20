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

  static Future setPassword(String password) async =>
      await _preferences.setString('password', password);

  static Future setCronicDisease1(String cronicDisease1) async =>
      await _preferences.setString('cronicDisease1', cronicDisease1);

  static Future setCronicDisease2(String cronicDisease2) async =>
      await _preferences.setString('cronicDisease2', cronicDisease2);

  static Future setCronicDisease3(String cronicDisease3) async =>
      await _preferences.setString('cronicDisease3', cronicDisease3);

  static Future setCronicDisease4(String cronicDisease4) async =>
      await _preferences.setString('cronicDisease4', cronicDisease4);

  static Future setCronicDisease5(String cronicDisease5) async =>
      await _preferences.setString('cronicDisease5', cronicDisease5);

  static Future setGender(String gender) async =>
      await _preferences.setString('gender', gender);

  static Future setLatitude(double latitude) async =>
      await _preferences.setDouble('latitude', latitude);

  static Future setLongitude(double longitude) async =>
      await _preferences.setDouble('longitude', longitude);

  static Future setIfTransmit(bool ifTransmit) async =>
      await _preferences.setBool('ifTransmit', ifTransmit);

  static Future setDateOfContamination(String dateOfContamination) async =>
      await _preferences.setString('dateOfContamination', dateOfContamination);

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

  static String getPassword() => _preferences.getString('password') ?? '';

  static String getCronicDisease1() =>
      _preferences.getString('cronicDisease1') ?? '';

  static String getCronicDisease2() =>
      _preferences.getString('cronicDisease2') ?? '';

  static String getCronicDisease3() =>
      _preferences.getString('cronicDisease3') ?? '';

  static String getCronicDisease4() =>
      _preferences.getString('cronicDisease4') ?? '';

  static String getCronicDisease5() =>
      _preferences.getString('cronicDisease5') ?? '';

  static String getGender() => _preferences.getString('gender') ?? '';

  static double getLatitude() => _preferences.getDouble('latitude') ?? 0.0;

  static double getLongitude() => _preferences.getDouble('longitude') ?? 0.0;

  static bool getIfTransmit() => _preferences.getBool('ifTransmit') ?? false;

  static String getDateOfContamination() =>
      _preferences.getString('dateOfContamination') ?? '';

  static bool getOnline() => _preferences.getBool('online') ?? false;

  static int getClusterId() => _preferences.getInt('clusterId') ?? 0;
}
