import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static final String spUserID = "userId";
  static final String spToken = "token";
  static final String spTheme = "theme";
  static SharedPreferences sp;

  static Future<void> init() async {
    sp ??= await SharedPreferences.getInstance();
  }

  static bool get hasToken => sp.getString(spToken) != null;

  static String get token => sp.getString(spToken);

  static Future<void> setToken(String value) async => await sp.setString(spToken, value);

  static Future<void> removeToken() async => await sp.remove(spToken);

  static bool get hasUser => sp.getString(spUserID) != null;

  static String get userId => sp.getString(spUserID);

  static Future<bool> setUser(String value) async => await sp.setString(spUserID, value);

  static Future<void> removeUser() async => await sp.remove(spUserID);

  static String get theme => sp.getString(spTheme);

  static Future<void> setTheme(String value) async => await sp.setString(spTheme, value);
}
