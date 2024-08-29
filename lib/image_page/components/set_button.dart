// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:wallify/generated/l10n.dart';

class SetButton extends StatelessWidget {
  final Function(int screen) setWallpaper;
  final ThemeData themeData;
  final ColorScheme lightButtonTheme;

  const SetButton({
    super.key,
    required this.setWallpaper,
    required this.themeData,
    required this.lightButtonTheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.grey[300], // TODO: Change to global theme
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              height: MediaQuery.of(context).size.height / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      setWallpaper(0);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      padding:
                          WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      backgroundColor: WidgetStateColor.resolveWith(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.hovered) ||
                              states.contains(WidgetState.pressed)) {
                            return Colors.grey[
                                400]!; // Цвет фона при наведении и нажатии
                          }
                          return Colors.transparent; // Исходный цвет фона
                        },
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phone_android,
                                  color: themeData.primaryColor),
                              const SizedBox(width: 10),
                              Text(
                                S.of(context).homeScreen,
                                style: TextStyle(
                                  color: themeData.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setWallpaper(1);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      padding:
                          WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      backgroundColor: WidgetStateColor.resolveWith(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.hovered) ||
                              states.contains(WidgetState.pressed)) {
                            return Colors.grey[
                                400]!; // Цвет фона при наведении и нажатии
                          }
                          return Colors.transparent; // Исходный цвет фона
                        },
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phonelink_lock,
                                  color: themeData.primaryColor),
                              const SizedBox(width: 10),
                              Text(
                                S.of(context).lockScreen,
                                style: TextStyle(
                                  color: themeData.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setWallpaper(2);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      padding:
                          WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      backgroundColor: WidgetStateColor.resolveWith(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.hovered) ||
                              states.contains(WidgetState.pressed)) {
                            return Colors.grey[
                                400]!; // Цвет фона при наведении и нажатии
                          }
                          return Colors.transparent; // Исходный цвет фона
                        },
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.content_copy,
                                  color: themeData.primaryColor),
                              const SizedBox(width: 10),
                              Text(
                                S.of(context).homeAndLockScreens,
                                style: TextStyle(
                                  color: themeData.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
        decoration: BoxDecoration(
          color: lightButtonTheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                S.of(context).set,
                style: TextStyle(
                  color: lightButtonTheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.install_mobile,
                color: lightButtonTheme.onPrimary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
