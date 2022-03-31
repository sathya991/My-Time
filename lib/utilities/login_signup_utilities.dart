import 'package:flutter/material.dart';

class LoginSignupUtilities {
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
}
