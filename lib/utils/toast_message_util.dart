import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastMessageSuccess(String msg, BuildContext context, {double? offset}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.green,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}

void toastMessageError(String msg, BuildContext context, {double? offset}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.red.shade300,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
