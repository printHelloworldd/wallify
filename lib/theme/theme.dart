import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey[300],
  primaryColor: const Color(0xFF004864),
  dividerColor: Colors.grey[400],
  textTheme: TextTheme(
    titleLarge: GoogleFonts.oswald(
      fontWeight: FontWeight.w500,
      fontSize: 36,
      color: Colors.white,
    ),
    displayLarge: GoogleFonts.oswald(
      fontWeight: FontWeight.w500,
      fontSize: 36,
    ),
    titleMedium: GoogleFonts.oswald(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF004864),
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      color: Colors.grey[700],
    ),
    labelSmall: TextStyle(
      color: Colors.grey[700],
    ),
    labelMedium: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 14.0,
      color: Colors.grey[500],
      fontWeight: FontWeight.normal,
      fontFamily: "Roboto",
    ), // hintText style
  ),
  buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.light(
    primary: Color(0xFF004864),
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.black,
  )),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xFF004864), // Цвет индикатора загрузки
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color(0xFF004864), // Цвет курсора в поле ввода
    selectionColor:
        const Color(0xFF004864).withOpacity(0.3), // Цвет выделения текста
    selectionHandleColor:
        const Color(0xFF004864), // Цвет ручки выделения текста
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
);
