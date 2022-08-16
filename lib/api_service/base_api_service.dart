import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:where_the_food/api_service/http_client.dart';
import 'package:where_the_food/constant/app_constant.dart';
import 'package:where_the_food/utils/app_utils.dart';

import 'base_http_exception.dart';

class BaseApiService {
  late Dio _dio;
  BaseApiService({Dio? dio}) {
    this._dio = dio ?? BaseHttpClient.dio;
  }

  final String MESSAGE_FIELD = "message";
  final String STATUS_FIELD = "status";
  final String DATA_FIELD = "data";

  /// Requests Api by providing params such as: Path, HttpOptions, Query, Data
  /// Returns response if success
  /// Throws Error if fail
  Future<T> onRequest<T>({
    required String path,
    required T Function(Response) onSuccess,
    String method = HttpMethod.GET,
    Map<String, dynamic> query = const {},
    Map<String, dynamic> headers = const {},
    dynamic data = const {},
    bool requiredToken = true,
    String? customToken,
  }) async {
    Response? response;
    try {
      final httpOption = Options(method: method, headers: {});
      if (AppConstant.TOKEN != null && AppConstant.TOKEN!.isNotEmpty && requiredToken) {
        bool expired = AppUtils.parseJwtPayLoad(AppConstant.TOKEN!).isExpired;
        httpOption.headers!['authorization'] = "bearer ${AppConstant.TOKEN}";
      }
      if (customToken != null) {
        httpOption.headers!['authorization'] = "bearer $customToken";
      }
      httpOption.headers!.addAll(headers);
      response = await _dio.request(
        path,
        options: httpOption,
        queryParameters: query,
        data: data,
      );

      if (response.data != null) {
        return onSuccess(response);
      } else {
        throw ServerResponseException(response.data);
      }
    } on DioError catch (exception) {
      throw _onDioError(exception);
    } on ServerResponseException catch (exception) {
      throw _onServerResponseException(exception, response!);
    } catch (exception) {
      throw _onTypeError(exception);
    }
  }
}

String _onTypeError(dynamic exception) {
  debugPrint("Type Error :=> ${exception.toString()}\nStackTrace:  ${exception.stackTrace.toString()}");
  return ErrorMessage.UNEXPECTED_TYPE_ERROR;
}

DioErrorException _onDioError(DioError exception) {
  _logDioError(exception);
  if (exception.error is SocketException) {
    ///Socket exception mostly from internet connection or host
    return DioErrorException(ErrorMessage.CONNECTION_ERROR);
  } else if (exception.type == DioErrorType.connectTimeout) {
    ///Connection timeout due to internet connection or server not responding
    return DioErrorException(ErrorMessage.TIMEOUT_ERROR);
  } else if (exception.type == DioErrorType.response) {
    ///Error that range from 400-500
    String serverMessage;
    if (exception.response!.data is Map) {
      serverMessage = exception.response?.data["message"] ?? ErrorMessage.UNEXPECTED_ERROR;
    } else {
      serverMessage = ErrorMessage.UNEXPECTED_ERROR;
    }
    return DioErrorException(serverMessage, code: exception.response!.statusCode);
  }
  throw DioErrorException(ErrorMessage.UNEXPECTED_ERROR);
}

void _logDioError(DioError exception) {
  String errorMessage = "Dio error :=> ${exception.requestOptions.path}";
  if (exception.response != null) {
    errorMessage += ", Response: => ${exception.response!.data.toString()}";
  } else {
    errorMessage += ", ${exception.message}";
  }
  debugPrint(errorMessage);
}

ServerResponseException _onServerResponseException(dynamic exception, Response response) {
  debugPrint("Server error :=> ${response.requestOptions.path}:=> $exception");
  return ServerResponseException(exception.toString());
}
