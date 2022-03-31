import 'package:MyTime/MainPages/screens/dashboard.dart';
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
    String _phone = "";
    String _password = "";

    validateNRegister() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(value.user!.uid)
              .set({'email': _email, 'phone': _phone}).then((value) {
            Navigator.of(context).pushNamed(DashboardScreen.dashboardRoute);
          });
        });
      }
    }

    emailValidate(String email) {
      if (email.isEmpty) {
        return "Please enter a valid email";
      }
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (!emailValid) {
        return "Please enter a valid email";
      }
      return null;
    }

    phoneValidate(String phone) {
      if (phone.length != 10 || phone.isEmpty) {
        return "Enter a valid mobile number";
      }
      return null;
    }

    passwordValidate(String password) {
      RegExp regex = RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      if (password.isEmpty) {
        return "Please enter a password";
      }
      if (!regex.hasMatch(password)) {
        return "Password should contain\n * One upper case character \n * One lower case character\n * One digit\n * One special character\n * Must be atleast 8 characters long";
      }
      return null;
    }

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
                decoration: constantTheme("Email"),
                validator: (txt) => LoginSignupUtilities().emailValidate(txt!),
                onSaved: (txt) => _email = txt!,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: constantTheme("Phone"),
                validator: (phone) => phoneValidate(phone!),
                keyboardType: TextInputType.number,
                onSaved: (txt) => _phone = txt!,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: constantTheme("Password"),
                validator: (password) => passwordValidate(password!),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                onSaved: (txt) => _password = txt!,
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
                  onPressed: validateNRegister,
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
