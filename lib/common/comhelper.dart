import "package:flutter/material.dart";
import 'package:toast/toast.dart';

//
alterdialog(BuildContext context, String msg) {
  ToastContext toastContext = ToastContext();
  toastContext.init(context);
  Toast.show(msg, duration: Toast.lengthLong, gravity: Toast.bottom);
}

validateemail(String email) {
  final emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}

validatepass(String password) {
  final passReg = RegExp(
      r"^[^\s]{8,}$");
  return passReg.hasMatch(password);
}
