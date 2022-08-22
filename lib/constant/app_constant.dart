class AppConstant {
  static String? TOKEN;
  static String? USER_ID;

  static void clearData() {
    TOKEN = null;
    USER_ID = null;
  }
}

class ErrorMessage {
  static const UNEXPECTED_ERROR = "Unexpected error occurred";
  static const UNEXPECTED_TYPE_ERROR = "Unexpected type error occurred";
  static const CONNECTION_ERROR = "Error connecting to server";
  static const TIMEOUT_ERROR = "Connection timeout";
}

class HttpMethod {
  HttpMethod._();
  static const String GET = "get";
  static const String POST = "post";
  static const String PATCH = "patch";
  static const String PUT = "put";
  static const String DELETE = "delete";
}
