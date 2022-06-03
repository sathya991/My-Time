import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BasicUtilities {
  User? curUser() => FirebaseAuth.instance.currentUser;

  int toMinutes(TimeOfDay myTime) {
    return ((myTime.hour * 60) + myTime.minute);
  }

  TimeOfDay stringToTime(String time) {
    return TimeOfDay(
        hour: int.parse(time.toString().substring(0, 2)),
        minute: int.parse(time.toString().substring(3)));
  }
}
