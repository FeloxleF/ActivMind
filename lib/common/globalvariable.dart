import 'package:flutter/material.dart';

class GlobalVariables extends ChangeNotifier {
  String user = 'test'; 

  void setuser(String username) {
    user = username;
    notifyListeners(); 
  }
}