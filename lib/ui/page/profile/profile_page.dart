import 'package:event_app/model/peserta_event.dart';
import 'package:event_app/ui/page/profile/profile_settings.dart';
import 'package:event_app/ui/widget/widgets.dart';

import 'package:event_app/ui/page/page_widgets.dart';
import 'package:flutter/material.dart';

import '../../../global_variables.dart';

enum ProfileSettings {
  changeProfile,
  changePassword,
}

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  Widget eventsWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Online yang ${currentUser.hakAkses == 'organizer' ? 'Dikelola' : 'Diikuti'}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          FutureBuilder(
            future: PesertaEvent.getAllPesertaEvent(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircularProgressIndicator(),
                ));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  DateTime time = DateTime.parse(snapshot.data[index]['tanggal']);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data[index]['eventName']} (${time.day}-${time.month}-${time.year})",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            currentUser.hakAkses == "peserta" ? 
                            "Status: ${snapshot.data[index]['status_hadir'] == '1' ? 'Telah Hadir' : 'Telah Datang'}"
                            :
                            "Status: ${snapshot.data[index]['is_done'] == '1' ? 'SELESAI' : snapshot.data[index]['is_released'] == '1' ? 'Telah Dipublikasikan' : 'Baru'}"
                            ,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PageAppBar.init([
        PopupMenuButton(
          onSelected: (ProfileSettings result) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (result == ProfileSettings.changeProfile)
                    ? UserSettings()
                    : PasswordSettings(),
              ),
            );
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<ProfileSettings>>[
            PopupMenuItem<ProfileSettings>(
              value: ProfileSettings.changeProfile,
              child: Text("Pengaturan Profil"),
            ),
            PopupMenuItem<ProfileSettings>(
              value: ProfileSettings.changePassword,
              child: Text("Ubah Password"),
            ),
          ],
        )
      ]),
      body: SingleChildScrollView(
        //physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageInfo(
              title: currentUser.nama,
              description:
                  "${currentUser.pekerjaan} di ${currentUser.institusi}",
              imageUrl: "${currentUser.imageUrl}",
              borderRadius: (getScreenWidth(context) / 4),
            ),
            eventsWidget(),
          ],
        ),
      ),
    );
  }
}
