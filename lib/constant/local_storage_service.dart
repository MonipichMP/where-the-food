import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const FlutterSecureStorage fss = FlutterSecureStorage();
  LocalStorage._();
  static late SharedPreferences sp;
  //AUTH
  static const String TOKEN_KEY = "key.token";
  static const String LOGIN_KEY = "key.login";
  static const String ID_KEY = "key.id";
  static const String PLAYER_ID_KEY = "key.player.id";
  static const String REFRESH_TOKEN_KEY = "key.refresh.token";
  static const String TOKEN_EXPIRED_DATE = "key.token.expired.date";
  //SETTING
  static const String SETTING_AUTO_PLAY = "key.setting.auto.play";
  static const String THEME_KEY = "key.theme";
  static const String EMAIL_TOKEN_KEY = "key.email.token";
  static const String PASSWORD_KEY = "key.password";
  static const String FORGOT_PASS_EMAIL_TOKEN_KEY =
      "key.email.token.forgot.pass";
  static const String PASSWORD_TOKEN_KEY = "key.password.token";

  static Future<void> initSharedPref() async {
    sp = await SharedPreferences.getInstance();
  }

  static Future<bool> saveLoginStatus(bool status) async {
    return await sp.setBool(LOGIN_KEY, status);
  }

  static Future<bool> getLoginStatus() async {
    return await sp.getBool(LOGIN_KEY) ?? false;
  }

  static Future<void> save({
    required String key,
    required String? value,
  }) async {
    await fss.write(key: key, value: value);
  }

  static Future<String?> read({required String key}) async {
    return await fss.read(key: key);
  }

  static Future<void> deleteAll() async {
    await sp.clear();
    await fss.deleteAll();
  }
}
