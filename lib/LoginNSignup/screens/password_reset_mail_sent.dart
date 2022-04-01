import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utilities/login_signup_utilities.dart';

class PasswordResetMailSent extends StatelessWidget {
  const PasswordResetMailSent({Key? key}) : super(key: key);
  static const String passwordResetDoneRoute = '/password-reset-done';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 100, 25, 35),
          child: Column(
            children: [
              Text("Email has been sent!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500, fontSize: 25)),
              const SizedBox(
                height: 10,
              ),
              Text("Please check your registered email to reset your Password",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      color: const Color.fromRGBO(131, 142, 161, 1))),
              const SizedBox(
                height: 10,
              ),
              Image.asset('assets/gifs/emailsent.gif'),
              const SizedBox(
                height: 15,
              ),
              LoginSignupUtilities().styleButton(ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )),
            ],
          ),
        ),
      )),
    );
  }
}
