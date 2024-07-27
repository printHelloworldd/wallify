import 'package:flutter/material.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/profile_page/components/settings_tile.dart';
import 'package:wallify/theme/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  var systemDefaultLang = "English";
  var cacheSize = 18;

  void changeLanguage() {}

  @override
  Widget build(BuildContext context) {
      List<List<dynamic>> settingsTiles = [
      [Icons.language, S.of(context).language, S.of(context).systemDefaultLang(systemDefaultLang)],
      [Icons.palette, S.of(context).appColorTheme, S.of(context).tryAnotherLook],
      [
        Icons.history,
        S.of(context).clearSearchHistory,
        S.of(context).thisDeletesAllOfYourSearchHistoryData
      ],
      [
        const ImageIcon(
          AssetImage("assets/icons/broom.png"),
          size: 24,
        ),
        S.of(context).clearCache,
        S.of(context).cacheSize(cacheSize),
      ],
      [
        Icons.settings_backup_restore,
        S.of(context).resetAllSettings,
        S.of(context).resetAllSettingsDesc
      ],
      [Icons.system_update, S.of(context).appVersion, "3.1.5"],
    ];
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
        title: Text(
          S.of(context).settings,
          style: const TextStyle(
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
                      changeLanguage: () => changeLanguage(),
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
