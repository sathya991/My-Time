import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration constantTheme(String text) {
      return InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(5, 10, 60, 1), width: 2.0)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: text);
    }

    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 100, 25, 35),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Register",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500, fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: constantTheme("Email"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: constantTheme("Phone"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: constantTheme("Password"),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: ShapeDecoration(
                    shape: shape,
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(0, 4, 40, 1),
                      Color.fromRGBO(0, 78, 146, 1)
                    ])),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Register",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
