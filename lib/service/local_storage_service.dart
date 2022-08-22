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
  static const String CART_KEY = "key.cart";

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
