import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/api_service/index.dart';
import 'package:where_the_food/model/response/login_response.dart';
import 'package:where_the_food/service/local_storage_service.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  //Public field
  bool get isLoggedIn => _isLoggedIn;

  static UserProvider getProvider(BuildContext context, [bool listen = false]) =>
      Provider.of<UserProvider>(context, listen: listen);
  AsyncSubjectManager<AuthResponse> managerLogin = AsyncSubjectManager();

  void setLoginStatus(bool isLoggedIn) {
    LocalStorage.saveLoginStatus(isLoggedIn);
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  Future<void> loginUser({
    bool reloading = false,
    required String username,
    required String password,
  }) async {
    await managerLogin.asyncOperation(
      () async {
        return authApiService.loginUser(
          username: username,
          password: password,
        );
      },
      reloading: reloading,
      onSuccess: (response) {
        return response;
      },
      onError: (response) {
        debugPrint(response.toString());
      },
    );
  }

  void logoutUser() {
    setLoginStatus(false);
    managerLogin.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    managerLogin.dispose();
  }
}
