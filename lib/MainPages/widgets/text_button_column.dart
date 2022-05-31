import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButtonColumnWidget extends StatelessWidget {
  final String topText;
  final String buttonText;
  final icon;
  final Function()? func;
  const TextButtonColumnWidget(
      {Key? key,
      required this.topText,
      required this.buttonText,
      required this.icon,
      this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topText,
            style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 10,
          ),
          LoginSignupUtilities().styleButton(ElevatedButton(
            onPressed: func,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  buttonText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15),
                ),
                FaIcon(icon)
              ],
            ),
          )),
        ],
      ),
    );
  }
}
