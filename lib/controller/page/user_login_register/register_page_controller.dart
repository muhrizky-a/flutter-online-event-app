import 'package:event_app/model/user.dart';
import 'package:event_app/ui/main_page.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

void registerProcess(
  BuildContext context,
  String name,
  String noTelp,
  String email,
  String password,
  String hakAkses,
) {
  String toastValue;
  User.registerUser(name, noTelp, email, password, hakAkses).then((result) {
    toastValue = (result['status'] == "sukses")
        ? "Pendaftaran berhasil."
        : "Pendaftaran gagal.";
    if (result['status'] == "sukses") {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    }
  }).catchError((e) {
    print("Error 2: $e");
    toastValue = "Terjadi kesalahan. Mohon coba lagi.";
  }).whenComplete(() {
    showToast(toastValue);
  });
}
