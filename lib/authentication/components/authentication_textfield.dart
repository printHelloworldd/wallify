// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AuthenticationTextField extends StatelessWidget {
  final controller;
  final bool obscureText;
  final String hintText;

  final lightTextFieldTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.grey.shade400,
      background: Colors.grey.shade200,
    ),
  );

  AuthenticationTextField({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: lightTextFieldTheme.colorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: lightTextFieldTheme.colorScheme.secondary),
          ),
          fillColor: lightTextFieldTheme.colorScheme.background,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
