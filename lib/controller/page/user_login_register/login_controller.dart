import 'package:event_app/global_variables.dart';
import 'package:event_app/model/user.dart';
import 'package:event_app/ui/main_page.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

Future loginProcess(BuildContext context, String email, String password) async {
  String toastValue = "-";
  User.loginUser(email, password).then((result) {
    if (result.length != 0) {
      currentUser = User.createUser(result[0]);
    }
    toastValue = (result.length != 0)
        ? "Selamat datang, ${result[0]["nama"]}"
        : "Email / Password salah.";
  }).catchError((e) {
    print("Error 2: $e");
    toastValue = "Terjadi kesalahan. Mohon coba lagi.";
  }).whenComplete(() {
    showToast(toastValue);
    if (currentUser.email != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    }
  });
}
