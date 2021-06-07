import 'package:event_app/controller/page/user_login_register/register_page_controller.dart';
import 'package:event_app/ui/page/page_widgets.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _noTelpController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _pwdController = new TextEditingController();
  String _hakAkses = "peserta";

  int _radioValue = 0;

  void _handleHakAksesRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
    _hakAkses = (value == 0) ? "peserta" : "organizer";
  }

  void _handleUserRegister() {
    registerProcess(context, _nameController.text, _noTelpController.text,
        _emailController.text, _pwdController.text, _hakAkses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getScreenHeight(context) / 4),
        child: AppBar(
          title: Text("Daftar Akun"),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: loginFormAppbarClipper(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.purple[800],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.only(top: getScreenHeight(context) / 4 + 20),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 25),
                child: Column(
                  children: <Widget>[
                    FormTextField("Nama", Icons.person, _nameController, false),
                    FormTextField(
                      "No. Telpon",
                      Icons.phone,
                      _noTelpController,
                      false,
                      maxLength: 13,
                    ),
                    FormTextField(
                        "Alamat Email", Icons.email, _emailController, false),
                    FormTextField(
                      "Buat Kata Sandi Baru",
                      Icons.vpn_key,
                      _pwdController,
                      true,
                      hasSuffixIcon: true,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.group,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                "Hak Akses: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor),
                              ),
                            ],
                          ),
                          radioButton("Peserta", 0),
                          radioButton("Organizer", 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 40,
                margin: EdgeInsets.only(bottom: 30),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.white.withOpacity(0.5),
                    onTap: _handleUserRegister,
                    child: Center(
                      child: Text("DAFTAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          )),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      colors: [primaryColor, Colors.purple[300]],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sudah Punya akun?  ",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                          color: Colors.purple[900],
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget radioButton(String option, int value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _radioValue,
          onChanged: _handleHakAksesRadioValueChange,
        ),
        Text(
          option,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
