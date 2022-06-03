import 'dart:collection';
import 'dart:ffi';

import 'package:MyTime/TimetableView/Widgets/eachtask_display.dart';
import 'package:MyTime/utilities/basic_utilities.dart';
import 'package:MyTime/utilities/get_timetable_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ExistingTimetableCreation/Screens/existing_creation_head_screen.dart';

class TimetableView extends StatefulWidget {
  static const String timetableViewRoute = '/time-table-view';
  const TimetableView({Key? key}) : super(key: key);

  @override
  State<TimetableView> createState() => _TimetableViewState();
}

class _TimetableViewState extends State<TimetableView> {
  var times = [];
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> argumentVals =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    getTTtimes() {
      FirebaseFirestore.instance
          .collection('users')
          .doc(BasicUtilities().curUser()!.uid)
          .collection('timetables')
          .doc(argumentVals['id'])
          .collection('tasks')
          .get()
          .then((value) {
        value.docs.first.data().forEach((key, value) {
          times.add([
            BasicUtilities().stringToTime(value[0]),
            BasicUtilities().stringToTime(value[1])
          ]);
        });
      });
    }

    addTask() {
      getTTtimes();
      Navigator.of(context).pushNamed(
          ExistingCreationHeadScreen.existingCreationHeadScreenRoute,
          arguments: {
            'name': argumentVals['name'],
            'id': argumentVals['id'],
            'times': times,
            'docId': argumentVals['taskId'],
          });
    }

    getTimetable() {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(BasicUtilities().curUser()!.uid)
          .collection('timetables')
          .doc(argumentVals['id'])
          .collection('tasks')
          .get();
    }

    return FutureBuilder<QuerySnapshot>(
        future: getTimetable(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Map haha = snapshot.data!.docs.first.data() as Map;
          List curTaskList = [];

          for (var element in haha.entries) {
            curTaskList.add({element.key: element.value});
          }
          curTaskList.sort(((a, b) {
            var ap = a.values.first;
            var bp = b.values.first;
            var x = BasicUtilities().toMinutes(TimeOfDay(
                hour: int.parse(ap[0].toString().substring(0, 2)),
                minute: int.parse(ap[0].toString().substring(3))));
            var y = BasicUtilities().toMinutes(TimeOfDay(
                hour: int.parse(bp[0].toString().substring(0, 2)),
                minute: int.parse(bp[0].toString().substring(3))));
            if (x < y) {
              return -1;
            }
            return 1;
          }));
          return Scaffold(
            floatingActionButton: FloatingActionButton.small(
              backgroundColor: Colors.black,
              child: const Icon(Icons.add),
              onPressed: addTask,
            ),
            backgroundColor: const Color.fromRGBO(9, 13, 51, 1),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(argumentVals['name'],
                            style: GoogleFonts.rubik(color: Colors.white)),
                        Text("Set as Current Timetable",
                            style: GoogleFonts.rubik(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      height: 660,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            child: Container(
                              height: 660,
                              width: 300,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10))),
                            ),
                          ),
                          ListView.builder(
                              itemCount: curTaskList.length,
                              itemBuilder: (context, index) {
                                return EachTaskDisplay(
                                  firstTime: curTaskList[index]
                                      .values
                                      .first[0]
                                      .toString(),
                                  finalTime: curTaskList[index]
                                      .values
                                      .first[1]
                                      .toString(),
                                  task:
                                      curTaskList[index].keys.first.toString(),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
