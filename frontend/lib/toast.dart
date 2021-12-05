import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CaffToast{
  static void show(String message, Color color){
    Fluttertoast.showToast(
        msg: "Successful login!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showError(String message){
    show(message, Colors.red);
  }

  static void showSuccess(String message){
    show(message, Colors.green);
  }
}
