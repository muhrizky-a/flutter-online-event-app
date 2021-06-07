import 'package:event_app/model/user.dart';
import 'package:event_app/ui/about_page.dart';
import 'package:flutter/material.dart';
import 'package:event_app/ui/page/event/create_event_form.dart';
import 'package:event_app/ui/page/profile/profile_page.dart';
import 'package:event_app/ui/page/user_login_register/login_page.dart';
import 'package:event_app/ui/main_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../global_variables.dart';

Color primaryColor = Color(0xff0056d2);

Widget drawer(BuildContext context) {
  //DateTime _now = DateTime.now();
  bool isAnyUserLoggedIn = (currentUser.email != null);

  return Theme(
    data:
        Theme.of(context).copyWith(canvasColor: Colors.white.withOpacity(0.9)),
    child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Color(0xff0056d2),
            ),
            child: Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.white.withOpacity(0.2),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => isAnyUserLoggedIn
                                ? ProfilePage()
                                : LoginPage()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          shape: BoxShape.circle,
                          image: isAnyUserLoggedIn &&
                                  (currentUser.imageUrl != null)
                              ? DecorationImage(
                                  image:
                                      NetworkImage("${currentUser.imageUrl}"),
                                  fit: BoxFit.cover)
                              : null,
                        ),
                        child:
                            isAnyUserLoggedIn && (currentUser.imageUrl == null)
                                ? CircleAvatar(
                                    child: Text(
                                      currentUser.nama[0],
                                      style: TextStyle(fontSize: 40),
                                    ),
                                  )
                                : SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          isAnyUserLoggedIn
                              ? "Hi, ${currentUser.nama}."
                              : "Silahkan Login",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            /*Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                    'Tanggal : ${_now.day < 10 ? "0" + _now.day.toString() : _now.day} - ${_now.month < 10 ? "0" + _now.month.toString() : _now.month} - ${_now.year}',
                    style: TextStyle(fontSize: 16, color: Color(0xffcbebe2))),
                Text(
                  '${_now.hour < 10 ? "0" + _now.hour.toString() : _now.hour} : ${_now.minute < 10 ? "0" + _now.minute.toString() : _now.minute}',
                  style: TextStyle(fontSize: 50, color: Color(0xffcbebe2)),
                ),
              ],
            ),
            */
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
          ),
          (isAnyUserLoggedIn && (currentUser.hakAkses == "organizer"))
              ? ListTile(
                  title: Text('Buat Event Online'),
                  leading: Icon(Icons.event),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateEventForm()));
                  },
                )
              : SizedBox(),
          isAnyUserLoggedIn
              ? ListTile(
                  title: Text('Log Out'),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () {
                    currentUser = new User();
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  },
                )
              : SizedBox(),
          ListTile(
            title: Text('Tentang'),
            leading: Icon(Icons.info_outline),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutPage()));
            },
          ),
        ],
      ),
    ),
  );
}

double getScreenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;
double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

bool screenWidthSmallerThanScreenHeight(BuildContext context) =>
    getScreenWidth(context) <= getScreenHeight(context);

DateTime getNextDay() {
  DateTime nextDay = DateTime.now();
  nextDay.add(new Duration(days: 1));
  return nextDay;
}

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      webBgColor: "linear-gradient(to bottom, #0056d2, #af67c9)",
      webPosition: "center");
}
