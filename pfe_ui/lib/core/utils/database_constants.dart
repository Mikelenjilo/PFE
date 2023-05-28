abstract class DjangoConstants {
  static const String baseUrl = 'http://192.168.1.43:8000/';
  // GET urls
  static const String getUsersUrl = '${baseUrl}users/';
  static const String getUserByEmailUrl = '${baseUrl}get_user_by_email/';
  static const String getClustersUrl = '${baseUrl}clusters/';

  // POST urls
  static const String postCreateUserUrl = '${baseUrl}create_user/';

  // PATCH urls
  static const String patchLoginUserUrl = '${baseUrl}login_user/';
  static const String patchLogoutUserUrl = '${baseUrl}logout_user/';
  static const String patchUpdateUserPasswordUrl =
      '${baseUrl}update_user_password/';
  static const String patchUpdateUserLatitudeAndLongitudeUrl =
      '${baseUrl}update_user_latitude_and_longitude/';
  static const String patchUpdateUserCronicDiseasesUrl =
      '${baseUrl}update_user_cronic_diseases/';
  static const String patchAssignUserToClosestClusterUrl =
      '${baseUrl}assign_user_to_cluster/';
  static const String patchUpdateUserInfosUrl = '${baseUrl}update_user_infos/';

  // DELETE urls
  static const String deleteUserUrl = '${baseUrl}users/';
  static const String deleteClusterUrl = '${baseUrl}clusters/';
}
