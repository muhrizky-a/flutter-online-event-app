import 'package:event_app/model/event.dart';
import 'package:event_app/ui/main_page.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

void createEventProcess(
  BuildContext context,
  String name,
  String description,
  String tanggal,
  String eventUrl,
) {
  String toastValue;
  Event.createEvent(name, description, tanggal, eventUrl).then((result) {
    toastValue = (result['status'] == "sukses")
        ? "Pembuatan Event berhasil."
        : "Pembuatan Event gagal.";
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
