import 'package:flutter/material.dart';
import 'package:wallify/profile_page/components/settings_tile.dart';
import 'package:wallify/theme/theme.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  List<List<dynamic>> settingsTiles = [
    [Icons.language, "Language", "System default: English"],
    [Icons.palette, "App color theme", "Try another look"],
    [
      Icons.history,
      "Clear search history",
      "This deletes all of your search history data"
    ],
    [
      const ImageIcon(
        AssetImage("assets/icons/broom.png"),
        size: 24,
      ),
      "Clear cache",
      "Cache size: 18 MB"
    ],
    [
      Icons.settings_backup_restore,
      "Reset all settings",
      "Does more than uninstalling would do, \n because the preferences are stored \n at a special place as they have to be \n accessible directly after device startup"
    ],
    [Icons.system_update, "App version", "3.1.5"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: settingsTiles.length,
                  itemBuilder: (context, index) {
                    return SettingsTile(
                      icon: settingsTiles[index][0],
                      title: settingsTiles[index][1],
                      subtitle: settingsTiles[index][2],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
