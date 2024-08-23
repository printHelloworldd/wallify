// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wallify/generated/l10n.dart';
import 'package:wallify/theme/theme.dart';
import 'package:wallify/theme/theme_provider.dart';

class SettingsTile extends StatefulWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.cacheSizeNotifier,
    this.changeLanguage,
    this.clearCache,
  });

  final dynamic icon;
  final String title;
  final String subtitle;
  final Function()? changeLanguage;
  final Function()? clearCache;
  final ValueNotifier<String> cacheSizeNotifier;

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  // @override
  // void initState() {
  //   super.initState();
  //   _selectedTheme =
  //       List<bool>.generate(themeSelections.length, (index) => false);
  // }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = Provider.of<ThemeProvider>(context).currentTheme;

    List<bool> selectedTheme = [
      themeProvider.isAutoMode,
      themeProvider.isAutoMode ? false : themeProvider.isDarkMode,
      themeProvider.isAutoMode ? false : !themeProvider.isDarkMode,
    ];

    List<Widget> themeSelections = <Widget>[
      const Text('Auto'),
      const Text('Dark'),
      const Text('Light'),
    ];

    List<List<dynamic>> colorThemes = [
      [
        const Color(0xFF004864),
        themeProvider.currentTheme.primaryColor == const Color(0xFF004864)
            ? true
            : false,
        "blue"
      ],
      [
        const Color(0xFF561C24),
        themeProvider.currentTheme.primaryColor == const Color(0xFF561C24)
            ? true
            : false,
        "red"
      ],
    ];

    return GestureDetector(
      child: ListTile(
        leading: widget.icon is IconData ? Icon(widget.icon) : widget.icon,
        title: Text(
          widget.title,
          style: TextStyle(
            // color: themeData == darkBlueTheme
            //     ? themeData.primaryColorLight
            //     : themeData.primaryColorDark,
            color: themeProvider.isDarkMode == true
                ? themeData.primaryColorLight
                : themeData.primaryColorDark,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.subtitle == S.of(context).cacheSize
                ? ValueListenableBuilder(
                    valueListenable: widget.cacheSizeNotifier,
                    builder: (context, cacheSize, child) =>
                        Text("${S.of(context).cacheSize}$cacheSize"),
                  )
                : Text(widget.subtitle),
            if (widget.title == S.of(context).appColorTheme)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: colorThemes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          themeProvider.toggleTheme(
                              themeProvider.isDarkMode, colorThemes[index][2]);
                          setState(() {
                            for (var i = 0; i < colorThemes.length; i++) {
                              colorThemes[i][1] = false;
                            }
                            colorThemes[index][1] = true;
                          });
                          print("${colorThemes[0][1]}, ${colorThemes[1][1]}");
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[400], // TODO: Change
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ClipOval(
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: colorThemes[index][0], // color theme
                                border: Border.all(
                                  color: Colors.grey[600]!, // TODO: Change
                                  width: 1.4,
                                ),
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: Icon(
                                Icons.check,
                                color: colorThemes[index][1]
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            if (widget.title == S.of(context).appColorTheme)
              ToggleButtons(
                // direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < selectedTheme.length; i++) {
                      selectedTheme[i] = false;
                    }
                    selectedTheme[index] = true;
                    switch (index) {
                      case 0:
                        print("You set auto mode");
                        if (themeProvider.currentTheme == darkBlueTheme ||
                            themeProvider.currentTheme == lightBlueTheme) {
                          themeProvider.setAutoMode(context, "blue");
                        } else if (themeProvider.currentTheme == darkRedTheme ||
                            themeProvider.currentTheme == lightRedTheme) {
                          themeProvider.setAutoMode(context, "red");
                        }
                        break;
                      case 1:
                        if (themeProvider.currentTheme == darkBlueTheme ||
                            themeProvider.currentTheme == lightBlueTheme) {
                          themeProvider.toggleTheme(true, "blue");
                        } else if (themeProvider.currentTheme == darkRedTheme ||
                            themeProvider.currentTheme == lightRedTheme) {
                          themeProvider.toggleTheme(true, "red");
                        }
                        break;
                      case 2:
                        if (themeProvider.currentTheme == darkBlueTheme ||
                            themeProvider.currentTheme == lightBlueTheme) {
                          themeProvider.toggleTheme(false, "blue");
                        } else if (themeProvider.currentTheme == darkRedTheme ||
                            themeProvider.currentTheme == lightRedTheme) {
                          themeProvider.toggleTheme(false, "red");
                        }
                        break;
                      default:
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                // selectedBorderColor: Color.fromARGB(255, 0, 51, 71),
                selectedColor: Colors.white, // TODO: Change
                fillColor: themeData.primaryColor,
                color: Colors.grey[700], // TODO: Change
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: selectedTheme,
                children: themeSelections,
              ),
          ],
        ),
      ),
      onTap: () {
        if (widget.title == S.of(context).language) widget.changeLanguage!();
        if (widget.title == S.of(context).clearCache) {
          widget.clearCache!();
        }
      },
    );
  }
}
