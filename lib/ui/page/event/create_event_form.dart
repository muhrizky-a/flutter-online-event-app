import 'package:event_app/controller/page/event/create_event_form_controller.dart';
import 'package:event_app/ui/page/page_widgets.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateEventForm extends StatefulWidget {
  @override
  _CreateEventFormState createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _descriptionController =
      new TextEditingController();
  final TextEditingController _eventUrlController = new TextEditingController();

  /// Tanggal sekarang + 1 hari & jam sekarang.
  DateTime selectedDate = DateTime.now().add(new Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay.now();

  void handleCreateEvent() {
    createEventProcess(
      context,
      _nameController.text,
      _descriptionController.text,
      "${selectedDate.year}-${selectedDate.month}-${selectedDate.day} ${selectedTime.hour}:${selectedTime.minute}:00",
      _eventUrlController.text,
    );
  }

  _selectDateAndTime(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate:
          DateTime(now.year, now.month, now.day).add(new Duration(days: 1)),
      lastDate: DateTime(now.year + 1),
      helpText: 'Tentukan Jadwal Event', // Can be used as title
      cancelText: 'Kembali',
      confirmText: 'Simpan',
    );
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });

    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      helpText: 'Tentukan Waktu Event', // Can be used as title
      cancelText: 'Kembali',
      confirmText: 'Simpan',
    );
    if (pickedTime != null)
      setState(() {
        selectedTime = pickedTime;
      });
  }

  Widget dateChooser() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Icon(
              Icons.date_range,
              color: primaryColor,
            ),
            SizedBox(
              width: 16,
            ),
            Column(children: [
              Text(
                "Tanggal Event: ",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
              ),
              Text(
                "${selectedDate.day}-${selectedDate.month}-${selectedDate.year} ${selectedTime.hour}:${selectedTime.minute}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, color: primaryColor),
              ),
            ]),
            Spacer(),
            ElevatedButton(
              onPressed: () => _selectDateAndTime(context), // Refer step 3
              child: Text(
                'Ubah...',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
              ),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.blue.shade400,
                primary: Colors.white,
                elevation: 2,
                side: BorderSide(color: Colors.blue.shade400, width: 2),
                padding: EdgeInsets.all(5),
              ),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getScreenHeight(context) / 4),
        child: AppBar(
          title: Text("Buat Event Online Baru"),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: ClipPath(
            clipper: EventFormClipper(),
            child: Container(
              color: primaryColor.withOpacity(0.75),
              width: getScreenWidth(context),
              height: getScreenHeight(context) / 4,
            ),
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
                padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                child: Column(
                  children: <Widget>[
                    FormTextField("Nama Event Online", Icons.event,
                        _nameController, false),
                    dateChooser(),
                    FormTextField(
                        "URL Event", Icons.link, _eventUrlController, false),
                    SizedBox(
                      height: 40,
                    ),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        icon: Icon(Icons.description, color: primaryColor),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2)),
                        labelText: "Deskripsi",
                        labelStyle: TextStyle(color: primaryColor),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 40,
                margin: EdgeInsets.only(bottom: 30),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.white.withOpacity(0.5),
                    onTap: handleCreateEvent,
                    child: Center(
                      child: Text("SIMPAN",
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
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
