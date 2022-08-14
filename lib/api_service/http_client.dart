import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../constant/app_config.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class BaseHttpClient {
  static late Dio dio;

  static void init() {
    final BaseOptions options = BaseOptions(
      baseUrl: AppConfig.BASE_URL,
      connectTimeout: 20000,
      receiveTimeout: 20000,
    );
    dio = Dio(options)..interceptors.add(defaultInterceptor);
  }
}

final JsonDecoder decoder = JsonDecoder();
final JsonEncoder encoder = JsonEncoder.withIndent('  ');

final InterceptorsWrapper defaultInterceptor = InterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler requestInterceptorHandler) async {
    debugPrint("${options.method}: ${options.path},"
        " query: ${options.queryParameters},"
        " data: ${options.data},"
        " token: ${getLastIndexString(options.headers["authorization"])}");
    requestInterceptorHandler.next(options);
  },
  onResponse: (Response response, ResponseInterceptorHandler responseInterceptorHandler) async {
    //prettyPrintJson(response.data);
    responseInterceptorHandler.next(response);
  },
  onError: (DioError error, ErrorInterceptorHandler errorInterceptorHandler) async {
    errorInterceptorHandler.reject(error);
  },
);

void prettyPrintJson(dynamic input) {
  var prettyString = encoder.convert(input);
  prettyString.split('\n').forEach((element) => print(element));
}

String getLastIndexString(String? data, [int length = 2]) {
  if (data == null || data == "null") return "null";
  return data.substring(data.length - length);
}
