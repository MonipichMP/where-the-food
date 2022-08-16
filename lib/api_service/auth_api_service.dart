import 'package:where_the_food/api_service/base_api_service.dart';
import 'package:where_the_food/constant/app_constant.dart';
import 'package:where_the_food/model/response/login_response.dart';

class AuthApiService extends BaseApiService {
  static const String login = "/login";
  static const String register = "/register";

  Future<AuthResponse> loginUser({String? username, String? password}) async {
    return onRequest(
      path: login,
      method: HttpMethod.POST,
      data: {
        "username": username,
        "password": password,
      },
      onSuccess: (response) {
        return AuthResponse.fromJson(response.data);
      },
    );
  }

  Future<AuthResponse> registerUser({
    String? username,
    String? password,
    String? fullName,
    String? dateOfBirth,
  }) async {
    return onRequest(
      path: register,
      method: HttpMethod.POST,
      data: {
        "username": username,
        "password": password,
        "fullName": fullName,
        "dateOfBirth": dateOfBirth,
      },
      onSuccess: (response) {
        return AuthResponse.fromJson(response.data);
      },
    );
  }
}
