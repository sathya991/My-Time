import 'package:MyTime/ExistingTimetableCreation/Screens/existing_creation_head_screen.dart';
import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

class GetTimeNTaskWidget extends StatefulWidget {
  const GetTimeNTaskWidget({Key? key, this.ttid, this.ttName})
      : super(key: key);
  final ttid;
  final ttName;
  @override
  State<GetTimeNTaskWidget> createState() => _GetTimeNTaskWidgetState();
}

class _GetTimeNTaskWidgetState extends State<GetTimeNTaskWidget> {
  TimeOfDay a = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay b = const TimeOfDay(hour: 0, minute: 0);
  String taskName = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  addTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(LoginSignupUtilities().curUser!.uid)
          .collection('timetables')
          .doc(widget.ttid)
          .collection('tasks')
          .doc()
          .set({
        taskName: [a.toString(), b.toString()]
      });
      Navigator.of(context).pushReplacementNamed(
          ExistingCreationHeadScreen.existingCreationHeadScreenRoute,
          arguments: {'name': widget.ttName, 'id': widget.ttid});
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          Text(
            "Add a task",
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Pick a time",
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: TimeRangePicker(
              labels: [
                "12 AM",
                "3 AM",
                "6 AM",
                "9 AM",
                "12 PM",
                "3 PM",
                "6 PM",
                "9 PM"
              ].asMap().entries.map((e) {
                return ClockLabel.fromIndex(
                    idx: e.key, length: 8, text: e.value);
              }).toList(),
              strokeColor: const Color.fromRGBO(0, 4, 40, 1),
              handlerColor: const Color.fromRGBO(0, 78, 146, 1),
              labelOffset: 35,
              rotateLabels: false,
              labelStyle: GoogleFonts.rubik(
                  fontStyle: FontStyle.italic,
                  color: const Color.fromRGBO(0, 78, 146, 1),
                  fontSize: 15),
              strokeWidth: 8,
              handlerRadius: 8,
              ticksWidth: 2,
              ticks: 8,
              hideTimes: true,
              hideButtons: true,
              snap: true,
              onStartChange: (aa) {
                setState(() {
                  a = aa;
                });
              },
              onEndChange: (bb) {
                setState(() {
                  b = bb;
                });
              },
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 25,
                width: 70,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(0, 4, 40, 1),
                      Color.fromRGBO(0, 78, 146, 1)
                    ]),
                    border: Border.all(width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Text(
                  formatTimeOfDay(a),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 15),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text("To",
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  )),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 25,
                width: 70,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(0, 4, 40, 1),
                      Color.fromRGBO(0, 78, 146, 1)
                    ]),
                    border: Border.all(width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Text(
                  formatTimeOfDay(b),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(0, 4, 40, 1),
                    Color.fromRGBO(0, 78, 146, 1)
                  ]),
                  border: Border.all(width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 20),
                  decoration: LoginSignupUtilities()
                      .constantThemeWithDarkBG("Task name"),
                  validator: (txt) =>
                      LoginSignupUtilities().ttNameValidate(txt!),
                  onSaved: (txt) => taskName = txt!,
                ),
              ),
            ),
          ),
          LoginSignupUtilities().styleButton(ElevatedButton(
              onPressed: addTask,
              child: Text(
                "Add task",
                style: GoogleFonts.rubik(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ))),
          TextButton(
            onPressed: () {},
            child: Text(
              "That's it for now",
              style: GoogleFonts.rubik(
                color: const Color.fromRGBO(39, 67, 140, 1),
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
