import 'package:flutter/material.dart';

class HelperMethod {
  static void showMessage(String message,BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}