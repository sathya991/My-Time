import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EachTaskDisplay extends StatelessWidget {
  const EachTaskDisplay({Key? key, this.firstTime, this.finalTime, this.task})
      : super(key: key);
  final firstTime;
  final finalTime;
  final task;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 1, 0),
              child: Text(firstTime,
                  style: GoogleFonts.rubik(
                      color: Colors.white, fontStyle: FontStyle.italic)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(90, 0, 20, 0),
          child: LoginSignupUtilities().styleButton(ElevatedButton(
              onPressed: () {},
              child: Text(task,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 17)))),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 1, 0),
              child: Text(finalTime,
                  style: GoogleFonts.rubik(
                      color: Colors.white, fontStyle: FontStyle.italic)),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
