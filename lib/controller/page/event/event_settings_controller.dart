import 'package:event_app/model/event.dart';
import 'package:event_app/ui/main_page.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

void updateEventProcess(
  BuildContext context,
  String id,
  String name,
  String description,
  String tanggal,
  String eventUrl,
) {
  String toastValue;
  Event.updateEvent(id, name, description, tanggal, eventUrl).then((result) {
    toastValue = (result['status'] == "sukses")
        ? "Update Data Event berhasil."
        : "Update Data Event gagal.";
    if (result['status'] == "sukses") {
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

void deleteEventProcess(
  BuildContext context,
  String id,
) {
  String toastValue;
  Event.deleteEvent(id).then((result) {
    toastValue = (result['status'] == "sukses")
        ? "Hapus Event berhasil."
        : "Hapus Data Event gagal.";
    if (result['status'] == "sukses") {
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
