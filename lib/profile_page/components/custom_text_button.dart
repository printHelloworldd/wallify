// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
              return Colors.grey[400]!; // Цвет фона при наведении и нажатии
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
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(icon, color: Colors.grey[700]),
          ],
        ),
      ),
    );
  }
}
