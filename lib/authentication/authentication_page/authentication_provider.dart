import 'package:flutter/material.dart';
import 'package:wallify/data/hive_database.dart';

class AuthenticationProvider extends ChangeNotifier {
  // hive database
  final db = HiveDatabase();

  bool isAnonymousMode = false;

  // check anonymous mode
  bool checkAnonymousMode() {
    isAnonymousMode = db.checkAnonymousMode();
    print("Anonymous mode set as: $isAnonymousMode");
    return isAnonymousMode;
  }

  // change sign in mode
  void changeAnonymousMode(bool changeModeAs) {
    db.changeAnonymousMode(changeModeAs);
    print("Anonymous mode changed to: $checkAnonymousMode()");
    notifyListeners(); // using after important change
  }
}
