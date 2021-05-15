import '../ui/event_page.dart';
import '../ui/widget/widgets.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final double gap = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xff0056d2),
              pinned: true,
              expandedHeight: getScreenHeight(context) / 2,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: Stack(
                  children: [
                    Image(
                        width: getScreenWidth(context),
                        height: getScreenHeight(context) / 2,
                        image: AssetImage("assets/images/online-event.jpg"),
                        fit: BoxFit.cover),
                    ClipPath(
                      //Bentuk pemotong
                      clipper: MyClipper(),
                      child: Container(
                        width: getScreenWidth(context),
                        height: getScreenHeight(context) / 2,
                        color: Color(0xff0056d2),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 20, 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: getScreenWidth(context) / 2,
                                child: Text(
                                  "Event App",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                width: getScreenWidth(context) / 2,
                                child: Text(
                                    "Temukan Event Online Yang Ingin Anda Ikuti Disini",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(gap),
                child: Row(
                  children: [
                    Container(
                      width: getScreenWidth(context) - 40 - 50,
                      height: 50,
                      child: TextField(
                        cursorColor: Color(0xff0056d2),
                        decoration: InputDecoration(
                          hintText: "Masukkan pencarian",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff0056d2), width: 2)),
                          labelStyle: TextStyle(color: Color(0xff0056d2)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff0056d2), width: 2),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff0056d2),
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(gap),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: gap,
                  crossAxisSpacing: gap,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return EventBox(
                      "assets/images/flutter.jpg");
                }, childCount: 8),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text("Prev")),
                    ElevatedButton(onPressed: () {}, child: Text("Next")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventBox extends StatelessWidget {
  final String url;

  EventBox(this.url);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage("$url"), fit: BoxFit.cover),
        ),
        child: Material(
          color: Colors.black.withOpacity(0.3),
          child: InkWell(
            splashColor: Colors.white.withOpacity(0.2),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EventPage()));
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Icon(Icons.location_on_outlined, size: 14, color: Colors.white),
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.white,
                      ),
                      Text(
                        "12-05-2021",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Webinar Pengembangan Aplikasi Yang Aman 123 456 7890",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  MyClipper();

  @override
  //Size adalah size widget yang akan dipotong, dalam kasus ini size image nya
  Path getClip(Size size) {
    // ignore: todo
    // TODO: implement getClip
    Path path = Path();

    //membuat line
    path.lineTo(0, size.height);

    //membuat line
    path.lineTo(size.width * 3 / 4, size.height);

    //membuat line
    path.lineTo(size.width / 2, 0);

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
