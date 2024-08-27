import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightBlueTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey[300],
  primaryColor: const Color(0xFF004864),
  primaryColorLight: Colors.grey[700],
  primaryColorDark: Colors.black,
  dividerColor: Colors.grey[400],
  hoverColor: Colors.grey[400],
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
      fontSize: 32,
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
  dialogTheme: DialogTheme(
    backgroundColor: Colors.grey[300],
  ),
  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     textStyle: const TextStyle(color: Color(0xFF004864)),
  //   ),
  // ),
);

final darkBlueTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[900],
  primaryColor: const Color(0xFF004864),
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.grey[500],
  dividerColor: Colors.grey[400],
  hoverColor: Colors.grey[800],
  textTheme: TextTheme(
    titleLarge: GoogleFonts.oswald(
      fontWeight: FontWeight.w500,
      fontSize: 36,
      color: Colors.white,
    ),
    displayLarge: GoogleFonts.oswald(
      fontWeight: FontWeight.w500,
      fontSize: 36,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.oswald(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF004864),
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      color: Colors.grey[400],
    ),
    labelSmall: TextStyle(
      color: Colors.grey[400],
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
      colorScheme: ColorScheme.dark(
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
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.black,
  ),
  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     textStyle: const TextStyle(color: Color(0xFF004864)),
  //   ),
  // ),
);

final lightRedTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFE8DBC4),
  primaryColor: const Color(0xFF561C24),
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.black,
  dividerColor: const Color(0xFFC7B7A3),
  hoverColor: const Color(0xFFC7B7A3),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.oswald(
      fontWeight: FontWeight.w500,
      fontSize: 36,
      color: const Color(0xFF561C24),
    ),
    displayLarge: GoogleFonts.oswald(
        fontWeight: FontWeight.w500,
        fontSize: 36,
        color: const Color(0xFF561C24)),
    titleMedium: GoogleFonts.oswald(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF561C24),
    ),
    titleSmall: const TextStyle(
      fontSize: 20,
      color: Color(0xFF6d2932),
    ),
    labelSmall: const TextStyle(
      color: Color(0xFF6d2932),
    ),
    labelMedium: const TextStyle(
      color: Color.fromARGB(255, 108, 58, 64),
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
      colorScheme: ColorScheme.dark(
    primary: Color(0xFF561C24),
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.black,
  )),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xFF561C24), // Цвет индикатора загрузки
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color(0xFF561C24), // Цвет курсора в поле ввода
    selectionColor:
        const Color(0xFF561C24).withOpacity(0.3), // Цвет выделения текста
    selectionHandleColor:
        const Color(0xFF561C24), // Цвет ручки выделения текста
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
  ),
  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     textStyle: const TextStyle(color: Color(0xFF004864)),
  //   ),
  // ),
);

final darkRedTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 47, 9, 14),
  primaryColor: const Color(0xFF561C24),
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.black,
  dividerColor: const Color(0xFFC7B7A3),
  hoverColor: const Color.fromARGB(255, 165, 72, 84),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.oswald(
      fontWeight: FontWeight.w500,
      fontSize: 36,
      color: const Color.fromARGB(255, 165, 72, 84),
    ),
    displayLarge: GoogleFonts.oswald(
      fontWeight: FontWeight.w500,
      fontSize: 36,
      color: const Color.fromARGB(255, 165, 72, 84),
    ),
    titleMedium: GoogleFonts.oswald(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: const Color.fromARGB(255, 165, 72, 84),
    ),
    titleSmall: const TextStyle(
      fontSize: 20,
      color: Color.fromARGB(255, 165, 72, 84),
    ),
    labelSmall: const TextStyle(
      color: Color.fromARGB(255, 165, 72, 84),
    ),
    labelMedium: const TextStyle(
      color: Color(0xff6d2932),
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
      colorScheme: ColorScheme.dark(
    primary: Color(0xFF561C24),
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.black,
  )),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xFF561C24), // Цвет индикатора загрузки
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color(0xFF561C24), // Цвет курсора в поле ввода
    selectionColor:
        const Color(0xFF561C24).withOpacity(0.3), // Цвет выделения текста
    selectionHandleColor:
        const Color(0xFF561C24), // Цвет ручки выделения текста
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF561C24),
  ),
  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     textStyle: const TextStyle(color: Color(0xFF004864)),
  //   ),
  // ),
);
