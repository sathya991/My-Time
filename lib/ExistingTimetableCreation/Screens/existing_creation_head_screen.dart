import 'package:MyTime/ExistingTimetableCreation/Widgets/get_time_n_task.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExistingCreationHeadScreen extends StatefulWidget {
  static const existingCreationHeadScreenRoute =
      '/existing-creation-head-screen';
  const ExistingCreationHeadScreen({Key? key}) : super(key: key);

  @override
  State<ExistingCreationHeadScreen> createState() =>
      _ExistingCreationHeadScreenState();
}

class _ExistingCreationHeadScreenState
    extends State<ExistingCreationHeadScreen> {
  @override
  Widget build(BuildContext context) {
    Map vals = ModalRoute.of(context)!.settings.arguments as Map;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/background.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 70, 0, 40),
                  child: Text(vals['name'],
                      style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic)),
                ),
              ],
            ),
            GetTimeNTaskWidget(
              ttid: vals['id'],
              ttName: vals['name'],
            ),
          ],
        ),
      ),
    ));
  }
}
