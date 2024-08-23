// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallify/theme/theme.dart';
import 'package:wallify/theme/theme_provider.dart';

class CustomTextButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final IconData icon;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = Provider.of<ThemeProvider>(context).currentTheme;

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        backgroundColor: WidgetStateColor.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.pressed)) {
              return themeData.hoverColor; // Цвет фона при наведении и нажатии
            }
            return Colors.transparent; // Исходный цвет фона
          },
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: themeProvider.isDarkMode == true
                    ? themeData.primaryColorLight
                    : themeData.primaryColorDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              icon,
              /* color: themeData == darkBlueTheme
                    ? themeData.primaryColorDark
                    : themeData.primaryColorLight */
              color: themeProvider.isDarkMode == true
                  ? themeData.primaryColorLight
                  : themeData.primaryColorDark,
            ),
          ],
        ),
      ),
    );
  }
}
