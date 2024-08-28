import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallify/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = lightBlueTheme;
  bool _isDarkMode = false;
  bool _isAutoMode = true;

  ThemeProvider() {
    _loadFromPrefs();
  }

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;
  bool get isAutoMode => _isAutoMode;

  void toggleTheme(bool isDark, String theme) {
    print("$isDark, $theme");
    _isDarkMode = isDark;
    _isAutoMode = false;
    _currentTheme = _getThemeData(theme);
    _saveToPrefs(theme);
    notifyListeners();
  }

  void setSystemTheme(BuildContext context, {String? theme}) {
    print("Theme to set system theme: $theme");
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    if (_isAutoMode) {
      _isDarkMode = brightness == Brightness.dark;
      _currentTheme = _getThemeData(theme ??
          "blue"); // TODO: Get theme from loadPrefs method or make theme global variable
      // notifyListeners();
    }
  }

  void setAutoMode(BuildContext context, String theme) {
    _isAutoMode = true;
    setSystemTheme(context, theme: theme);
    _saveToPrefs(theme);
    notifyListeners();
  }

  ThemeData _getThemeData(String theme) {
    switch (theme) {
      case "blue":
        return _isDarkMode ? darkBlueTheme : lightBlueTheme;
      case "red":
        return _isDarkMode ? darkRedTheme : lightRedTheme;
      default:
        return _isDarkMode ? ThemeData.dark() : ThemeData.light();
    }
  }

  Future<void> _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString("theme") ?? "blue";
    print("theme: $theme");
    _isDarkMode = prefs.getBool("isDarkMode") ?? false;
    print("Dark mode: $_isDarkMode");
    _currentTheme = _getThemeData(theme);
    _isAutoMode = prefs.getBool("isAutoMode") ?? true;
    notifyListeners();
  }

  Future<void> _saveToPrefs(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", theme);
    await prefs.setBool("isDarkMode", _isDarkMode);
    await prefs.setBool("isAutoMode", _isAutoMode);
  }

  // ThemeData get themeData {
  //   // return _isDarkMode ? darkBlueTheme : lightBlueTheme;
  //   return lightRedTheme;
  // }
}
