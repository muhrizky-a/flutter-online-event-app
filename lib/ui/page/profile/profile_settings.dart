import 'package:event_app/controller/page/profile/profile_settings_controller.dart';
import 'package:event_app/global_variables.dart';

import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

import '../page_widgets.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final TextEditingController _nameController =
      new TextEditingController(text: currentUser.nama);

  final TextEditingController _noTelpController =
      new TextEditingController(text: currentUser.noTelp);

  final TextEditingController _emailController =
      new TextEditingController(text: currentUser.email);

  final TextEditingController _jobController =
      new TextEditingController(text: currentUser.pekerjaan);

  final TextEditingController _institutionController =
      new TextEditingController(text: currentUser.institusi);

  bool isPopupShowed = false;

  void handleUpdateProfile() {
    updateProfileProcess(
      context,
      _nameController.text,
      _noTelpController.text,
      _emailController.text,
      _jobController.text,
      _institutionController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Pengaturan Profil"),
        actions: [
          ElevatedButton(
            onPressed: () {
              isPopupShowed = !isPopupShowed;
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
            ),
            child: Text("Hapus Akun"),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  _CustomTextField("Nama Lengkap", _nameController, false),
                  _CustomTextField("No. Telpon", _noTelpController, false),
                  _CustomTextField("Alamat Email", _emailController, false),
                  _CustomTextField("Pekerjaan", _jobController, false),
                  _CustomTextField("Institusi", _institutionController, false),
                  _SaveButton(
                    action: handleUpdateProfile,
                  ),
                ],
              ),
            ),
          ),
          isPopupShowed ? showHapusAkunPopup() : SizedBox(),
        ],
      ),
    );
  }

  Widget showHapusAkunPopup() {
    return PagePopup(children: [
      Icon(Icons.delete_forever,
          color: Colors.redAccent,
          size: screenWidthSmallerThanScreenHeight(context)
              ? getScreenWidth(context) / 2
              : getScreenHeight(context) / 2),
      Text(
        "Anda yakin ingin menghapus akun anda?",
        style: TextStyle(
          fontSize: 20,
          color: Colors.redAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 40),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              isPopupShowed = !isPopupShowed;
              setState(() {});
            },
            child: Text(
              "Kembali",
              style: TextStyle(color: primaryColor),
            ),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.blue.shade400,
              primary: Colors.white,
              side: BorderSide(color: Colors.blue.shade800, width: 2),
              padding: EdgeInsets.all(20),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              deleteProfileProcess(context);
            },
            child: Text(
              "Hapus Akun",
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              side: BorderSide(color: Colors.red.shade800, width: 2),
              padding: EdgeInsets.all(20),
            ),
          ),
        ],
      ),
    ]);
  }
}

// ignore: must_be_immutable
class PasswordSettings extends StatelessWidget {
  final TextEditingController _newPwdController = new TextEditingController();
  bool showNewPwd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Pengaturan Kata Sandi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CustomTextField(
                "Masukkan Password Baru",
                _newPwdController,
                true,
                hasSuffixIcon: true,
              ),
              _SaveButton(
                action: () {
                  updatePasswordProcess(context, _newPwdController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  bool isTextHidden;
  final hasSuffixIcon;

  _CustomTextField(this.label, this.controller, this.isTextHidden,
      {this.hasSuffixIcon = false});

  @override
  __CustomTextFieldState createState() => __CustomTextFieldState();
}

class __CustomTextFieldState extends State<_CustomTextField> {
  void _showHideText() {
    setState(() {
      widget.isTextHidden = !widget.isTextHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isTextHidden,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2)),
          labelText: widget.label,
          labelStyle: TextStyle(color: primaryColor),
          suffixIcon: widget.hasSuffixIcon
              ? IconButton(
                  onPressed: _showHideText,
                  icon: Icon(widget.isTextHidden
                      ? Icons.visibility_off
                      : Icons.visibility),
                )
              : null,
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final Function action;

  _SaveButton({this.action});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      child: Text(
        "Simpan",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      style: ElevatedButton.styleFrom(
        // primary: Colors.blue.shade800,
        primary: Colors.blue.shade800,
        minimumSize: Size(getScreenWidth(context) - 20, 40),
        animationDuration: Duration(seconds: 1),
        elevation: 2,
        // side: BorderSide(color: Colors.blue.shade200, width: 2),
        side: BorderSide(color: Colors.blue.shade200, width: 2),
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
