import 'package:MyTime/MainPages/widgets/dashboard.dart';
import 'package:MyTime/MainPages/screens/headscreen.dart';
import 'package:MyTime/utilities/login_signup_utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _email = "";
    String _username = "";
    String _phone = "";
    String _password = "";

    //Validating and Registering user
    validateNRegister() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email.trim(), password: _password.trim())
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(value.user?.uid)
              .set({
            'email': _email,
            'phone': _phone,
            'username': _username,
            'profPic': "",
            'curTT': "",
          }).then((value) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HeadScreen.headScreenRoute, ModalRoute.withName('/'),
                arguments: "Register");
          });
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
                "Register",
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
                decoration: LoginSignupUtilities().constantTheme("Username"),
                validator: (username) =>
                    LoginSignupUtilities().usernameValidate(username!),
                onSaved: (txt) => _username = txt!,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: LoginSignupUtilities().constantTheme("Phone"),
                validator: (phone) =>
                    LoginSignupUtilities().phoneValidate(phone!),
                keyboardType: TextInputType.number,
                onSaved: (txt) => _phone = txt!,
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
                height: 25,
              ),
              LoginSignupUtilities().styleButton(ElevatedButton(
                onPressed: validateNRegister,
                child: Text(
                  "Register",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ))
            ],
          )),
    );
  }
}
