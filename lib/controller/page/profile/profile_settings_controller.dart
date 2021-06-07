import 'package:event_app/global_variables.dart';
import 'package:event_app/model/user.dart';
import 'package:event_app/ui/main_page.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

void updateProfileProcess(
  BuildContext context,
  String name,
  String noTelp,
  String email,
  String job,
  String institusi,
) {
  String toastValue;
  User.updateProfile(
    currentUser.email,
    name,
    noTelp,
    email,
    job,
    institusi,
  ).then((result) {
    toastValue = (result['status'] == "sukses")
        ? "Update data berhasil."
        : "Update data gagal.";
    if (result['status'] == "sukses") {
      currentUser.nama = name;
      currentUser.noTelp = noTelp;
      currentUser.email = email;
      currentUser.pekerjaan = job;
      currentUser.institusi = institusi;
      Navigator.pop(context);
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

void deleteProfileProcess(BuildContext context) {
  String toastValue;
  User.deleteProfile(
    currentUser.email,
  ).then((result) {
    toastValue = (result['status'] == "sukses")
        ? "Hapus akun berhasil."
        : "Hapus akun gagal.";
    if (result['status'] == "sukses") {
      currentUser = new User();

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    }
  }).catchError((e) {
    print("Error: $e");
    toastValue = "Terjadi kesalahan. Mohon coba lagi.";
  }).whenComplete(() {
    showToast(toastValue);
  });
}

void updatePasswordProcess(BuildContext context, String password) {
  String toastValue;
  if (password.length > 0) {
    User.updatePassword(
      currentUser.email,
      password,
    ).then((result) {
      toastValue = (result['status'] == "sukses")
          ? "Ubah password berhasil."
          : "Ubah password gagal.";
      if (result['status'] == "sukses") {
        currentUser.password = password;
        Navigator.pop(context);
      }
    }).catchError((e) {
      print("Error: $e");
      toastValue = "Terjadi kesalahan. Mohon coba lagi.";
    }).whenComplete(() {
      showToast(toastValue);
    });
  } else {
    showToast("Password tidak dapat kosong.");
  }
}
