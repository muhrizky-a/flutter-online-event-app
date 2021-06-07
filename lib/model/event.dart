// import '../model/user.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global_variables.dart';

class Event {
  /*
  int id;
  String nama;
  String deskripsi;
  String imageUrl;
  int userId;
  DateTime tanggal;
  String eventUrl;
  bool isReleased;
  bool isDone;

  Event(
      {this.id,
      this.nama,
      this.deskripsi,
      this.imageUrl = "assets/images/flutter.jpg",
      this.userId,
      this.tanggal,
      this.eventUrl,
      this.isReleased,
      this.isDone});
  */

  static Future createEvent(
      String name, String description, String tanggal, String eventUrl) async {
    var client = http.Client();
    try {
      var response = await client
          .post(Uri.parse("$hostUrl/event/create_event.php"), body: {
        "id_user": currentUser.id.toString(),
        "name": name,
        "desc": description,
        "tanggal": tanggal,
        "eventUrl": eventUrl,
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

  static Future getEvent(String id) async {
    var client = http.Client();

    try {
      String url = "$hostUrl/event/get_one_event.php?id=$id";
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

  static Future searchEvent(String name) async {
    var client = http.Client();

    try {
      String url = (currentUser.hakAkses == "organizer")
          ? "$hostUrl/event/search_event.php?name=$name&user_id=${currentUser.id}"
          : "$hostUrl/event/search_event.php?name=$name";
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

  static Future updateEvent(String id, String name, String description,
      String tanggal, String eventUrl) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse("$hostUrl/event/update_event.php"),
        body: {
          "id": id,
          "name": name,
          "desc": description,
          "tanggal": tanggal,
          "eventUrl": eventUrl,
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

  static Future updateEventStatus(String id, String action) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse("$hostUrl/event/update_status_event.php"),
        body: {
          "id": id,
          "action": action,
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

  static Future deleteEvent(String id) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse("$hostUrl/event/delete_event.php"),
        body: {
          "id": id,
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
