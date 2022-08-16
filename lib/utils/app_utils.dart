import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class AppUtils {
  static TokenPayload parseJwtPayLoad(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return TokenPayload.fromMap(payloadMap);
  }

  static Future<DateTime?> onPickDOB(
    DateTime? lastDate,
    TextEditingController controllerTC,
    BuildContext context,
  ) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: lastDate ?? DateTime.now(),
        firstDate: DateTime.parse("1999-01-01"),
        lastDate: DateTime.now(),
        builder: (_, Widget? child) {
          return child!;
        });
    if (selectedDate == null) return null;
    controllerTC.text = selectedDate.formatDate(
      format: "dd/MM/yyyy",
    );
    return selectedDate;
  }
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }
  return utf8.decode(base64Url.decode(output));
}
