import 'package:MyTime/MainPages/widgets/text_button_column.dart';
import 'package:MyTime/TimetableView/Screens/timetable_view.dart';
import 'package:MyTime/utilities/login_signup_utilities.dart';
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
  openTT() {
    Navigator.of(context).pushNamed(TimetableView.timetableViewRoute);
  }

  showTask() {}
  showStreak() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButtonColumnWidget(
            topText: "Current Timetable",
            buttonText: "My first timetable",
            icon: FontAwesomeIcons.arrowUpRightFromSquare,
            func: openTT,
          ),
          const SizedBox(
            height: 50,
          ),
          TextButtonColumnWidget(
            topText: "Current Task",
            buttonText: "Current task",
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