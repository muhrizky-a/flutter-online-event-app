import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Tentang Aplikasi"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image(image: AssetImage("assets/images/unmul-logo.png")),
              SizedBox(
                height: 40,
              ),
              customTextWidget("Online Event App", 22, FontWeight.w700),
              customTextWidget("Version 1.0.0", 20, FontWeight.w500),
              SizedBox(
                height: 40,
              ),
              customTextWidget("Anggota Kelompok:", 20, FontWeight.w700),
              customTextWidget("Muh. Aqsal Ardyansa B. (1915016054)", 16,
                  FontWeight.w500),
              customTextWidget("Alfansya Zaidan D. P. (1915016058)", 16,
                  FontWeight.w500),
              customTextWidget("Ananta Wijaya (1915016072)", 16, FontWeight.w500),
              customTextWidget(
                  "Muhammad Rizky Amanullah (1915016073)", 16, FontWeight.w500),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextWidget(String text, double fontSize, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: primaryColor,
      ),
    );
  }
}
