import 'package:flutter/material.dart';
import 'package:intl/find_locale.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallify/generated/l10n.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  LocaleProvider() {
    _loadFromPrefs();
  }

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    S.load(_locale);
    _saveToPrefs();
    notifyListeners();
  }

  void setSystemLocale() {
    findSystemLocale().then((value) {
      switch (value) {
        case "ru_RU":
          setLocale(Locale(value));
          break;
        case "en_US":
          setLocale(Locale(value));
          break;
        case "en_GB":
          setLocale(Locale(value));
          break;
        default:
          setLocale(const Locale("en_GB"));
      }
    });
  }

  void _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("locale") == null) {
      setSystemLocale();
    } else {
      String? locale = prefs.getString("locale");
      setLocale(Locale(locale!));
    }
  }

  void _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("locale", _locale.toString());
  }
}
