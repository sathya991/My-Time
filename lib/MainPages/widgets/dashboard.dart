import 'dart:async';

import 'package:MyTime/MainPages/widgets/text_button_column.dart';
import 'package:MyTime/TimetableView/Screens/timetable_view.dart';
import 'package:MyTime/utilities/basic_utilities.dart';
import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String dashboardRoute = '/dashboard-route';
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String curTT = "No Preferred Timetable yet";
  var ttId = "";
  var ttTaskId = "";
  String curTask = "You have no task right now!";
  getCurTT() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtilities().curUser()!.uid)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          ttId = value.get('curTT');
        });
      }
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(BasicUtilities().curUser()!.uid)
          .collection('timetables')
          .doc(ttId)
          .get()
          .then((value) {
        if (mounted) {
          setState(() {
            curTT = value.get('name');
            ttTaskId = value.get('taskId');
            showTask();
          });
        }
      });
    });
  }

  openTT() {
    Navigator.of(context).pushNamed(TimetableView.timetableViewRoute,
        arguments: {'taskId': ttTaskId, 'id': ttId, 'name': curTT});
  }

  showTask() {
    if (ttId != "") {
      FirebaseFirestore.instance
          .collection('users')
          .doc(BasicUtilities().curUser()!.uid)
          .collection('timetables')
          .doc(ttId)
          .collection('tasks')
          .doc(ttTaskId)
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          var v1 = BasicUtilities().stringToTime(value[0]);
          var v2 = BasicUtilities().stringToTime(value[1]);
          var curTime = TimeOfDay.now();
          if (BasicUtilities().toMinutes(curTime) >=
                  BasicUtilities().toMinutes(v1) &&
              BasicUtilities().toMinutes(curTime) <=
                  BasicUtilities().toMinutes(v2)) {
            if (mounted) {
              setState(() {
                curTask = key.toString();
              });
            }
          }
        });
      });
    }
  }

  Timer? timer;
  showStreak() {}
  @override
  void initState() {
    getCurTT();
    timer =
        Timer.periodic(const Duration(seconds: 30), (Timer t) => getCurTT());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButtonColumnWidget(
            topText: "Current Timetable",
            buttonText: curTT,
            icon: FontAwesomeIcons.arrowUpRightFromSquare,
            func: openTT,
          ),
          const SizedBox(
            height: 50,
          ),
          TextButtonColumnWidget(
            topText: "Current Task",
            buttonText: curTask,
            icon: FontAwesomeIcons.arrowUpRightFromSquare,
            func: showTask,
          ),
          const SizedBox(
            height: 50,
          ),
          TextButtonColumnWidget(
            topText: "Streak",
            buttonText: "7-day Streak",
            icon: FontAwesomeIcons.arrowRight,
            func: showStreak,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(21, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 30,
                width: 120,
                child: LoginSignupUtilities().styleRoundedButton(ElevatedButton(
                  onPressed: () async {
                    await Share.share(
                        "Hey there I have a 7-day streak of completing my tasks on MyTime.");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.shareNodes,
                        size: 18,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text("Share"),
                    ],
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
