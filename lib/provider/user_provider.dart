import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:where_the_food/constant/local_storage_service.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  // AsyncSubjectManager<AccountAuthModel> managerAuth = AsyncSubjectManager();

  //Public field
  bool get isLoggedIn => _isLoggedIn;

  static UserProvider getProvider(BuildContext context, [bool listen = false]) =>
      Provider.of<UserProvider>(context, listen: listen);
  // AsyncSubjectManager<AccountInfo> userSubjectManager = AsyncSubjectManager();

  void setLoginStatus(bool isLoggedIn) {
    LocalStorage.saveLoginStatus(isLoggedIn);
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  // Future getUserInfo({bool throwError = false, bool reloading = false}) async {
  //   await userSubjectManager.asyncOperation(
  //     () => userApiService.fetchAccountInfo(),
  //     reloading: reloading,
  //     throwError: throwError,
  //     onSuccess: (data) {
  //       return data;
  //     },
  //   );
  // }

  // Future<void> fetchAccountAuth() async {
  //   await managerAuth.asyncOperation(
  //     () async {
  //       return userApiService.fetchAccountAuth();
  //     },
  //     onSuccess: (response) {
  //       return response;
  //     },
  //   );
  // }

  void logoutUser() {
    // userController.addData(null);
    setLoginStatus(false);
  }

  @override
  void dispose() {
    super.dispose();
    // managerAuth.dispose();
  }
}
