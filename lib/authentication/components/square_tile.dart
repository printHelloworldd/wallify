// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  final lightSquareTileTheme = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.grey[200]!,
      onSurface: Colors.white,
    ),
  );

  SquareTile({
    super.key,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border:
              Border.all(color: lightSquareTileTheme.colorScheme.onSurface),
          borderRadius: BorderRadius.circular(16),
          color: lightSquareTileTheme.colorScheme.surface,
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
