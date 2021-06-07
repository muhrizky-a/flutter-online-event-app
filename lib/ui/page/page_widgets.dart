import 'dart:math';

import 'package:event_app/global_variables.dart';
import 'package:event_app/ui/widget/widgets.dart';

import 'package:flutter/material.dart';

class PageAppBar extends AppBar {
  final List<Widget> actions;

  PageAppBar(this.actions);

  static Widget init(List<Widget> actions) {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.black.withOpacity(0.5),
      shadowColor: Colors.transparent,
      leading: BackButton(),
      actions: actions,
    );
  }
}

class PageInfo extends StatelessWidget {
  final String title, description, imageUrl;
  final double borderRadius;

  PageInfo({
    this.title = "Judul",
    this.description = "Deskripsi",
    this.imageUrl,
    this.borderRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    bool isImageExists = (imageUrl !=  "null");

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            //Foto sampul
            (isImageExists)
                ? Image(
                    width: getScreenWidth(context),
                    height: getScreenWidth(context) / 2,
                    image: NetworkImage("$imageUrl"),
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: getScreenWidth(context),
                    height: getScreenWidth(context) / 2,
                    color: primaryColor),

            //Informasi page
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: (getScreenWidth(context) / 4) + 20),
                PageDetail(
                  title: this.title,
                  description: this.description,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                Divider(),
              ],
            ),
          ],
        ),

        //Foto profil
        Positioned(
          child: Center(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (isImageExists) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PageImage("$imageUrl")));
                }
              },
              child: Hero(
                tag: "profile-img",
                child: Container(
                  width: getScreenWidth(context) / 2,
                  height: getScreenWidth(context) / 2,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(this.borderRadius),
                    image: isImageExists
                        ? DecorationImage(
                            image: NetworkImage("$imageUrl"), fit: BoxFit.cover)
                        : null,
                  ),
                  child: !isImageExists
                      ? CircleAvatar(
                          child: Text(
                            currentUser.nama[0],
                            style: TextStyle(fontSize: 40),
                          ),
                        )
                      : SizedBox(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PageDetail extends StatelessWidget {
  final String title;
  final String description;
  final CrossAxisAlignment crossAxisAlignment;

  PageDetail(
      {this.title,
      this.description,
      this.crossAxisAlignment = CrossAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: this.crossAxisAlignment,
        children: [
          Text(
            this.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            this.description,
            textAlign: TextAlign.justify,
            style: TextStyle(letterSpacing: 1),
          ),
        ],
      ),
    );
  }
}

class PageDetails extends StatelessWidget {
  final List<Widget> details;
  PageDetails(this.details);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: details,
    );
  }
}

class PageImage extends StatelessWidget {
  final String profilePictUrl;
  PageImage(this.profilePictUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
      body: Center(
        child: Hero(
            tag: "profile-img",
            child:
                Image(image: NetworkImage(this.profilePictUrl), fit: BoxFit.cover)),
      ),
    );
  }
}

// ignore: must_be_immutable
class FormTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  bool isTextHidden;
  final bool hasSuffixIcon;
  final int maxLength;

  FormTextField(this.label, this.icon, this.controller, this.isTextHidden, {this.hasSuffixIcon = false, this.maxLength = TextField.noMaxLength});

  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  void _showHideText() {
    setState(() {
      widget.isTextHidden = !widget.isTextHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isTextHidden,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          icon: Icon(widget.icon, color: primaryColor),
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


class PagePopup extends StatelessWidget {
  final List<Widget> children;

  const PagePopup({this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenWidth(context),
      height: getScreenHeight(context),
      color: Colors.transparent,
      child: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          width: getScreenWidth(context) * 0.9,
          height: getScreenHeight(context) * 0.9,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black.withOpacity(0.5), width: 2),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.90)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}




List<Widget> loginFormAppbarClipper(BuildContext context) {
  return [
    Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(pi),
      child: ClipPath(
        clipper: LoginFormClipper(),
        child: Container(
          color: primaryColor.withOpacity(0.3),
          width: getScreenWidth(context),
          height: getScreenHeight(context) / 4,
        ),
      ),
    ),
    ClipPath(
      clipper: LoginFormClipper(),
      child: Container(
        color: primaryColor.withOpacity(0.8),
        width: getScreenWidth(context),
        height: getScreenHeight(context) / 4,
      ),
    ),
  ];
}

class LoginFormClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.75);
    //Buat Kurva
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height / 2);
    path.quadraticBezierTo(size.width * 0.75, 0, size.width, size.height / 4);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // ignore: todo
    // TODO: implement shouldReclip
    return false;
  }
}

class EventFormClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.75);
    //Buat Kurva
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.75);

    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // ignore: todo
    // TODO: implement shouldReclip
    return false;
  }
}
