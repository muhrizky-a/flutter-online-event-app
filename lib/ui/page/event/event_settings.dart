import 'package:event_app/controller/page/event/event_settings_controller.dart';
import 'package:event_app/ui/widget/widgets.dart';
import 'package:flutter/material.dart';
import '../page_widgets.dart';

class EventSettings extends StatefulWidget {
  final Map<String, dynamic> eventData;
  EventSettings(this.eventData);

  @override
  _EventSettingsState createState() => _EventSettingsState(eventData);
}

class _EventSettingsState extends State<EventSettings> {
  final Map<String, dynamic> eventData;
  _EventSettingsState(this.eventData);

  TextEditingController _nameController;
  TextEditingController _eventUrlController;
  TextEditingController _descriptionController;
  bool isPopupShowed = false;
  DateTime selectedDate;
  TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController(text: widget.eventData['nama']);

    selectedDate = DateTime.parse(widget.eventData['tanggal']);
    selectedTime = TimeOfDay.fromDateTime(selectedDate);
    _eventUrlController =
        new TextEditingController(text: widget.eventData['event_url']);
    _descriptionController =
        new TextEditingController(text: widget.eventData['deskripsi']);
  }

  void handleUpdateEvent() {
    updateEventProcess(
      context,
      widget.eventData['id'],
      _nameController.text,
      _descriptionController.text,
      "${selectedDate.year}-${selectedDate.month}-${selectedDate.day} ${selectedTime.hour}:${selectedTime.minute}:00",
      _eventUrlController.text,
    );
  }

  void handleDeleteEvent() {
    deleteEventProcess(
      context,
      widget.eventData['id'],
    );
  }

  _selectDateAndTime(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate:
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
      lastDate: DateTime(selectedDate.year + 1),
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
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Pengaturan Event"),
        actions: [
          ElevatedButton(
            onPressed: () {
              isPopupShowed = !isPopupShowed;
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
            ),
            child: Text("Hapus Event"),
          )
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
                  _CustomTextField("Nama", _nameController, false),
                  dateChooser(),
                  _CustomTextField("URL", _eventUrlController, false),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: primaryColor, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: primaryColor, width: 2)),
                      labelText: "Deskripsi",
                      labelStyle: TextStyle(color: primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _SaveButton(
                    action: handleUpdateEvent,
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
        "Anda yakin ingin menghapus event ini?",
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
            onPressed: handleDeleteEvent,
            child: Text(
              "Hapus Event",
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
