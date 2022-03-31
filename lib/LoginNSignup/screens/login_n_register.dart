import 'package:MyTime/LoginNSignup/widgets/login.dart';
import 'package:MyTime/LoginNSignup/widgets/register.dart';
import 'package:flutter/material.dart';

class LoginNRegisterScreen extends StatefulWidget {
  const LoginNRegisterScreen({Key? key}) : super(key: key);

  @override
  State<LoginNRegisterScreen> createState() => _LoginNRegisterScreenState();
}

class _LoginNRegisterScreenState extends State<LoginNRegisterScreen> {
  bool isSignup = true;
  String theTextAbove = "Already have an account?";
  String currentText = "Login here";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          loginOrSignup(),
          const Spacer(),
          bottomSingleWidget(),
        ],
      )),
    );
  }

  Widget bottomSingleWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          theTextAbove,
          style: const TextStyle(color: Color.fromRGBO(131, 142, 161, 1)),
        ),
        TextButton(
          onPressed: widgetChange,
          child: Text(currentText),
          style: TextButton.styleFrom(
            primary: const Color.fromRGBO(12, 22, 46, 1),
            padding: const EdgeInsets.all(5),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  widgetChange() {
    if (isSignup) {
      setState(() {
        isSignup = false;
      });
    } else {
      setState(() {
        isSignup = true;
      });
    }
  }

  Widget loginOrSignup() {
    if (isSignup) {
      setState(() {
        currentText = "Login here";
        theTextAbove = "Already have an account?";
      });
      return const RegisterWidget();
    }
    setState(() {
      currentText = "Sign up now";
      theTextAbove = "No account yet?";
    });
    return const LoginWidget();
  }
}
