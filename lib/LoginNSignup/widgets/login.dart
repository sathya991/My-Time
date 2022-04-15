import 'package:MyTime/LoginNSignup/screens/password_reset.dart';
import 'package:MyTime/MainPages/widgets/dashboard.dart';
import 'package:MyTime/MainPages/screens/headscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utilities/login_signup_utilities.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _email = "";
    String _password = "";

    validateNSignin() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _email.trim(), password: _password.trim())
            .then((value) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              HeadScreen.headScreenRoute, ModalRoute.withName('/'),
              arguments: "Login");
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 50, 25, 35),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Login",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500, fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: LoginSignupUtilities().constantTheme("Email"),
                validator: (txt) => LoginSignupUtilities().emailValidate(txt!),
                onSaved: (txt) => _email = txt!,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: LoginSignupUtilities().constantTheme("Password"),
                validator: (password) =>
                    LoginSignupUtilities().passwordValidate(password!),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                onSaved: (txt) => _password = txt!,
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ForgotPasswordScreen.passwordResetRoute);
                },
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(
                      color: Color.fromRGBO(131, 142, 161, 1), fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              LoginSignupUtilities().styleButton(ElevatedButton(
                onPressed: validateNSignin,
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ))
            ],
          )),
    );
  }
}
