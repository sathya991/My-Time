import 'package:MyTime/LoginNSignup/screens/login_n_register.dart';
import 'package:MyTime/MainPages/screens/dashboard.dart';
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
      title: 'My Time',
      theme: ThemeData(
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
      home: const LoginNRegisterScreen(),
      routes: {
        DashboardScreen.dashboardRoute: (context) => const DashboardScreen()
      },
    );
  }
}
