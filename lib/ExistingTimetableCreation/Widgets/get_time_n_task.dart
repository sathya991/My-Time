import 'package:MyTime/ExistingTimetableCreation/Screens/existing_creation_head_screen.dart';
import 'package:MyTime/utilities/basic_utilities.dart';
import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

class GetTimeNTaskWidget extends StatefulWidget {
  const GetTimeNTaskWidget({
    Key? key,
    this.ttid,
    this.ttName,
    required this.times,
    required this.docId,
  }) : super(key: key);
  final ttid;
  final ttName;
  final List times;
  final docId;
  @override
  State<GetTimeNTaskWidget> createState() => _GetTimeNTaskWidgetState();
}

class _GetTimeNTaskWidgetState extends State<GetTimeNTaskWidget> {
  TimeOfDay a = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay b = const TimeOfDay(hour: 2, minute: 0);
  String taskName = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  // addTimes() async {
  //   var timesList = [];
  //   for (int i = 0; i < widget.times.length; i++) {
  //     timesList.add([
  //       widget.times[i][0].toString().substring(10, 15),
  //       widget.times[i][1].toString().substring(10, 15)
  //     ]);
  //   }
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(BasicUtilities().curUser()!.uid)
  //       .collection('timetables')
  //       .doc(widget.ttid)
  //       .collection('times')
  //       .add({'times': timesList}).then((value) {
  //     Navigator.of(context).pop();
  //   });
  // }

  addTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool notOverlap = true;
      for (int i = 0; i < widget.times.length; i++) {
        if ((BasicUtilities().toMinutes(a) >
                    BasicUtilities().toMinutes(widget.times[i][0]) &&
                BasicUtilities().toMinutes(a) <
                    BasicUtilities().toMinutes(widget.times[i][1])) ||
            (BasicUtilities().toMinutes(b) >
                    BasicUtilities().toMinutes(widget.times[i][0]) &&
                BasicUtilities().toMinutes(b) <
                    BasicUtilities().toMinutes(widget.times[i][1])) ||
            (BasicUtilities().toMinutes(widget.times[i][0]) >
                    BasicUtilities().toMinutes(a) &&
                BasicUtilities().toMinutes(widget.times[i][0]) <
                    BasicUtilities().toMinutes(b)) ||
            (BasicUtilities().toMinutes(widget.times[i][1]) >
                    BasicUtilities().toMinutes(a) &&
                BasicUtilities().toMinutes(widget.times[i][1]) <
                    BasicUtilities().toMinutes(b))) {
          notOverlap = false;
        }
      }
      if (notOverlap) {
        if (widget.docId != '') {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(LoginSignupUtilities().curUser!.uid)
              .collection('timetables')
              .doc(widget.ttid)
              .collection('tasks')
              .doc(widget.docId)
              .update({
            taskName: [
              a.toString().substring(10, 15),
              b.toString().substring(10, 15)
            ]
          }).then((value) {
            widget.times.add([a, b]);
            Navigator.of(context).pushReplacementNamed(
                ExistingCreationHeadScreen.existingCreationHeadScreenRoute,
                arguments: {
                  'name': widget.ttName,
                  'id': widget.ttid,
                  'times': widget.times,
                  'docId': widget.docId,
                });
          });
        } else {
          var curTaskId = "";
          await FirebaseFirestore.instance
              .collection('users')
              .doc(LoginSignupUtilities().curUser!.uid)
              .collection('timetables')
              .doc(widget.ttid)
              .collection('tasks')
              .add({
            taskName: [
              a.toString().substring(10, 15),
              b.toString().substring(10, 15)
            ]
          }).then((value) {
            curTaskId = value.id;
            widget.times.add([a, b]);
            Navigator.of(context).pushReplacementNamed(
                ExistingCreationHeadScreen.existingCreationHeadScreenRoute,
                arguments: {
                  'name': widget.ttName,
                  'id': widget.ttid,
                  'times': widget.times,
                  'docId': value.id,
                });
          }).then((value) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(LoginSignupUtilities().curUser!.uid)
                .collection('timetables')
                .doc(widget.ttid)
                .set({'taskId': curTaskId, 'name': widget.ttName});
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Your time intervals are overlapping with other tasks.")));
      }
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
              start: const TimeOfDay(hour: 0, minute: 0),
              end: const TimeOfDay(hour: 2, minute: 0),
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
              use24HourFormat: true,
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
            onPressed: () {
              Navigator.of(context).pop();
            },
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
