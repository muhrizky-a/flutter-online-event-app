import 'package:event_app/global_variables.dart';
import 'package:event_app/model/event.dart';
import 'package:event_app/model/peserta_event.dart';
import 'package:event_app/ui/main_page.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

bool isRegistrationClosed(DateTime eventDate) {
  DateTime now = DateTime.now();
  return (now.isAtSameMomentAs(eventDate) || now.isAfter(eventDate));
}

bool isUserCanJoin(
    DateTime eventDate, String isEventDone, Map<String, dynamic> pesertaEvent) {
  return (isRegistrationClosed(eventDate) &&
      !(isEventDone == '1') &&
      (pesertaEvent != null));
}

bool buttonAvailableCondition(DateTime eventDate, String isEventReleased,
    String isEventDone, Map<String, dynamic> pesertaEvent) {
  switch (currentUser.hakAkses) {
    case "peserta":
      return !isRegistrationClosed(eventDate) ||
          isUserCanJoin(eventDate, isEventDone, pesertaEvent);
      break;
    case "organizer":
      /*
      return !((isRegistrationClosed(eventDate)) &&
              (isEventReleased == '1') &&
              (isEventDone == '1')) ||
          !(!(isRegistrationClosed(eventDate)) &&
              (isEventReleased == '1') &&
              !(isEventDone == '1')) ||
          ((isRegistrationClosed(eventDate)) &&
              (isEventReleased == '1') &&
              !(isEventDone == '1')) ||
          !((isRegistrationClosed(eventDate)) &&
              (isEventReleased == '1') &&
              (isEventDone == '1'));
              */
      return ((isRegistrationClosed(eventDate) && (isEventReleased == '1')) ||
              (!isRegistrationClosed(eventDate) &&
                  !(isEventReleased == '1'))) &&
          !(isEventDone == '1');
      break;
    default:
      return false;
      break;
  }
}

String buttonTextCondition(DateTime eventDate, String isEventReleased,
    String isEventDone, Map<String, dynamic> pesertaEvent) {
  String text;
  bool isEventJoined = pesertaEvent != null;
  switch (currentUser.hakAkses) {
    case "peserta":
      text = isUserCanJoin(eventDate, isEventDone, pesertaEvent)
          ? "Bergabung ke Event"
          : (isEventJoined)
              ? "Batalkan Pendaftaraan"
              : "Daftar Event";
      break;
    case "organizer":
      text =
          isEventReleased == '0' ? "Publikasi Event" : "Tandai Sebagai Selesai";
      break;
  }
  return text;
}

////////////
void updateEventStatusProcess(
  BuildContext context,
  String id,
  String action,
) {
  Event.updateEventStatus(id, action).then((result) {
    if (result['status'] == "sukses") {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
      showToast(
          "${action == 'publikasi' ? 'Publikasi Event' : 'Ubah status Event selesai'} berhasil.");
    } else {
      showToast(
          "${action == 'publikasi' ? 'Publikasi Event' : 'Ubah status Event selesai'} gagal.");
    }
  }).catchError((e) {
    print("Error: $e");
    showToast("Terjadi kesalahan. Mohon coba lagi.");
  });
}

////////////
void addPesertaEventProcess(BuildContext context, String eventId) {
  PesertaEvent.addPesertaEvent(eventId).then((result) {
    if (result['status'] == "sukses") {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
      showToast("Pendaftaran ke Event berhasil.");
    } else {
      showToast("Pendaftaran ke Event gagal.");
    }
  }).catchError((e) {
    print("Error: $e");
    showToast("Terjadi kesalahan. Mohon coba lagi.");
  });
}

void deletePesertaEventProcess(BuildContext context, String eventId) {
  PesertaEvent.deletePesertaEvent(eventId).then((result) {
    if (result['status'] == "sukses") {
      showToast("Pembatalan daftar dari Event berhasil.");
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      showToast("Pembatalan daftar dari Event gagal.");
    }
  }).catchError((e) {
    print("Error: $e");
    showToast("Terjadi kesalahan. Mohon coba lagi.");
  });
}


//////////
class TempEvent {
  String eventName;
  String tanggal;
  int statusHadir;

  TempEvent({
    this.eventName,
    this.tanggal,
    this.statusHadir,
  });
}

//////////
void getOnePesertaEventProcess(BuildContext context, String eventId) {
  PesertaEvent.getPesertaEvent(eventId).then((result) {
    //setPesertaEvent(result);
  }).catchError((e) {
    print("Error: $e");
    showToast("Terjadi kesalahan. Mohon coba lagi.");
  });
}

void updatePesertaEventStatusProcess(BuildContext context, String eventId) {
  PesertaEvent.updatePesertaEventStatus(eventId).then((result) {
    if (result['status'] != "sukses") {
      showToast("Update status kehadiran di Event gagal.");
    }
  }).catchError((e) {
    print("Error: $e");
    showToast(
        "Terjadi kesalahan saat update status kehadiran di event. Mohon coba lagi.");
  });
}
