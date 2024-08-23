import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:wallify/data/hive_database.dart';

class AuthenticationProvider extends ChangeNotifier {
  // hive database
  final db = HiveDatabase();

  bool isAnonymousMode = false;

  // check anonymous mode
  // bool checkAnonymousMode() {
  //   isAnonymousMode = db.checkAnonymousMode();
  //   print("Anonymous mode set as: $isAnonymousMode");
  //   return isAnonymousMode;
  // }

  Future<bool> checkAnonymousMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAnonymousMode = prefs.getBool("isAnonymousMode") ?? false;
    return isAnonymousMode;
  }

  // change sign in mode
  // void changeAnonymousMode(bool changeModeAs) {
  //   db.changeAnonymousMode(changeModeAs);
  //   print("Anonymous mode changed to: $checkAnonymousMode()");
  //   notifyListeners(); // using after important change
  // }

  Future<void> changeAnonymousMode(bool changeModeAs) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isAnonymousMode", changeModeAs);
    // notifyListeners();
  }
}
