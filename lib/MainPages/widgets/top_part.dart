import 'dart:io';

import 'package:MyTime/MainPages/widgets/image_part.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class TopPartWidget extends StatefulWidget {
  const TopPartWidget({Key? key}) : super(key: key);
  @override
  State<TopPartWidget> createState() => _TopPartWidgetState();
}

class _TopPartWidgetState extends State<TopPartWidget> {
  String _userName = "";
  String profPic = "";
  String curUserUID = "";
  String textToShow = "";
  getUserNameNProfPic() {
    setState(() {
      curUserUID = FirebaseAuth.instance.currentUser!.uid;
    });
    return FirebaseFirestore.instance.collection('users').doc(curUserUID).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: getUserNameNProfPic(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          _userName = snapshot.data?.get('username');

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/topBentSolid.png',
                        fit: BoxFit.fill,
                      )),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Image.asset(
                          'assets/images/MyTime.png',
                          height: 80,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hey, $_userName",
                                style: GoogleFonts.rubik(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.1,
                                    fontSize: 20),
                              ),
                              Text("Here are your timetables and stats",
                                  style: GoogleFonts.rubik(
                                      color: const Color.fromRGBO(
                                          131, 142, 161, 1),
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15))
                            ],
                          ),
                          const ImagePart()
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }
}
