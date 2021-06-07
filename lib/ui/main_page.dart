import 'package:event_app/global_variables.dart';
import 'package:event_app/model/event.dart';
import 'package:event_app/model/peserta_event.dart';
import 'package:event_app/ui/page/event/create_event_form.dart';
import 'package:event_app/ui/page/event/event_page.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final double gap = 20;

  Widget eventWidget = SliverToBoxAdapter(child: SizedBox());

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    handleSearchEvent('');
  }

  void handleSearchEvent(String name) {
    eventWidget = SliverToBoxAdapter(child: SizedBox());
    setState(() {});

    Event.searchEvent(name).then((result) {
      eventWidget = (result.length != 0)
          ? createEventGrid(result)
          : emptyEventWidget(context, "Tidak Ada Event.", Icons.event_busy);
    }).catchError((e) {
      print("Error : $e");
      eventWidget = emptyEventWidget(
          context, "Terjadi Kesalahan.\nMohon Coba Lagi.", Icons.error_outline);
    }).whenComplete(() {
      setState(() {});
    });
  }

  Widget createEventGrid(List<dynamic> events) {
    //List Event dalam grid
    return SliverPadding(
      padding: EdgeInsets.all(gap),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: gap,
          crossAxisSpacing: gap,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return EventBox(events[index]);
          },
          childCount: events.length,
        ),
      ),
    );
  }

  Widget emptyEventWidget(
      BuildContext context, String message, IconData iconData) {
    bool organizerConditionTrue =
        (currentUser.hakAkses == "organizer") && (iconData == Icons.event_busy);
    String buttonText = organizerConditionTrue ? "Buat Event Baru" : "";
    Function buttonEvent = () {
      organizerConditionTrue
          ? Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateEventForm()))
          : handleSearchEvent("");
    };

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: getScreenWidth(context) - 40 - 60,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue.shade400,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Icon(iconData,
                  color: Colors.black54,
                  size: screenWidthSmallerThanScreenHeight(context)
                      ? getScreenWidth(context) / 2
                      : getScreenHeight(context) / 2),
              Text(
                message,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: (currentUser.hakAkses == "organizer") ? 40 : 0),
              organizerConditionTrue
                  ? ElevatedButton(
                      onPressed: buttonEvent,
                      child: Text(
                        buttonText,
                        style: TextStyle(fontSize: 20, color: primaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.blue.shade400,
                        primary: Colors.white,
                        minimumSize: Size(getScreenWidth(context) - 20, 40),
                        elevation: 5,
                        side: BorderSide(color: Colors.blue.shade400, width: 2),
                        padding: EdgeInsets.all(20),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      body: Center(
        child: CustomScrollView(
          slivers: [
            //AppBar
            SliverAppBar(
              backgroundColor: primaryColor,
              pinned: true,
              expandedHeight: (getScreenHeight(context) / 2) * 0.9,
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
                        color: primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 20, 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: getScreenWidth(context) / 2,
                                child: Text(
                                  "Online Event App",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                width: getScreenWidth(context) / 2,
                                child: Text(
                                    currentUser.hakAkses == "organizer"
                                        ? "Kelola Event Online Yang Anda Selenggarakan"
                                        : "Temukan Event Online Yang Ingin Anda Ikuti Disini",
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

            //Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(gap),
                child: Row(
                  children: [
                    Container(
                      width: getScreenWidth(context) - 40 - 60,
                      child: TextField(
                        controller: controller,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          hintText: "Cari event...",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2)),
                          labelStyle: TextStyle(color: primaryColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        handleSearchEvent(controller.text);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(60, 60),
                        primary: primaryColor,
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Berisi widget event grid, atau widget yang menjadi penanda tidak adanya event.
            eventWidget,
          ],
        ),
      ),
    );
  }
}

class EventBox extends StatelessWidget {
  final Map<String, dynamic> event;

  EventBox(this.event);

  @override
  Widget build(BuildContext context) {
    DateTime eventDate = DateTime.parse(event['tanggal']);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(event['image_url']), fit: BoxFit.cover),
        ),
        child: Material(
          color: Colors.black.withOpacity(0.7),
          child: InkWell(
            splashColor: Colors.white.withOpacity(0.2),
            onTap: () {
              Event.getEvent(event['id']).then((value) {
                if (currentUser.hakAkses == "peserta") {
                  PesertaEvent.getPesertaEvent(event['id']).then((result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EventPage(value, pesertaEvent: result)));
                  }).catchError((e) {
                    showToast("Terjadi kesalahan. Mohon coba lagi.");
                  });
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventPage(value)));
                }
              }).catchError((e) {
                showToast("Terjadi kesalahan. Mohon coba lagi.");
              });
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
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
                          SizedBox(width: 5),
                          Text(
                            "${eventDate.day}-${eventDate.month}-${eventDate.year}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        event['nama'],
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
                (event['is_done'] == '1')
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(3)),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(left: 1, bottom: 1),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(3)),
                          ),
                          child: Text(
                            "SELESAI",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
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
