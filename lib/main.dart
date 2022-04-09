import 'package:MyTime/LoginNSignup/screens/login_n_register.dart';
import 'package:MyTime/LoginNSignup/screens/password_reset.dart';
import 'package:MyTime/LoginNSignup/screens/password_reset_mail_sent.dart';
import 'package:MyTime/MainPages/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "My Time",
      options: const FirebaseOptions(
          apiKey: "AIzaSyDgv9oiqYDamE2olcLgXy3JzV7akznIUrM",
          appId: "1:695523865700:android:a3384e17fe26962b3b5b71",
          messagingSenderId: "695523865700",
          projectId: "my-time-944eb",
          storageBucket: 'gs://my-time-944eb.appspot.com'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          : const DashboardScreen(),
      initialRoute: '/',
      routes: {
        DashboardScreen.dashboardRoute: (context) => const DashboardScreen(),
        ForgotPasswordScreen.passwordResetRoute: (context) =>
            const ForgotPasswordScreen(),
        PasswordResetMailSent.passwordResetDoneRoute: (context) =>
            const PasswordResetMailSent(),
      },
    );
  }
}
