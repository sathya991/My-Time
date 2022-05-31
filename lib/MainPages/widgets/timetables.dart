import 'package:MyTime/ExistingTimetableCreation/Screens/existing_creation_head_screen.dart';
import 'package:MyTime/MainPages/widgets/text_button_column.dart';
import 'package:MyTime/TimetableView/Screens/timetable_view.dart';
import 'package:MyTime/utilities/get_timetable_name.dart';
import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TimetablesScreen extends StatefulWidget {
  static const timetablesRoute = '/timetables-route';
  const TimetablesScreen({Key? key}) : super(key: key);

  @override
  State<TimetablesScreen> createState() => _TimetablesScreenState();
}

class _TimetablesScreenState extends State<TimetablesScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  getTimetables() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('timetables')
        .snapshots();
  }

  deleteTT(String id) async {
    var docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('timetables')
        .doc(id);
    FirebaseFirestore.instance
        .runTransaction((transaction) async => transaction.delete(docRef));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text(
            "My Timetables",
            style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: getTimetables(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return SizedBox(
                  height: 220,
                  width: 380,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 100, 20, 10),
                    child: Text("No Timetables yet!! Create one below.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubik(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                  )),
                );
              }
              return SizedBox(
                height: 220,
                width: 380,
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          LoginSignupUtilities().styleButton(ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  TimetableView.timetableViewRoute,
                                  arguments: snapshot.data!.docs[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data!.docs[index].get('name'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 15),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      deleteTT(snapshot.data!.docs[index].id),
                                  child: const FaIcon(
                                    FontAwesomeIcons.trashCan,
                                  ),
                                )
                              ],
                            ),
                          )),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      );
                    }),
              );
            }),
        const SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LoginSignupUtilities().styleRoundedButton(ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(GetTimetableName.getTTnameRoute);
                },
                child: Text("Enter existing Timetable",
                    style: GoogleFonts.rubik()))),
            const SizedBox(
              height: 5,
            ),
            Text(
              "or",
              style: GoogleFonts.rubik(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            LoginSignupUtilities().styleRoundedButton(ElevatedButton(
                onPressed: () {},
                child:
                    Text("Create new Timetable", style: GoogleFonts.rubik()))),
          ],
        ),
      ],
    );
  }
}
