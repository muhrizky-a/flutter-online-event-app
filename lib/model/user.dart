import 'dart:convert';
import 'package:http/http.dart' as http;

import '../global_variables.dart';

class User {
  int id;
  String nama;
  String noTelp;
  String pekerjaan;
  String institusi;
  String imageUrl = ""; //= "assets/images/flutter.jpg";

  String email;
  String password;
  String hakAkses; //= HakAkses.peserta;

  User(
      {this.id,
      this.nama,
      this.noTelp,
      this.pekerjaan,
      this.institusi,
      this.imageUrl,
      this.email,
      this.password,
      this.hakAkses});

  factory User.createUser(Map<String, dynamic> object) {
    
    return User(
      id: int.parse(object['id']),
      nama: object['nama'],
      noTelp: object['no_telp'],
      pekerjaan: object['pekerjaan'],
      institusi: object['institusi'],
      imageUrl: object['image_url'],
      email: object['email'],
      password: object['password'],
      hakAkses: object['hak_akses'],
    );
  }

  static Future registerUser(String name, String noTelp, String email,
      String password, String hakAkses) async {
    var client = http.Client();
    try {
      var response =
          await client.post(Uri.parse("$hostUrl/user/register.php"), body: {
        "name": name,
        "noTelp": noTelp,
        "email": email,
        "password": password,
        "hakAkses": hakAkses,
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

  static Future loginUser(String email, String password) async {
  
  var client = http.Client();
  try {
    var response = await client.post(Uri.parse("$hostUrl/user/login.php"),
        body: {"email": email, "password": password});
    
    var jsonObject = await json.decode(response.body);
    
    return jsonObject;

  } catch(e) {
    print("Error: $e");
    throw NullThrownError();
  }finally {
    client.close();
  }
}

  static Future updateProfile(String oldEmail, String name, String noTelp,
      String email, String job, String institusi) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse("$hostUrl/user/update_user.php"),
        body: {
          "oldEmail": oldEmail,
          "name": name,
          "noTelp": noTelp,
          "email": email,
          "pekerjaan": job,
          "institusi": institusi,
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

  static Future updatePassword(String email, String password) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse("$hostUrl/user/update_password.php"),
        body: {
          "email": email,
          "password": password,
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

  static Future deleteProfile(String email) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse("$hostUrl/user/delete_user.php"),
        body: {
          "email": email,
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
