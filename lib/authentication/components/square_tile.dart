// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;

  final lightSquareTileTheme = ThemeData(
    colorScheme: ColorScheme.light(
      background: Colors.grey[200]!,
      onBackground: Colors.white,
    ),
  );

  SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border:
            Border.all(color: lightSquareTileTheme.colorScheme.onBackground),
        borderRadius: BorderRadius.circular(16),
        color: lightSquareTileTheme.colorScheme.background,
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
