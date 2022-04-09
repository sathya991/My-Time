import 'package:MyTime/MainPages/widgets/top_part.dart';
import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String dashboardRoute = '/dashboard-route';
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TopPartWidget(),
              const Text('Current Timetable'),
              LoginSignupUtilities().styleButton(ElevatedButton(
                onPressed: () {},
                child: const Text("My first Timetable"),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
