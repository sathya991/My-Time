import 'package:MyTime/MainPages/widgets/timetables.dart';
import 'package:MyTime/MainPages/widgets/text_button_column.dart';
import 'package:MyTime/MainPages/widgets/top_part.dart';
import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String dashboardRoute = '/dashboard-route';
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TextButtonColumnWidget(
            topText: "Current Timetable",
            buttonText: "My first timetable",
            icon: FontAwesomeIcons.arrowUpRightFromSquare,
          ),
          const SizedBox(
            height: 50,
          ),
          const TextButtonColumnWidget(
            topText: "Current Task",
            buttonText: "Current task",
            icon: FontAwesomeIcons.arrowUpRightFromSquare,
          ),
          const SizedBox(
            height: 50,
          ),
          const TextButtonColumnWidget(
            topText: "Streak",
            buttonText: "7-day Streak",
            icon: FontAwesomeIcons.arrowRight,
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
                  onPressed: () {},
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
