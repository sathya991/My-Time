import 'package:MyTime/MainPages/widgets/dashboard.dart';
import 'package:MyTime/MainPages/widgets/timetables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../widgets/top_part.dart';

class HeadScreen extends StatefulWidget {
  static const headScreenRoute = '/head-screen-route';
  const HeadScreen({Key? key}) : super(key: key);

  @override
  State<HeadScreen> createState() => _HeadScreenState();
}

class _HeadScreenState extends State<HeadScreen> {
  String checkRegister = "";
  Color selectColor = const Color.fromRGBO(0, 78, 146, 1);
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  var _curIndex = 0;
  List availableScreens = [const DashboardScreen(), const TimetablesScreen()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _curIndex == 0
            ? FloatingActionButton(
                backgroundColor: const Color.fromRGBO(0, 78, 146, 1),
                onPressed: _signOut,
                child: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
              )
            : null,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black, width: 0.2))),
          child: SalomonBottomBar(
              unselectedItemColor: const Color.fromRGBO(0, 4, 40, 1),
              onTap: (p0) {
                setState(() {
                  _curIndex = p0;
                });
              },
              currentIndex: _curIndex,
              items: [
                SalomonBottomBarItem(
                    icon: const FaIcon(FontAwesomeIcons.house),
                    title: const Text("Dashboard"),
                    selectedColor: selectColor),
                SalomonBottomBarItem(
                    icon: const FaIcon(FontAwesomeIcons.listCheck),
                    title: const Text("Timetales"),
                    selectedColor: selectColor)
              ]),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TopPartWidget(),
              availableScreens[_curIndex],
            ],
          ),
        ),
      ),
    );
  }
}
