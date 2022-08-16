import 'package:flutter/material.dart';
import 'package:where_the_food/constant/app_constant.dart';
import 'package:where_the_food/constant/local_storage_service.dart';
import 'package:where_the_food/model/response/login_response.dart';
import 'package:where_the_food/provider/user_provider.dart';

class AuthService {
  static Future<void> onLoginSuccess(
    BuildContext context,
    AuthResponse authResponse,
  ) async {
    await LocalStorage.save(key: LocalStorage.TOKEN_KEY, value: authResponse.token);
    await LocalStorage.save(key: LocalStorage.ID_KEY, value: authResponse.userId);
    await AuthService.initLocalUserCredential();
    UserProvider.getProvider(context).setLoginStatus(true);
  }

  static Future<void> initLocalUserCredential() async {
    AppConstant.TOKEN = await LocalStorage.read(key: LocalStorage.TOKEN_KEY);
    AppConstant.USER_ID = await LocalStorage.read(key: LocalStorage.ID_KEY);
    debugPrint("TOKEN : ${AppConstant.TOKEN}");
    debugPrint("USER_ID: ${AppConstant.USER_ID}");
  }
}
