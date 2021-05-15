import '../main_page.dart';
import 'package:flutter/material.dart';
import '../login_page.dart';

// String url = "http://img1.mukewang.com/5c18cf540001ac8206000338.jpg";
String url = "assets/images/flutter.jpg";

Widget drawer(BuildContext context) {
  //DateTime _now = DateTime.now();
  return Theme(
    data:
        Theme.of(context).copyWith(canvasColor: Colors.white.withOpacity(0.8)),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                            width: 100,
                            height: 100,
                            image: AssetImage(
                                "$url"),
                            fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Hi, User69420.",
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
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
          ),
          ListTile(
            title: Text('Tentang'),
            leading: Icon(Icons.info_outline),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
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
