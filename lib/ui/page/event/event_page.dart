import 'package:event_app/controller/page/event/event_page_controller.dart';
import 'package:event_app/ui/page/event/event_settings.dart';
import 'package:event_app/ui/page/page_widgets.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../global_variables.dart';

// ignore: must_be_immutable
class EventPage extends StatefulWidget {
  final Map<String, dynamic> eventInfo;
  Map<String, dynamic> pesertaEvent;

  EventPage(this.eventInfo, {this.pesertaEvent});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool isPopupShowed = false;

  void togglePopUp() {
    isPopupShowed = !isPopupShowed;
    setState(() {});
  }

  Widget handleRegisterPesertaEvent() {
    (widget.pesertaEvent != null)
        ? deletePesertaEventProcess(context, widget.eventInfo['id'])
        : addPesertaEventProcess(context, widget.eventInfo['id']);
    return SizedBox();
  }

  Widget buttonBehaviourCondition(
      DateTime eventDate, String isEventReleased, String isEventDone) {
    switch (currentUser.hakAkses) {
      case "peserta":
        return isUserCanJoin(eventDate, isEventDone, widget.pesertaEvent)
            ? showJoinEventPopup()
            : handleRegisterPesertaEvent();
        break;
      case "organizer":
        return showManagedEventActionPopup(
            isEventReleased == '0' ? 'publikasi' : 'selesai');
        break;
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    String eventDate = widget.eventInfo['tanggal'];
    DateTime eventDateTime = DateTime.parse(eventDate);
    bool isButtonAvailable = buttonAvailableCondition(
        eventDateTime,
        widget.eventInfo['is_released'],
        widget.eventInfo['is_done'],
        widget.pesertaEvent);
    bool isPesertaEventExists = (widget.pesertaEvent != null);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          //Halaman Page
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brosur, Judul Event
                PageInfo(
                  title: widget.eventInfo[
                      'nama'], //"Pengembangan Aplikasi Yang Aman 1234567890",
                  description:
                      "Diselenggarakan oleh ${widget.eventInfo['organizer_name']}",
                  imageUrl: "${widget.eventInfo['image_url']}",
                ),

                //Deskripsi Event
                PageDetail(
                  title: "Deskripsi",
                  description: widget.eventInfo['deskripsi'],
                ),
                SizedBox(height: 20),
                Divider(),

                //Deskripsi Event
                PageDetail(
                    title: "Jadwal Pelaksanaan",
                    description:
                        "Tanggal : ${eventDateTime.day < 10 ? "0" + eventDateTime.day.toString() : eventDateTime.day}-${eventDateTime.month < 10 ? "0" + eventDateTime.month.toString() : eventDateTime.month}-${eventDateTime.year}, ${eventDateTime.hour < 10 ? "0" + eventDateTime.hour.toString() : eventDateTime.hour}:${eventDateTime.minute < 10 ? "0" + eventDateTime.minute.toString() : eventDateTime.minute} WITA ${int.parse(widget.eventInfo['is_done']) == 1 ? '(SELESAI)' : ''}"),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 80),
              ],
            ),
          ),

          //AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PageAppBar.init([
              int.parse(widget.eventInfo['is_released']) == 0
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EventSettings(widget.eventInfo)));
                      },
                      iconSize: 30,
                    )
                  : SizedBox(),
            ]),
          ),

          //Button Daftar/Batalkan Event
          isButtonAvailable
              ? Positioned(
                  bottom: 20,
                  child: ElevatedButton(
                    onPressed: togglePopUp,
                    child: Text(
                      buttonTextCondition(
                          eventDateTime,
                          widget.eventInfo['is_released'],
                          widget.eventInfo['is_done'],
                          widget.pesertaEvent),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: isPesertaEventExists &&
                              !isRegistrationClosed(eventDateTime)
                          ? Colors.red.shade800
                          : Colors.blue.shade800,
                      minimumSize: Size(getScreenWidth(context) - 20, 40),
                      animationDuration: Duration(seconds: 1),
                      elevation: 2,
                      side: BorderSide(
                          color: isPesertaEventExists &&
                                  !isRegistrationClosed(eventDateTime)
                              ? Colors.red.shade200
                              : Colors.blue.shade200,
                          width: 2),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                )
              : SizedBox(),

          //Popup
          //isPopupShowed ? showRegisterEventPopup() : SizedBox(),
          isPopupShowed
              ? buttonBehaviourCondition(eventDateTime,
                  widget.eventInfo['is_released'], widget.eventInfo['is_done'])
              : SizedBox(),
        ],
      ),
    );
  }

  Widget showJoinEventPopup() {
    return PagePopup(
      children: [
        Icon(Icons.event_available,
            color: primaryColor,
            size: screenWidthSmallerThanScreenHeight(context)
                ? getScreenWidth(context) / 2
                : getScreenHeight(context) / 2),
        Text(
          "Anda akan bergabung ke event: ",
        ),
        Text(
          widget.eventInfo['nama'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: getScreenHeight(context) * 0.05),
        Text(
          "Status kehadiran anda akan diperbarui setelah event berakhir.",
        ),
        SizedBox(height: getScreenHeight(context) * 0.05),
        ElevatedButton(
          onPressed: () {
            togglePopUp();
            launch(widget.eventInfo['event_url']);

            updatePesertaEventStatusProcess(context, widget.eventInfo['id']);
          },
          child: Text("Bergabung ke Event"),
        ),
      ],
    );
  }

  Widget showManagedEventActionPopup(String action) {
    return PagePopup(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Icon(Icons.calendar_today,
                color: primaryColor,
                size: screenWidthSmallerThanScreenHeight(context)
                    ? getScreenWidth(context) / 2
                    : getScreenHeight(context) / 2),
            Column(
              children: [
                SizedBox(
                    height: screenWidthSmallerThanScreenHeight(context)
                        ? getScreenWidth(context) / 8
                        : getScreenHeight(context) / 8),
                Icon(action == 'publikasi' ? Icons.public : Icons.check,
                    color: primaryColor,
                    size: screenWidthSmallerThanScreenHeight(context)
                        ? getScreenWidth(context) / 4
                        : getScreenHeight(context) / 4),
              ],
            ),
          ],
        ),
        Text(
          action == 'publikasi'
              ? "Anda yakin ingin mempublikasikan event ini?"
              : "Anda yakin ingin tandai event ini sebagai 'Selesai'?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            updateEventStatusProcess(context, widget.eventInfo['id'], action);
            togglePopUp();
          },
          child: Text(
            action == 'publikasi'
                ? "Publikasi Event"
                : "Tandai Sebagai Selesai",
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue.shade800,
            padding: EdgeInsets.all(20),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: togglePopUp,
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
      ],
    );
  }
}
