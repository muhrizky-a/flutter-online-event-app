import 'package:event_app/controller/page/user_login_register/login_controller.dart';
import 'package:event_app/ui/page/page_widgets.dart';
import 'register_page.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _pwdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getScreenHeight(context) / 4),
        child: AppBar(
          title: Text("Login"),
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
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                    FormTextField(
                        "Alamat Email", Icons.email, _emailController, false),
                    FormTextField(
                      "Kata Sandi",
                      Icons.vpn_key,
                      _pwdController,
                      true,
                      hasSuffixIcon: true,
                    ),
                  ],
                ),
              ),

              /*
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Lupa Kata Sandi?",
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              */
              SizedBox(height: 40,),
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
                    onTap: () {
                      loginProcess(context, _emailController.text, _pwdController.text);
                    },
                    child: Center(
                      child: Text("MASUK",
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
                    "Tidak Punya akun?  ",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      "Buat Akun",
                      style: TextStyle(
                          color: Colors.purple[900],
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
