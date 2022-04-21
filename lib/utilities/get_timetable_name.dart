import 'package:MyTime/ExistingTimetableCreation/Screens/existing_creation_head_screen.dart';
import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetTimetableName extends StatelessWidget {
  static const getTTnameRoute = '/get-tt-name';
  const GetTimetableName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String ttName = "";

    sendToDB() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(LoginSignupUtilities().curUser!.uid)
            .collection('timetables')
            .add({'name': ttName}).then((value) {
          Navigator.of(context).pushReplacementNamed(
              ExistingCreationHeadScreen.existingCreationHeadScreenRoute,
              arguments: {'name': ttName, 'id': value.id});
        });
      }
    }

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/background.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/MyTime.png',
                      height: 100,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 200,
              ),
              Text("Lets give a name to your Timetable",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(0, 4, 40, 1),
                        Color.fromRGBO(0, 78, 146, 1)
                      ]),
                      border: Border.all(width: 2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 20),
                      decoration: LoginSignupUtilities()
                          .constantThemeWithDarkBG("My Timetable"),
                      validator: (txt) =>
                          LoginSignupUtilities().ttNameValidate(txt!),
                      onSaved: (txt) => ttName = txt!,
                    ),
                  ),
                ),
              ),
              LoginSignupUtilities().styleButton(ElevatedButton(
                  onPressed: sendToDB,
                  child: Text(
                    "Looks good",
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500, fontSize: 20),
                  )))
            ],
          ),
        ),
      ),
    ));
  }
}
