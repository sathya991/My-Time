import 'package:MyTime/LoginNSignup/screens/password_reset_mail_sent.dart';
import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static const String passwordResetRoute = '/password-reset-route';
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "";

  sendPasswordResetMail() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      Navigator.of(context)
          .pushReplacementNamed(PasswordResetMailSent.passwordResetDoneRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    double height1 = height - padding.top - padding.bottom;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height1,
          width: width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Forgot password?",
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500, fontSize: 25)),
                const SizedBox(
                  height: 10,
                ),
                Text("Enter your registered email below",
                    style: GoogleFonts.rubik(
                        color: const Color.fromRGBO(131, 142, 161, 1))),
                Image.asset('assets/gifs/emailwanted.gif'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (email) =>
                            LoginSignupUtilities().emailValidate(email!),
                        decoration:
                            LoginSignupUtilities().constantTheme("Email"),
                        onSaved: (email) {
                          _email = email!;
                        },
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                LoginSignupUtilities().styleButton(ElevatedButton(
                  onPressed: sendPasswordResetMail,
                  child: Text(
                    "Send",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Take me back to login",
                        style: TextStyle(
                            color: Color.fromRGBO(131, 142, 161, 1),
                            fontSize: 18))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
