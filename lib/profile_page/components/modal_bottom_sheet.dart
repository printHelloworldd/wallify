// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wallify/generated/l10n.dart';
import 'package:wallify/provider/locale_provider.dart';

class ModalBottomSheet extends StatefulWidget {
  String currentLocale;

  ModalBottomSheet({
    super.key,
    required this.currentLocale,
  });

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            S.of(context).selectLanguage,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextButton(
              onPressed: () {
                setState(() {
                  // S.load(const Locale('en', 'GB'));
                  widget.currentLocale = "en";
                });
                localeProvider.setLocale(const Locale('en', 'GB'));
                Navigator.pop(context);
              },
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
                      return Colors
                          .grey[400]!; // Цвет фона при наведении и нажатии
                    }
                    return widget.currentLocale == "en_US" ||
                            widget.currentLocale ==
                                "en_GB" // TODO: Make this with switch statement like findSystemLocale
                        ? const Color(0xFF004864)
                        : Colors.transparent; // Ис,ходный цвет фона
                  },
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: widget.currentLocale == "en_US" ||
                              widget.currentLocale == "en_GB"
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "English",
                      style: TextStyle(
                        color: widget.currentLocale == "en_US" ||
                                widget.currentLocale == "en_GB"
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextButton(
              onPressed: () {
                setState(() {
                  // S.load(const Locale('ru'));
                  widget.currentLocale = "ru";
                });
                localeProvider.setLocale(const Locale('ru'));
                Navigator.pop(context);
              },
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
                      return Colors
                          .grey[400]!; // Цвет фона при наведении и нажатии
                    }
                    return widget.currentLocale == "ru_RU"
                        ? const Color(0xFF004864)
                        : Colors.transparent; // Исходный цвет фона
                  },
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: widget.currentLocale == "ru_RU"
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Русский",
                      style: TextStyle(
                        color: widget.currentLocale == "ru_RU"
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
