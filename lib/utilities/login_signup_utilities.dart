import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginSignupUtilities {
  final curUser = FirebaseAuth.instance.currentUser;

  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
  final shape2 = const StadiumBorder();
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

  usernameValidate(String userName) {
    if (userName.isEmpty) {
      return "Please enter a valid username";
    } else if (userName.length < 4 || userName.length > 12) {
      return "Username length should be between 4 and 12 letters";
    } else if (userName.contains(" ")) {
      return "Username must not contain spaces";
    }
    return null;
  }

  ttNameValidate(String userName) {
    if (userName.isEmpty) {
      return "Please enter a valid Timetable name";
    } else if (userName.length < 2 || userName.length > 16) {
      return "Username length should be between 3 and 16 letters";
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
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return "Please enter a password";
    }
    if (!regex.hasMatch(password)) {
      return "Password should contain\n * One upper case character \n * One lower case character\n * One digit\n * One special character\n * Must be atleast 8 characters long";
    }
    return null;
  }

//Theme for input boxes in login and signup
  InputDecoration constantTheme(String text) {
    return InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(5, 10, 60, 1), width: 2.0)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: text);
  }

  InputDecoration constantThemeWithDarkBG(String text) {
    return InputDecoration(
        hintStyle: GoogleFonts.rubik(
            fontSize: 18, color: Colors.white, fontStyle: FontStyle.italic),
        focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(5, 10, 60, 1), width: 2.0)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: text);
  }

  //Theme for submit button in login and signup
  styleButton(Widget button) {
    return Container(
      decoration: ShapeDecoration(
          shape: shape,
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(0, 4, 40, 1),
            Color.fromRGBO(0, 78, 146, 1)
          ])),
      child: button,
    );
  }

  styleRoundedButton(Widget button) {
    return Container(
      decoration: ShapeDecoration(
          shape: shape2,
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(0, 4, 40, 1),
            Color.fromRGBO(0, 78, 146, 1)
          ])),
      child: button,
    );
  }
}
