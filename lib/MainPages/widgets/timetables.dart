import 'package:flutter/material.dart';

class TimetablesScreen extends StatefulWidget {
  static const timetablesRoute = '/timetables-route';
  const TimetablesScreen({Key? key}) : super(key: key);

  @override
  State<TimetablesScreen> createState() => _TimetablesScreenState();
}

class _TimetablesScreenState extends State<TimetablesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is the timetables screen"),
    );
  }
}
