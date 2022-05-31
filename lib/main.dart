import 'package:MyTime/ExistingTimetableCreation/Screens/existing_creation_head_screen.dart';
import 'package:MyTime/LoginNSignup/screens/login_n_register.dart';
import 'package:MyTime/LoginNSignup/screens/password_reset.dart';
import 'package:MyTime/LoginNSignup/screens/password_reset_mail_sent.dart';
import 'package:MyTime/MainPages/widgets/dashboard.dart';
import 'package:MyTime/MainPages/screens/headscreen.dart';
import 'package:MyTime/MainPages/widgets/timetables.dart';
import 'package:MyTime/TimetableView/Screens/timetable_view.dart';
import 'package:MyTime/utilities/get_timetable_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Time',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
            bodyText1: GoogleFonts.rubik(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.1,
                fontSize: 17)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(340, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        )),
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginNRegisterScreen()
          : const HeadScreen(),
      initialRoute: '/',
      routes: {
        ForgotPasswordScreen.passwordResetRoute: (context) =>
            const ForgotPasswordScreen(),
        PasswordResetMailSent.passwordResetDoneRoute: (context) =>
            const PasswordResetMailSent(),
        HeadScreen.headScreenRoute: (context) => const HeadScreen(),
        ExistingCreationHeadScreen.existingCreationHeadScreenRoute: (context) =>
            const ExistingCreationHeadScreen(),
        GetTimetableName.getTTnameRoute: (context) => const GetTimetableName(),
        TimetableView.timetableViewRoute: (context) => const TimetableView(),
      },
    );
  }
}
