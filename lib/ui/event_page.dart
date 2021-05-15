import '../ui/widget/widgets.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EventPage extends StatelessWidget {
  bool isBookmark = false;

  @override
  Widget build(BuildContext context) {
    DateTime _now = DateTime.now();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.amber,
        backgroundColor: Colors.black.withOpacity(0.5),
        shadowColor: Colors.transparent,
        /*
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[
                  Colors.black.withOpacity(0.75),
                  Colors.transparent,
                  Colors.transparent
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter),
          ),
        ),
        */
        leading: BackButton(),
        actions: [
          IconButton(
            icon: Icon(isBookmark ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              isBookmark = !isBookmark;
              final snackBar = SnackBar(
                content: Text(isBookmark
                    ? "Berhasil ditambahkan ke bookmark"
                    : "Bookmark berhasil dihapus"),
                action: SnackBarAction(
                  label: 'Tutup',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            color: isBookmark ? Colors.blue : Colors.white,
            iconSize: 30,
          )
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  // clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Image(
                            width: getScreenWidth(context),
                            // height: getScreenHeight(context) * 3 / 10,
                            height: (getScreenWidth(context) / 2),
                            image: AssetImage("$url"),
                            fit: BoxFit.cover),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                                height: (getScreenWidth(context) / 4) + 20),
                            EventInfo(
                              title:
                                  "Pengembangan Aplikasi Yang Aman 1234567890",
                              description:
                                  "Diselenggarakan oleh Informatika Unmul",
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            Divider(),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      //bottom: (getScreenWidth(context) * 1 / 10),
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventImage()));
                          },
                          child: Hero(
                            tag: "event-img",
                            child: Container(
                                width: getScreenWidth(context) / 2,
                                height: getScreenWidth(context) / 2,
                                child: Image(
                                    image: AssetImage("$url"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                EventInfo(
                    title: "Deskripsi",
                    description:
                        '''Tren pemanfaatan teknologi informasi untuk mendukung proses bisnis membuat transformasi digital menjadi salah satu insiatif strategi organisasi untuk memaksimalkan peluang dalam rangka merebut pasar. Hal tersebut memacu organisasi untuk berlomba-lomba mengembangkan aplikasi baik secara mandiri maupun memanfaatkan jasa pihak ketiga, namun disayangkan seringkali dalam proses pengembangannya kurang memperhatikan faktor keamanan. Tidak sedikit serangan dan insiden siber yang mengintai bahkan menyebabkan kerugian karena eksploitasi kerentanan aplikasi. 
                    \nPenerapan pengembangan software yang aman menjadi salah satu kunci awal bagi Developer atau Startup untuk meminimalisir risiko ancaman siber yang ditimbulkan oleh kerentanan aplikasi. Oleh sebab itu, Secure Software Development Life Cycle (SDLC) menjadi salah satu solusi untuk mempertahankan aspek kerahasiaan, keutuhan dan ketersediaan informasi dalam suatu aplikasi, mulai dari tahap pengembangan, pengoperasian maupun pemeliharaannya. Penerapan kontrol keamanan yang memadai dalam proses pengembangan menjadi mutlak, sehingga harus memperhatikan keseluruhan komponen, meliputi teknologi, manusia dan proses.
                    \nMau tau bagaimana menerapkan Secure SDLC yang baik? Seperti apa pengaplikasian Secure SDLC dalam framework DevOps? Bagaimana menerapkan kontrol keamanan dalam proses pengembangan aplikasi? Penasaran dengan jawabannya? Segera daftarkan diri Anda!'''),
                SizedBox(height: 20),
                Divider(),
                EventInfo(
                    title: "Jadwal Pelaksanaan",
                    description:
                        "Tanggal : ${_now.day < 10 ? "0" + _now.day.toString() : _now.day}-${_now.month < 10 ? "0" + _now.month.toString() : _now.month}-${_now.year}, ${_now.hour < 10 ? "0" + _now.hour.toString() : _now.hour}:${_now.minute < 10 ? "0" + _now.minute.toString() : _now.minute} WITA"),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Daftar Event",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade800,
                minimumSize: Size(getScreenWidth(context) - 20, 40),
                animationDuration: Duration(seconds: 1),
                elevation: 2,
                side: BorderSide(color: Colors.blue.shade200, width: 2),
                padding: EdgeInsets.all(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventInfo extends StatelessWidget {
  final String title;
  final String description;
  final CrossAxisAlignment crossAxisAlignment;

  EventInfo(
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

class EventImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
      body: Center(
        child: Hero(
            tag: "event-img",
            child: Image(image: AssetImage("$url"), fit: BoxFit.cover)),
      ),
    );
  }
}
