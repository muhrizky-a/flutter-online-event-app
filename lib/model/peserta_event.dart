// import '../model/user.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global_variables.dart';

class PesertaEvent {
  String eventName;
  String tanggal;
  int statusHadir;

  PesertaEvent({
    this.eventName,
    this.tanggal,
    this.statusHadir,
  });

  static Future addPesertaEvent(String eventId) async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.parse("$hostUrl/peserta_event/add_peserta_event.php"),
          body: {
            "id_user": currentUser.id.toString(),
            "id_event": eventId,
          });

      var jsonObject = await json.decode(response.body);

      return jsonObject;
    } catch (e) {
      print(e);
      throw NullThrownError();
    } finally {
      client.close();
    }
  }

  static Future getAllPesertaEvent() async {
    var client = http.Client();

    try {
      String url =
          "$hostUrl/peserta_event/get_all_peserta_event.php?id_user=${currentUser.id}&hak_akses=${currentUser.hakAkses}";
      var response = await client.get(Uri.parse(url));
      var jsonObject = await json.decode(response.body) as List;
      return jsonObject;
      /*
      return jsonObject
        .map<PesertaEvent>((item) =>
            PesertaEvent(eventName: item["eventName"].toString(), tanggal: item["tanggal"].toString(), statusHadir: int.parse(item["status_hadir"])))
        .toList();
        */
    } catch (e) {
      print(e);
      throw NullThrownError();
    } finally {
      client.close();
    }
  }

  static Future getPesertaEvent(String eventId) async {
    var client = http.Client();

    try {
      String url =
          "$hostUrl/peserta_event/get_one_peserta_event.php?id_user=${currentUser.id}&id_event=$eventId";
      var response = await client.get(Uri.parse(url));
      var jsonObject = await json.decode(response.body);
      return jsonObject;
    } catch (e) {
      print(e);
      throw NullThrownError();
    } finally {
      client.close();
    }
  }

  static Future updatePesertaEventStatus(String eventId) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse("$hostUrl/peserta_event/update_status_peserta_event.php"),
        body: {
          "id_user": currentUser.id.toString(),
          "id_event": eventId,
        },
      );

      var jsonObject = await json.decode(response.body);

      return jsonObject;
    } catch (e) {
      print(e);
      throw NullThrownError();
    } finally {
      client.close();
    }
  }

  static Future deletePesertaEvent(String eventId) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse("$hostUrl/peserta_event/delete_peserta_event.php"),
        body: {
          "id_user": currentUser.id.toString(),
          "id_event": eventId,
        },
      );

      var jsonObject = await json.decode(response.body);

      return jsonObject;
    } catch (e) {
      print(e);
      throw NullThrownError();
    } finally {
      client.close();
    }
  }
}
